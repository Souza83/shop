import 'package:flutter/material.dart';
import 'package:shop/pages/product_detail_page.dart';
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
        // Detecta gesto na imagem da tela
        child: GestureDetector(
          child: Image.network(
            // Imagem da rede
            product.imageUrl, // Caminho da imgem
            fit: BoxFit.cover, // Para imagem cobrir a área da caixa (zoom)
          ),
          // Detecta toque na tela
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailPage(product: product),
              ),
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            // Posiciona antes do título
            onPressed: () {},
            icon: Icon(Icons.favorite),
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
