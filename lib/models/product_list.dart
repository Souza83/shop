import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/constants.dart';

// ChangeNotifier: auxilia na reatividade. With: mixin da classe (add classe)
class ProductList with ChangeNotifier {
  final String _token;
  List<Product> _items = [];

  // [..._items]: recebe um clone da lista deixando mais seguro
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  ProductList(this._token, this._items);

  int get itemsCount {
    return _items.length;
  }

  // Obtem as informações do firebase
  Future<void> loadProducts() async {
    _items.clear(); // Limpa a lista (corrige erro de duplicação de produtos)
    final response = await http.get(
      Uri.parse(
        '${Constants.PRODUCT_BASE_URL}.json?auth=$_token',
      ),
    );
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productid, productData) {
      _items.add(
        Product(
          id: productid,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  // async: Função assincrona p/ adicionar produto | await: Aguardar
  Future<void> addProduct(Product product) async {
    final response = await http.post(
      // Firebase convenciona o uso do .json
      Uri.parse(
        '${Constants.PRODUCT_BASE_URL}.json?auth=$_token',
      ),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    _items.add(
      Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      ),
    );
    notifyListeners(); // Notifica qdo há mudança )
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse(
          '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token',
        ),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse(
          '${Constants.PRODUCT_BASE_URL}/${product.id}.json?auth=$_token',
        ),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        // Tratamento de exceção
        throw HttpException(
          msg: 'Não foi possível excluir o produto.',
          statusCode: response.statusCode,
        );
      }
    }
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
