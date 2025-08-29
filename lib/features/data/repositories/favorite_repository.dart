import 'package:shared_preferences/shared_preferences.dart';
import 'package:prueba_experis/core/constants/storage_keys.dart';

class FavoriteRepository {
  Future<List<String>> getFavoriteProducts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(StorageKeys.favoriteProducts) ?? [];
  }

  Future<void> saveFavoriteProducts(List<String> favoriteProductIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(StorageKeys.favoriteProducts, favoriteProductIds);
  }
}
