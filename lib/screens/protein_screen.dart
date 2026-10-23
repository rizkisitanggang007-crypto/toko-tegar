import 'package:flutter/material.dart';
import '../data/catalog.dart';
import '../widgets/cart_bar.dart';
import '../widgets/category_tile.dart';
import '../widgets/product_tile.dart';
import '../widgets/tegar_bottom_bar.dart';

class ProteinScreen extends StatefulWidget {
  const ProteinScreen({super.key});

  @override
  State<ProteinScreen> createState() => _ProteinScreenState();
}

class _ProteinScreenState extends State<ProteinScreen> {
  String _query = '';
  String _filter = 'Semua';

  @override
  Widget build(BuildContext context) {
    final tampil = proteinProducts.where((p) {
      final cocokNama = p.name.toLowerCase().contains(_query.toLowerCase());
      final cocokFilter = switch (_filter) {
        'Aneka Protein Segar' => p.group == 'Aneka Protein Segar',
        'Baru Datang' => p.isNew,
        _ => true,
      };
      return cocokNama && cocokFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        titleSpacing: 0,
        title: SizedBox(
          height: 38,
          child: TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Cari lebih banyak di Terjadwal...',
              hintStyle: const TextStyle(fontSize: 12),
              prefixIcon: const Icon(Icons.search, size: 18),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ),
        actions: const [SizedBox(width: 12)],
      ),
      body: Column(
        children: [
          // Baris ikon kategori, Protein terpilih (komponen wajib)
          SizedBox(
            height: kCategoryTileHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: categories.length,
              itemBuilder: (context, i) => SizedBox(
                width: 72,
                child: CategoryTile(
                  item: categories[i],
                  selected: categories[i].name == kProtein,
                  onTap: () {},
                ),
              ),
            ),
          ),
          // Filter chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Row(
                    children: [
                      Icon(Icons.tune, size: 16),
                      SizedBox(width: 4),
                      Text('Filter', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                for (final f in filterGroups)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(f, style: const TextStyle(fontSize: 11)),
                      selected: _filter == f,
                      showCheckmark: false,
                      selectedColor: const Color(0xFF2E7D32),
                      labelStyle: TextStyle(
                        color: _filter == f ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      onSelected: (_) => setState(() => _filter = f),
                    ),
                  ),
              ],
            ),
          ),
          // Daftar produk
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Aneka Protein Segar',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: tampil.isEmpty
                        ? const Center(child: Text('Produk tidak ditemukan'))
                        : GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.58,
                            ),
                            itemCount: tampil.length,
                            itemBuilder: (context, i) => ProductTile(product: tampil[i]),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [CartBar(), TegarBottomBar()],
      ),
    );
  }
}
