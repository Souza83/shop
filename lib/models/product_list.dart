import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

// ChangeNotifier: auxilia na reatividade. With: mixin da classe (add classe)
class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;

  // [..._items]: recebe um clone da lista deixando mais seguro
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); // Notifica qdo há mudança
  }
}

/* ###### Referencia de filtro de forma Global ######
  bool _showFavoriteOnly = false;

  // [..._items]: recebe um clone da lista deixando mais seguro
  List<Product> get items {
    // where: método filter (filtra os dados da aplicação)
    if (_showFavoriteOnly) {
      return _items.where((prod) => prod.isFavorite).toList();
    }
    return [..._items];
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners(); // Notifica receptores
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners(); // Notifica receptores
  }
*/