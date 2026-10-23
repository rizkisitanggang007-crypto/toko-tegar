import 'package:flutter/material.dart';
import '../data/catalog.dart';
import '../models/product.dart';
import '../widgets/app_image.dart';
import '../widgets/category_tile.dart';
import '../widgets/tegar_bottom_bar.dart';
import 'detail_screen.dart';
import 'protein_screen.dart';

const Color _hijau = Color(0xFF2E7D32);

class HomeScreen extends StatelessWidget {
  final String namaToko;
  const HomeScreen({super.key, required this.namaToko});

  void _bukaProtein(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProteinScreen()),
    );
  }

  void _bukaKategori(BuildContext context, CategoryItem item) {
    if (item.name == kProtein) {
      _bukaProtein(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kategori ${item.name.replaceAll('\n', ' ')} belum tersedia'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final unggulan = proteinProducts.take(2).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        title: const Text('Home', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 16),
        children: [
          // ---------- Komponen wajib: nama toko ----------
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(
              children: [
                const Icon(Icons.storefront_rounded, color: Color(0xFF6750A4), size: 26),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    namaToko,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // ---------- Komponen wajib: ikon kategori ----------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisExtent: kCategoryTileHeight,
              ),
              itemCount: categories.length,
              itemBuilder: (context, i) => CategoryTile(
                item: categories[i],
                onTap: () => _bukaKategori(context, categories[i]),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // ---------- Komponen bonus: banner pengiriman ----------
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.fromLTRB(18, 14, 14, 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFB74D), Color(0xFFFF9800)],
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF9800).withValues(alpha: 0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dikirim Besok',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.white, size: 16),
                          SizedBox(width: 2),
                          Text('ke Pilih Lokasi',
                              style: TextStyle(color: Colors.white, fontSize: 13)),
                          Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
                        ],
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white.withValues(alpha: 0.25),
                  child: const Icon(Icons.local_shipping_rounded,
                      color: Colors.white, size: 30),
                ),
              ],
            ),
          ),

          // ---------- Komponen bonus: Lihat Lebih Banyak + kartu produk ----------
          const SizedBox(height: 4),
          Center(
            child: TextButton.icon(
              onPressed: () => _bukaProtein(context),
              icon: const Text(
                'Lihat Lebih Banyak',
                style: TextStyle(color: _hijau, fontWeight: FontWeight.bold, fontSize: 14),
              ),
              label: const Icon(Icons.keyboard_arrow_down, color: _hijau),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final p in unggulan)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: _FeaturedCard(product: p),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const TegarBottomBar(),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final Product product;
  const _FeaturedCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailScreen(product: product)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.05,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: AppImage(product.image),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 46,
                      height: 46,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD32F2F),
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        'Diskon\n10%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          height: 1.2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEB3B),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        product.priceText,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(product.weight,
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
