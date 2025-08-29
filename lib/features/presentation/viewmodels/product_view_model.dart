
import 'package:flutter/material.dart';
import 'package:prueba_experis/features/data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

enum ViewState { loading, loaded, error }

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _productRepository = ProductRepository();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  ViewState _state = ViewState.loading;
  ViewState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _setState(ViewState.loading);
    try {
      _products = await _productRepository.getAllProducts();
      _setState(ViewState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      // ignore: avoid_print
      print('Error fetching products: $_errorMessage');
      _setState(ViewState.error);
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await _productRepository.addProduct(product);
      await fetchProducts(); // Refresh the list
    } catch (e) {
      _errorMessage = e.toString();
      // ignore: avoid_print
      print('Error adding product: $_errorMessage');
      _setState(ViewState.error);
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _productRepository.updateProduct(product);
      await fetchProducts(); // Refresh the list
    } catch (e) {
      _errorMessage = e.toString();
      // ignore: avoid_print
      print('Error updating product: $_errorMessage');
      _setState(ViewState.error);
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _productRepository.deleteProduct(productId);
      await fetchProducts(); // Refresh the list
    } catch (e) {
      _errorMessage = e.toString();
      // ignore: avoid_print
      print('Error deleting product: $_errorMessage');
      _setState(ViewState.error);
    }
  }

  Future<void> searchProducts(String query) async {
    _setState(ViewState.loading);
    try {
      if (query.isEmpty) {
        _products = await _productRepository.getAllProducts();
      } else {
        _products = await _productRepository.searchProducts(query);
      }
      _setState(ViewState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      // ignore: avoid_print
      print('Error searching products: $_errorMessage');
      _setState(ViewState.error);
    }
  }
}