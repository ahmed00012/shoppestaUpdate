import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppesta/repositories/userRepository.dart';
import 'package:shoppesta/ui/pages/home.dart';



import 'bloc/authentication/bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final UserRepository _userRepository = UserRepository();



  runApp(BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: _userRepository)
        ..add(AppStarted()),
      child: Home()));
}
