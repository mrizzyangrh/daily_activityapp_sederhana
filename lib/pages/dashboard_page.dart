import 'package:flutter/material.dart';
import 'add_activity_page.dart';
import 'detail_activity_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // TUGAS 3: Data Dummy
  List<String> activities = [
    'Belajar Flutter',
    'Olahraga Pagi',
    'Membaca Buku',
    'Mengerjakan UTS',
    'Menonton Tutorial'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context), // TUGAS 2c: pop
          )
        ],
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(activities[index]),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TUGAS 5: Pindah ke Detail & Parsing Data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailActivityPage(activityName: activities[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddActivityPage()),
          );

          if (result != null && result.toString().isNotEmpty) {
            // TUGAS 4: setState untuk menambah data
            setState(() {
              activities.add(result.toString());
            });
          }
        },
      ),
    );
  }
}