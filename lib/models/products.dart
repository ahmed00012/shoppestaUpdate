import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{

  String name;
  String id;
  List<String> images;
  String category;
  String gender;
  double price;
  List<String> sizes;
  String mainImage;
  int likesCounter;

  ProductModel(
      {this.name,
        this.id,
        this.images,
        this.category,
        this.gender,
        this.price,
        this.sizes,
        this.mainImage,
        this.likesCounter});
}