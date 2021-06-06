import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}


class Submitted extends LoginEvent {
  final String num;
  final GeoPoint location;

  Submitted({this.num,this.location});

  @override
  List<Object> get props => [num,location];
}



class LoginWithCredentialsPressed extends LoginEvent {

  final String num;


  LoginWithCredentialsPressed({@required this.num});

  @override
  List<Object> get props => [num];
}


class GetVerificationCode extends LoginEvent {

  final String code;


  GetVerificationCode({@required this.code});

  @override
  List<Object> get props => [code];
}