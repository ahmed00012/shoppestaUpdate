import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
  @override
  List<Object> get props => [];
}

class ProductsListInitialState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  final Stream<QuerySnapshot> productStream;

  ProductsLoadedState({this.productStream});

  @override
  List<Object> get props => [productStream];
}