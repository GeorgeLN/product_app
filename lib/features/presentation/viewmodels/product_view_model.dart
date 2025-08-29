
import 'package:flutter/material.dart';

enum PokemonState {loading, content, error}

class ProductViewModel with ChangeNotifier {
  PokemonState state = PokemonState.loading;

  

  Future<void> showLoading() async {
    state = PokemonState.loading;
    notifyListeners();
  }

  Future<void> showContent() async {
    state = PokemonState.content;
    notifyListeners();
  }

  Future<void> showError() async {
    state = PokemonState.error;
    notifyListeners();
  }
}