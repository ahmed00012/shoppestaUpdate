import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final Firestore _firestore;
   AuthCredential _phoneAuthCredential;
  FirebaseUser _firebaseUser;
  String _verificationId;
  int _code;

  UserRepository({FirebaseAuth firebaseAuth, Firestore firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? Firestore.instance;

Future<void> authentication(String phone)async{

  return await _firebaseAuth.verifyPhoneNumber(
    phoneNumber: phone,
    verificationCompleted: (AuthCredential phoneAuthCredential) async{
      this._phoneAuthCredential = phoneAuthCredential;
      await _firebaseAuth.signInWithCredential(phoneAuthCredential);

    },
    verificationFailed: (AuthException error) {

      if (error.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }

    },
    codeSent: (String verificationId, [int code]){
      this._verificationId = verificationId;
      this._code = code;
      print('codeSent');
      print(verificationId);
      print(code);
    },
    codeAutoRetrievalTimeout: (String verificationId) {

    }, timeout:(Duration(seconds: 20)),

  );


}


   submitOTP(String code) {
    String smsCode = code ;
    print(_verificationId);
    this._phoneAuthCredential = PhoneAuthProvider.getCredential(
        smsCode: smsCode,
      verificationId: _verificationId
    );

    login();
  }

  Future<void> login() async {

    try {
      await FirebaseAuth.instance
          .signInWithCredential(this._phoneAuthCredential)
          .then((AuthResult authRes) {
        _firebaseUser = authRes.user;
        print(_firebaseUser.toString());
      }).catchError((e) => print(e.message));

    } catch (e) {
      print(e.message);
    }
  }


  Future<bool> isFirstTime(String userId) async {
    bool exist;
    await Firestore.instance
        .collection('users')
        .document(userId)
        .get()
        .then((user) {
      exist = user.exists;
    });

    return exist;
  }



  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  //profile setup
  Future<void> profileSetup(
      String userId,
      GeoPoint location,
      String num) async {
       return await _firestore.collection('users2').document(userId).setData({
          'uid': userId,
          "location": location,
          "number": num
        });

  }
}