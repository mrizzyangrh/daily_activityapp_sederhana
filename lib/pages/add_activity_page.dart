import 'package:flutter/material.dart';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({super.key});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  final TextEditingController _activityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Aktivitas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TUGAS 4c: Input nama aktivitas
            TextField(
              controller: _activityController,
              decoration: const InputDecoration(
                labelText: 'Nama Aktivitas Baru',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 20),
            // TUGAS 4c: Tombol simpan
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                // Mengembalikan isi inputan ke halaman sebelumnya (Dashboard)
                Navigator.pop(context, _activityController.text);
              },
              child: const Text('Simpan'),
            )
          ],
        ),
      ),
    );
  }
}