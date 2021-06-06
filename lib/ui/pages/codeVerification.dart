import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shoppesta/bloc/login/bloc.dart';
import 'package:shoppesta/repositories/userRepository.dart';
import 'package:shoppesta/ui/widgets/codeVerificationForm.dart';

class CodeVerification extends StatelessWidget {
  final UserRepository _userRepository;
  final String num;
  Position currentPosition;

  CodeVerification(
      {@required UserRepository userRepository, this.num, this.currentPosition})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          userRepository: _userRepository,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'Phone Number Verification',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  text: "Enter the code sent to ",
                  children: [
                    TextSpan(
                        text: "${num}",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ],
                  style: TextStyle(color: Colors.red, fontSize: 15)),
              textAlign: TextAlign.center,
            ),
            CodeVerificationForm(
              userRepository: _userRepository,
            ),
          ],
        ),
      ),
    );
  }
}
