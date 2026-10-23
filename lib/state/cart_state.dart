import 'package:flutter/foundation.dart';
import '../models/product.dart';

/// Keranjang belanja (komponen bonus "Lihat Keranjang").
class CartState extends ChangeNotifier {
  CartState._();
  static final CartState instance = CartState._();

  final Map<Product, int> _items = {};

  int qtyOf(Product p) => _items[p] ?? 0;

  void add(Product p) {
    final q = qtyOf(p);
    if (q >= p.stock) return; // tidak melebihi stok
    _items[p] = q + 1;
    notifyListeners();
  }

  void remove(Product p) {
    final q = qtyOf(p);
    if (q <= 0) return;
    if (q == 1) {
      _items.remove(p);
    } else {
      _items[p] = q - 1;
    }
    notifyListeners();
  }

  int get totalItems => _items.values.fold(0, (a, b) => a + b);

  int get totalPrice =>
      _items.entries.fold(0, (sum, e) => sum + e.key.price * e.value);
}
