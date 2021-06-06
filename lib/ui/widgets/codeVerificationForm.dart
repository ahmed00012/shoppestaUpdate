import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shoppesta/bloc/authentication/authentication_event.dart';
import 'package:shoppesta/bloc/authentication/bloc.dart';
import 'package:shoppesta/bloc/login/bloc.dart';
import 'package:shoppesta/repositories/productRepository.dart';
import 'package:shoppesta/repositories/userRepository.dart';

class CodeVerificationForm extends StatefulWidget {
  final UserRepository _userRepository;

  final String num;
  Position currentPosition;
  CodeVerificationForm(
      {@required UserRepository userRepository,
        this.num, this.currentPosition})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  _CodeVerificationFormState createState() => _CodeVerificationFormState();
}

class _CodeVerificationFormState extends State<CodeVerificationForm> {
  TextEditingController _code = TextEditingController();
  String currentText = '';
  LoginBloc _loginBloc;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final ProductRepository productRepository = ProductRepository();
  String productsLength;

  _onSubmit(String code) async {
    _loginBloc.add(GetVerificationCode(code: code));

    await _loginBloc.add(Submitted(
        num: widget.num,
        location: new GeoPoint(widget.currentPosition.latitude,
            widget.currentPosition.longitude)));
  }
   length()async{
    await productRepository.storeId();
    return await productRepository.productId();
  }

  setLength(){
    length().then((val) => setState(() {
      print(val);
    }));

  }
  @override
  void initState() {
setLength();

    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, LoginState state) {
      if (state.isFailure)
        return Text('failed');
      else if (state.isSubmitting)
        return CircularProgressIndicator();
      else if (state.isSuccess) {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        print('success');

      }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: PinCodeTextField(
          controller: _code,
          appContext: context,
          animationType: AnimationType.fade,
          length: 6,
          autoDisposeControllers: true,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            print(value);
            setState(() {
              currentText = value;
            });
          },
          onSubmitted: (value) => _onSubmit(value),
          onCompleted: (value) => _onSubmit(value),
        ),
      );
    }));
  }
}
