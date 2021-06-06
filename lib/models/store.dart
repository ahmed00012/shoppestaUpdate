

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppesta/models/products.dart';

class StoreModel{
  String name;
  String num;
  String uid;
  GeoPoint location;
  String photo;
  List<ProductModel> products;




  StoreModel({this.name, this.uid,this.num,
    this.location,this.photo});
}