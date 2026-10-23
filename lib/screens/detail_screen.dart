import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config.dart';
import '../models/product.dart';
import '../widgets/app_image.dart';
import '../widgets/tegar_bottom_bar.dart';

class DetailScreen extends StatelessWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  Future<void> _orderViaWhatsApp(BuildContext context) async {
    final pesan = Uri.encodeComponent(
        'Halo, saya ingin memesan ${product.fullName} seharga ${product.priceText}');
    final uri = Uri.parse('https://wa.me/$kNomorWhatsApp?text=$pesan');
    var berhasil = false;
    try {
      berhasil = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      berhasil = false;
    }
    if (!berhasil && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka WhatsApp')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const merah = TextStyle(
      color: Color(0xFFC62828),
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        centerTitle: true,
        title: const Text('Pesan'),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              product.fullName,
              textAlign: TextAlign.center,
              style: merah.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppImage(product.image, width: double.infinity, height: 200),
            ),
            const SizedBox(height: 12),
            Text(product.priceText, style: merah.copyWith(fontSize: 18)),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              onPressed: () => _orderViaWhatsApp(context),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.chat, size: 28),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order via WhatsApp',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Klik di Sini!', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const TegarBottomBar(),
    );
  }
}
