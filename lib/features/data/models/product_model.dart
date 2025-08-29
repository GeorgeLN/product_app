
class ProductModel {
  final String id;
  final String name;
  final double price;
  bool isFavorite;

  ProductModel({
    this.id = '',
    required this.name,
    required this.price,
    this.isFavorite = false,
  });

   factory ProductModel.fromJson(Map<String, dynamic> json, String id) {
    final priceData = json['price'];
    double price = 0.0;
    if (priceData is num) {
      price = priceData.toDouble();
    } else if (priceData is String) {
      price = double.tryParse(priceData) ?? 0.0;
    }

    return ProductModel(
      id: id,
      name: json['name'] ?? 'Unnamed Product',
      price: price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }
}