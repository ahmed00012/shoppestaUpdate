import 'package:meta/meta.dart';

@immutable
class LoginState {

  final bool isNumEmpty;
  bool isSubmitting;
  bool isSuccess;
  bool isFailure;

  bool get isFormValid =>
          isNumEmpty ;


  LoginState(
      {
        @required this.isNumEmpty,
        @required this.isSubmitting,
        @required this.isSuccess,
        @required this.isFailure});

  //initial state
  factory LoginState.empty() {
    return LoginState(
      isNumEmpty: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isNumEmpty: false,
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(

      isNumEmpty: false,
      isSubmitting: false,
      isFailure: true,
      isSuccess: false,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isNumEmpty: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: true,
    );
  }



  LoginState copyWith({
    bool isNumEmpty,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return LoginState(

        isNumEmpty: isNumEmpty ?? this.isNumEmpty,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

}