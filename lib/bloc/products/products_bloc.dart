import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:shoppesta/repositories/productRepository.dart';
import 'bloc.dart';


class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductRepository _productRepository;

  ProductsBloc({@required ProductRepository productRepository})
      : assert(productRepository != null),
        _productRepository = productRepository;

  @override
  ProductsState get initialState => ProductsListInitialState();

  @override
  Stream<ProductsState> mapEventToState(
      ProductsEvent event,
      ) async* {
    if (event is ProductStreamEvent) {
      // yield* _mapStreamToState(currentStoreId: event.currentStoreId);
    }
  }

  // Stream<ProductsState> _mapStreamToState({String currentStoreId}) async* {
  //   yield ProductsLoadingState();
  //
  //
  //   Stream<QuerySnapshot> productStream =
  //   _productRepository.getProducts(storeId: currentStoreId);
  //   yield ProductsLoadedState(productStream: productStream);
  // }
}