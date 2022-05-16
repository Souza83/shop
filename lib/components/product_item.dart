import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false, // Alterna a escuta da notificação ("opcional p/ true")
    );
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
          // Detecta toque para navegação entre telas
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product,
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: () {
                product.toggleFavorite();
              },
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.name,
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
