import 'package:flutter/material.dart';
import 'package:prueba_experis/features/data/models/product_model.dart';
import 'package:prueba_experis/features/data/repository/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _productRepository = ProductRepository();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _setLoading(true);
    try {
      _products = await _productRepository.getAllProducts();
    } catch (e) {
      // Handle error
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await _productRepository.addProduct(product);
      await fetchProducts(); // Refresh the list
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _productRepository.updateProduct(product);
      await fetchProducts(); // Refresh the list
    } catch (e) {
      // Handle error
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _productRepository.deleteProduct(productId);
      await fetchProducts(); // Refresh the list
    } catch (e) {
      // Handle error
    }
  }

  Future<void> searchProducts(String query) async {
    _setLoading(true);
    try {
      if (query.isEmpty) {
        _products = await _productRepository.getAllProducts();
      } else {
        _products = await _productRepository.searchProducts(query);
      }
    } catch (e) {
      // Handle error
    } finally {
      _setLoading(false);
    }
  }
}
