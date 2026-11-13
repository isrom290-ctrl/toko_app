// lib/main.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router/app_router.dart';
import 'state/auth_state.dart';
import 'state/cart_state.dart';

void main() {
  runApp(const TokoApp());
}

class TokoApp extends StatefulWidget {
  const TokoApp({super.key});

  @override
  State<TokoApp> createState() => _TokoAppState();
}

class _TokoAppState extends State<TokoApp> {
  late final AuthState _authState = AuthState();
  late final CartState _cartState = CartState();
  late final GoRouter _router = createRouter(
    authState: _authState,
    cartState: _cartState,
  );

  @override
  void dispose() {
    _router.dispose();
    _authState.dispose();
    _cartState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Toko App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
