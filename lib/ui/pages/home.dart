import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppesta/bloc/authentication/bloc.dart';
import 'package:shoppesta/repositories/userRepository.dart';
import 'package:shoppesta/ui/pages/login.dart';
import 'package:shoppesta/ui/pages/splash.dart';
import 'package:shoppesta/ui/widgets/loginForm.dart';





class Home extends StatelessWidget {
  final UserRepository _userRepository = UserRepository() ;

  // Home({@required UserRepository userRepository})
  //     : assert(userRepository != null),
  //       _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return Splash();
          }
          if (state is Authenticated) {


            return Container(
              color: Colors.red,
              child: Text('logged in'),
            );
          }
          if (state is AuthenticatedButNotSet) {
            return Login(
             userRepository: _userRepository
            );
          }
          if (state is Unauthenticated) {
            return Login(
                userRepository: _userRepository
            );
          } else
            return Container();
        },
      ),
    );
  }
}