import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/cart_state.dart';

/// Bar hijau "Lihat Keranjang" (komponen bonus).
class CartBar extends StatelessWidget {
  const CartBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartState.instance;
    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) {
        return Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Lihat Keranjang',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  Text('${cart.totalItems} Barang',
                      style: const TextStyle(color: Colors.white, fontSize: 10)),
                ],
              ),
              const Spacer(),
              Text(formatRupiah(cart.totalPrice),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
        );
      },
    );
  }
}
