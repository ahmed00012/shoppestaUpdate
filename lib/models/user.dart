import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppesta/models/products.dart';

class UserModel{
  String uid;
  String phone;
  GeoPoint location;
  ProductModel orders;
}