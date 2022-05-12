import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/product_item.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider(
        create: (_) => loadedProducts[i],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // P/ scrooll
        crossAxisCount: 2, // Qtd de produtos por linha
        childAspectRatio: 3 / 2, //Proporção da dimenção altura/largura
        crossAxisSpacing: 10, // Espaçamento no eixo cruzado
        mainAxisSpacing: 10, // Espaçamento no eixo principal
      ),
    );
  }
}
