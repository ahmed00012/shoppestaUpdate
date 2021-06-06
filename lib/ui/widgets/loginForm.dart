import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppesta/bloc/authentication/authentication_bloc.dart';
import 'package:shoppesta/bloc/authentication/bloc.dart';
import 'package:shoppesta/bloc/login/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shoppesta/repositories/productRepository.dart';
import 'package:shoppesta/repositories/userRepository.dart';
import 'package:shoppesta/ui/pages/codeVerification.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;
  final ProductRepository productRepository;
  LoginForm({@required UserRepository userRepository,this.productRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _num = TextEditingController();
  GeoPoint location;
  LoginBloc _loginBloc;
  bool seePassword = false;

  Position _currentPosition;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  bool password() {
    seePassword = !seePassword;
    return seePassword;
  }

  _getLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        location = new GeoPoint(position.latitude, position.longitude);
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
    } catch (e) {
      print(e);
    }
  }

  _onSubmit() async {
    _loginBloc.add(LoginWithCredentialsPressed(num: _num.text));
  }

  @override
  void initState() {
    _getLocation();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  bool isButtonEnabled(LoginState state) {
    return !state.isSubmitting;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, LoginState state) {
      if (state.isFailure)
        return Text('failed');
      else if (state.isSubmitting)
        return CircularProgressIndicator();
      else if (state.isSuccess) {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        print('success');
        // Navigator.of(context).pop();
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              child: Image.asset(
                'assets/2.jpeg',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: size.height,
              width: size.width,
              color: Colors.red.withOpacity(0.7),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    'Shoppesta',
                    style: GoogleFonts.courgette(
                        fontSize: 40, color: Colors.white),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      child:Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.6),
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: TextFormField(
                            controller: _num,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone number (+20 xxx xxx xxxx )',
                              labelStyle: TextStyle(color: Colors.black),
                              icon: Icon(Icons.phone_iphone,color: Colors.black,),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.transparent, width: 1.0),
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.transparent, width: 1.0),
                              ),
                            ),

                          ),
                        ),
                      ),
                    )
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async{
                     await _onSubmit();

                     Navigator.push(context,
                         MaterialPageRoute(builder:
                         (context)=>CodeVerification(userRepository: widget._userRepository,
                         currentPosition: _currentPosition,
                         num: _num.text,)
                         ));
                    },
                    child: Container(
                      width: size.width * 0.7,
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color:  Colors.white.withOpacity(0.8),
                        borderRadius:
                        BorderRadius.circular(size.height * 0.05),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: size.height * 0.025,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      );
    }));
  }
}
