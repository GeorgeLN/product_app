
import 'package:flutter/material.dart';
import 'package:prueba_experis/features/data/models/product_model.dart';
import '../../data/repositories/favorite_repository.dart';
import '../../data/repositories/product_repository.dart';

enum ViewState { loading, content, error }

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _productRepository = ProductRepository();
  final FavoriteRepository _favoriteRepository = FavoriteRepository();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  ViewState state = ViewState.loading;

  Future<void> fetchProducts() async {
    try {
      showLoading();

      _products = await _productRepository.getAllProducts();
      await _updateFavoriteStatus();
      
      showContent();
    }
    catch (e) {
      showError();
    }
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await _productRepository.addProduct(product);
      await fetchProducts();
    }
    catch (e) {
      showError();
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _productRepository.updateProduct(product);
      await fetchProducts();
    }
    catch (e) {
      showError();
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _productRepository.deleteProduct(productId);
      await fetchProducts();
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
      await _updateFavoriteStatus();

      showContent();
    }
    catch (e) {
      showError();
    }
  }

  Future<void> _updateFavoriteStatus() async {
    final favoriteIds = await _favoriteRepository.getFavoriteProducts();
    for (var product in _products) {
      product.isFavorite = favoriteIds.contains(product.id);
    }
  }

  Future<void> toggleFavoriteStatus(ProductModel product) async {
    product.isFavorite = !product.isFavorite;

    final favoriteIds = await _favoriteRepository.getFavoriteProducts();
    if (product.isFavorite) {
      if (!favoriteIds.contains(product.id)) {
        favoriteIds.add(product.id);
      }
    } else {
      favoriteIds.remove(product.id);
    }
    await _favoriteRepository.saveFavoriteProducts(favoriteIds);

    notifyListeners();
  }

  void showLoading() {
    state = ViewState.loading;
    notifyListeners();
  }

  void showContent() {
    state = ViewState.content;
    notifyListeners();
  }

  void showError() {
    state = ViewState.error;
    notifyListeners();
  }
}