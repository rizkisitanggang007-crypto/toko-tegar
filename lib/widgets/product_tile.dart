import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/detail_screen.dart';
import '../state/cart_state.dart';
import 'app_image.dart';

/// Item produk di grid halaman Protein: tombol +, jumlah di keranjang, harga, sisa stok.
class ProductTile extends StatelessWidget {
  final Product product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = CartState.instance;
    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) {
        final qty = cart.qtyOf(product);
        return InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetailScreen(product: product)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AppImage(product.image),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: _circle(Icons.add, () => cart.add(product)),
                    ),
                    if (qty > 0)
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () => cart.remove(product),
                                child: const Icon(Icons.remove_circle,
                                    size: 18, color: Color(0xFF2E7D32)),
                              ),
                              const SizedBox(width: 4),
                              Text('$qty',
                                  style: const TextStyle(
                                      fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(product.priceText,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              Text(
                product.fullName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Text('Sisa ${product.stock}',
                    style: const TextStyle(fontSize: 10, color: Colors.red)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _circle(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: const BoxDecoration(color: Color(0xFF2E7D32), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
