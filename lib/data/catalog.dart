import 'package:flutter/material.dart';
import '../models/product.dart';

class CategoryItem {
  final String name;
  final IconData icon;
  final Color color;
  const CategoryItem(this.name, this.icon, this.color);
}

// Ikon memakai ikon bawaan Flutter (sesuai catatan soal).
const List<CategoryItem> categories = [
  CategoryItem('Produk\nTerbaru', Icons.new_releases, Color(0xFFFFB300)),
  CategoryItem('Beli Lagi', Icons.replay, Color(0xFFE53935)),
  CategoryItem('Clearance\nSale', Icons.timer_outlined, Colors.black87),
  CategoryItem('Sayur', Icons.eco, Color(0xFF43A047)),
  CategoryItem('Buah', Icons.apple, Color(0xFFFB8C00)),
  CategoryItem('Protein', Icons.set_meal, Color(0xFFD84315)),
];

const String kProtein = 'Protein';

const List<String> filterGroups = ['Semua', 'Aneka Protein Segar', 'Baru Datang'];

// Ganti nama file gambar sesuai gambar yang diberikan dosen.
const List<Product> proteinProducts = [
  Product(
    id: 'p1',
    name: 'Sayurbox Daging Giling Segar',
    weight: '250 g',
    image: 'assets/images/daging_giling.jpg',
    group: 'Aneka Protein Segar',
    price: 51900,
    stock: 3,
  ),
  Product(
    id: 'p2',
    name: 'Daging Has Luar Segar',
    weight: '250 g',
    image: 'assets/images/daging_has_luar.jpg',
    group: 'Aneka Protein Segar',
    price: 49900,
    stock: 1,
  ),
  Product(
    id: 'p3',
    name: 'Sayurbox Daging Sengkel Segar',
    weight: '250 g',
    image: 'assets/images/daging_sengkel.jpg',
    group: 'Aneka Protein Segar',
    price: 49900,
    stock: 3,
    isNew: true,
  ),
  Product(
    id: 'p4',
    name: 'Daging Has Dalam Segar',
    weight: '250 g',
    image: 'assets/images/daging_has_dalam.jpg',
    group: 'Aneka Protein Segar',
    price: 62900,
    stock: 5,
  ),
  Product(
    id: 'p5',
    name: 'Sayurbox Iga Sapi Segar',
    weight: '250 g',
    image: 'assets/images/iga_sapi.jpg',
    group: 'Aneka Protein Segar',
    price: 64900,
    stock: 4,
    isNew: true,
  ),
  Product(
    id: 'p6',
    name: 'Teri Nasi Basah Tidak Beku',
    weight: '250 g',
    image: 'assets/images/teri_nasi.jpg',
    group: 'Aneka Protein Segar',
    price: 26100,
    stock: 6,
  ),
];
