
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prueba_experis/features/data/models/product_model.dart';

class ProductRepository {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('productos');

  Future<void> addProduct(ProductModel product) async {
    await _productsCollection.add(product.toJson());
  }

  Future<List<ProductModel>> getAllProducts() async {
    QuerySnapshot snapshot = await _productsCollection.get();
    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
  }

  Future<void> updateProduct(ProductModel product) async {
    await _productsCollection.doc(product.id).update(product.toJson());
  }

  Future<void> deleteProduct(String productId) async {
    await _productsCollection.doc(productId).delete();
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    QuerySnapshot snapshot = await _productsCollection
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .get();
    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
  }
}