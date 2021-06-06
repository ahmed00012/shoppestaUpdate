import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shoppesta/bloc/login/bloc.dart';
import 'package:shoppesta/repositories/productRepository.dart';
import 'package:shoppesta/repositories/userRepository.dart';

import 'signup_event.dart';
import 'signup_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;
  final ProductRepository _productRepository;

  LoginBloc({@required UserRepository userRepository,@required ProductRepository productRepository})
      : assert(userRepository != null, productRepository!=null),
        _userRepository = userRepository,
        _productRepository = productRepository;

  @override
  LoginState get initialState => LoginState.empty();


  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* {
     if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          num: event.num);

    }

     else if (event is Submitted) {
       final uid = await _userRepository.getUser();
       yield* _mapSubmittedToState(
           userId: uid,
           location: event.location,
           num: event.num);
     }
     else if(event is GetVerificationCode)
       yield* _mapGetVerificationCodeToState(
         code: event.code
       );
  }


  Stream<LoginState> _mapSubmittedToState(
      {

        String userId,
        GeoPoint location,
        String num
      }) async* {
    yield LoginState.loading();
    try {

      await _userRepository.profileSetup(userId,location,num);

      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }


  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String num,
  }) async* {

    yield LoginState.loading();

    try {

      await _userRepository.authentication(num);


      yield LoginState.success();
    } catch (_) {
      LoginState.failure();
    }
  }


  Stream<LoginState> _mapGetVerificationCodeToState({
    String code,
  }) async* {
    yield LoginState.loading();

    try {

      await _userRepository.submitOTP(code);


      yield LoginState.success();
    } catch (_) {
      LoginState.failure();
    }
  }
}