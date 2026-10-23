class Product {
  final String id;
  final String name;
  final String weight;
  final String image;
  final String group; // sub kategori untuk chip filter
  final int price;
  final int stock;
  final bool isNew;

  const Product({
    required this.id,
    required this.name,
    required this.weight,
    required this.image,
    required this.group,
    required this.price,
    required this.stock,
    this.isNew = false,
  });

  String get priceText => formatRupiah(price);
  String get fullName => '$name $weight';
}

/// 51900 -> Rp51.900
String formatRupiah(int value) {
  final s = value.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return 'Rp$buf';
}
