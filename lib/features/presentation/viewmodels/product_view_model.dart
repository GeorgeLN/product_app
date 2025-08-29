
import 'package:flutter/material.dart';
import 'package:prueba_experis/features/data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

enum ViewState { loading, content, error }

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _productRepository = ProductRepository();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  ViewState state = ViewState.loading;

  Future<void> fetchProducts() async {
    try {
      showLoading();

      _products = await _productRepository.getAllProducts();
      
      showContent();
    }
    catch (e) {
      showError();
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await _productRepository.addProduct(product);
      await fetchProducts(); // Refresh the list
      showContent();
    }
    catch (e) {
      showError();
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _productRepository.updateProduct(product);
      await fetchProducts(); // Refresh the list
      showContent();
    }
    catch (e) {
      showError();
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _productRepository.deleteProduct(productId);
    }
    catch (e) {
      showError();
    }
  }

  Future<void> searchProducts(String query) async {
    try {
      showLoading();

      if (query.isEmpty) {
        _products = await _productRepository.getAllProducts();
      } else {
        _products = await _productRepository.searchProducts(query);
      }

      showContent();
    }
    catch (e) {
      showError();
    }
  }

    Future<void> showLoading() async {
    state = ViewState.loading;
    notifyListeners();
  }

  Future<void> showContent() async {
    state = ViewState.content;
    notifyListeners();
  }

  Future<void> showError() async {
    state = ViewState.error;
    notifyListeners();
  }
}