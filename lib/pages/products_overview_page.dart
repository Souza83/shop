import 'package:flutter/material.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductsOverviewPage extends StatelessWidget {
  final List<Product> loadedProducts = dummyProducts;

  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        itemBuilder: (ctx, i) => ProductItem(product: loadedProducts[i]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // P/ scrooll
          crossAxisCount: 2, // Qtd de produtos por linha
          childAspectRatio: 3 / 2, //Proporção da dimenção altura/largura
          crossAxisSpacing: 10, // Espaçamento no eixo cruzado
          mainAxisSpacing: 10, // Espaçamento no eixo principal
        ),
      ),
    );
  }
}
