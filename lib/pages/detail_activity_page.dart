import 'package:flutter/material.dart';


class DetailActivityPage extends StatelessWidget {
  // TUGAS 5c: Parsing data sederhana (melalui constructor)
  final String activityName;

  const DetailActivityPage({super.key, required this.activityName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Aktivitas'),
      ),
      body: Center(
        // TUGAS 5b: Tampilkan Nama Aktivitas
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 80, color: Colors.teal),
            const SizedBox(height: 20),
            Text(
              'Aktivitas Anda:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Text(
              activityName,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}