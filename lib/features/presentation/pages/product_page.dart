import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  SharedPreferences? _prefs;

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('This is the product page'),
      ),
    );
  }
}