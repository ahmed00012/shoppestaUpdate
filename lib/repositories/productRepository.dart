import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppesta/models/products.dart';
import 'package:shoppesta/models/store.dart';

class ProductRepository {
  final Firestore _firestore;

  ProductRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  Future<List<String>> storeId() async {
    List<String> storeId = List<String>();
    await _firestore.collection('users').getDocuments().then((value) {
      value.documents.forEach((element) {
        storeId.add(element.documentID);
      });
    });
    return storeId;
  }

  Future<List<String>> productId() async {
    List<String> productId = [];
    QuerySnapshot result;
    List<DocumentSnapshot> documents;
    var store = await storeId();

    await Future.forEach(store, (elem) async {
      result = await _firestore
          .collection('users')
          .document(elem)
          .collection('products')
          .getDocuments();
      documents = result.documents;
      documents.forEach((data) {
        productId.add(data.documentID);
      });
    });

    return productId;
  }

  Future<StoreModel> getStoreDetail() async {
    StoreModel _store = StoreModel();
    ProductModel _product = ProductModel();

    List sizes;
    List images;
    List<ProductModel> products = List<ProductModel>();

    await _firestore.collection('users').getDocuments().then((snapshot) {
      snapshot.documents.forEach((element) async {
        _store.name = element.data['name'];
        _store.photo = element.data['photoUrl'];
        _store.num = element.data['number'];
        _store.uid = element.data['uid'];
        await _firestore
            .collection('users')
            .document(_store.uid)
            .collection('products')
            .getDocuments()
            .then((value) {
          value.documents.forEach((product) {
            _product.name = product.data['name'];
            _product.price = product.data['price'];
            images = product.data['photoUrl'];
            _product.images = images.cast<String>().toList();
            sizes = product.data['sizes'];
            _product.sizes = sizes.cast<String>().toList();
            _product.mainImage = images[0];
            _product.category = product.data['category'];
            _product.gender = product.data['gender'];
            products.add(_product);
          });
        });
        _store.products = products;
        print(_store.products.first.name);
      });
    });

    return _store;
  }
}
