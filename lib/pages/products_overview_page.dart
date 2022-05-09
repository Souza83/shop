import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: loadedProducts.length,
          itemBuilder: (ctx, i) => Text(loadedProducts[i].title),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // P/ scrooll
            crossAxisCount: 2, // Qtd de produtos por linha
            childAspectRatio: 3 / 2, //Proporção da dimenção altura/largura
            crossAxisSpacing: 10, // Espaçamento no eixo cruzado
            mainAxisSpacing: 10, // Espaçamento no eixo principal
          ),
        ),
      ),
    );
  }
}
