import 'package:pcnc/aa/features/product/domain/entity/product.dart';

class CartItemModel {
  final int id;
  final String title;
  final String price;
  final String description;
  final String imageUrl;
  int quantity;

  CartItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrl,
    this.quantity = 1,
  });

  factory CartItemModel.fromProduct(Product product) {
    return CartItemModel(
      id: product.id,
      title: product.title,
      price: product.price.toString(),
      description: product.description,
      imageUrl: product.images.isNotEmpty ? product.images.first : '',
      quantity: 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
    );
  }
}
