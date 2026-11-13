import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/product.dart';
import '../routes/app_routes.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  void _openDetail(Product product) {
    context.go('${AppRoutes.home}/product/${product.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        actions: [
          IconButton(
            tooltip: 'Keranjang',
            onPressed: () => context.go(AppRoutes.cart),
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: dummyProducts.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = dummyProducts[index];
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imageUrl,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(Icons.image_not_supported),
                ),
              ),
            ),
            title: Text(product.name),
            subtitle: Text(product.formattedPrice),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openDetail(product),
          );
        },
      ),
    );
  }
}
