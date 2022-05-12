import 'package:flutter/material.dart';

// with ChangeNotifier: mixin com classe de programção reativa
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  //Construtor Product
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  //Método de alternância
  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
