import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // ClipRRect arredonda bordas
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(
          // Imagem da rede
          product.imageUrl, // Caminho da imgem
          fit: BoxFit.cover, // Para imagem cobrir a área da caixa (zoom)
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            // Posiciona antes do título
            onPressed: () {},
            icon: Icon(Icons.favorite),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
