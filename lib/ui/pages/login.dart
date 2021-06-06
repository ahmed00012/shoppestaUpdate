import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppesta/bloc/login/bloc.dart';
import 'package:shoppesta/repositories/userRepository.dart';
import 'package:shoppesta/ui/widgets/loginForm.dart';


class Login extends StatelessWidget {
  final UserRepository _userRepository;

  Login({@required UserRepository userRepository})
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
        child: LoginForm(
          userRepository: _userRepository,
        ),
      ),
    );
  }
}
