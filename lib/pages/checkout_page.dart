import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_routes.dart';
import '../state/cart_state.dart';
import '../utils/formatters.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.cartState});

  final CartState cartState;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: cartState,
      builder: (context, child) {
        final total = cartState.total;
        return Scaffold(
          appBar: AppBar(title: const Text('Checkout')),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Pembayaran:', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text(
                  formatRupiah(total),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton(
                onPressed: cartState.items.isEmpty
                    ? null
                    : () {
                        cartState.clear();
                        context.go(AppRoutes.home);
                      },
                child: const Text('Buat Pesanan'),
              ),
            ),
          ),
        );
      },
    );
  }
}
