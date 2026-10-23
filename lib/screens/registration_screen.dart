import 'package:flutter/material.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _toko = TextEditingController();
  final _pemilik = TextEditingController();
  final _alamat = TextEditingController();
  final _kontak = TextEditingController();

  static const _daftarUsaha = ['Makanan & Minuman', 'Sayur & Sembako', 'Lainnya'];
  String _usaha = _daftarUsaha.first;
  bool _setuju = false;

  @override
  void dispose() {
    _toko.dispose();
    _pemilik.dispose();
    _alamat.dispose();
    _kontak.dispose();
    super.dispose();
  }

  String? _wajibIsi(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null;

  String? _cekKontak(String? v) {
    if (v == null || v.trim().isEmpty) return 'Wajib diisi';
    if (!RegExp(r'^[0-9]{8,15}$').hasMatch(v.trim())) {
      return 'Isi dengan angka 8-15 digit';
    }
    return null;
  }

  void _kirim() {
    if (!_formKey.currentState!.validate()) return;
    if (!_setuju) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Centang dulu syarat dan ketentuan')),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        settings: const RouteSettings(name: 'home'),
        builder: (_) => HomeScreen(namaToko: _toko.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Pemilik Toko'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _toko,
                decoration: const InputDecoration(labelText: 'Nama Toko'),
                validator: _wajibIsi,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pemilik,
                decoration: const InputDecoration(labelText: 'Nama Pemilik'),
                validator: _wajibIsi,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _usaha,
                decoration: const InputDecoration(labelText: 'Jenis Usaha'),
                items: _daftarUsaha
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _usaha = v ?? _usaha),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _alamat,
                decoration: const InputDecoration(labelText: 'Alamat Toko'),
                validator: _wajibIsi,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _kontak,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Kontak'),
                validator: _cekKontak,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _setuju,
                    onChanged: (v) => setState(() => _setuju = v ?? false),
                  ),
                  const Expanded(
                    child: Text('Saya menyetujui syarat dan ketentuan'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: _kirim,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
