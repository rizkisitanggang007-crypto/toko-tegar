import 'package:flutter/material.dart';

/// Navigation bottom (komponen wajib): Home, Search, Keranjang, Akun.
/// Ikon Home kembali ke halaman bernama 'home'.
class TegarBottomBar extends StatelessWidget {
  const TegarBottomBar({super.key});

  Widget _icon(IconData icon, {bool active = false, VoidCallback? onTap}) {
    return IconButton(
      onPressed: onTap ?? () {},
      icon: Icon(icon, color: active ? Colors.deepOrange : Colors.black54),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: Material(
          elevation: 3,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _icon(Icons.home,
                        active: true,
                        onTap: () => Navigator.popUntil(
                            context, (route) => route.settings.name == 'home')),
                    _icon(Icons.search),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _icon(Icons.shopping_basket_outlined),
                    _icon(Icons.person_outline),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
