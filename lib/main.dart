import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Activity App',
      // TUGAS 7: Penggunaan ThemeData (Wajib)
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
        // Mengatur Style text global (TextTheme)
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// =========================================================
// TUGAS 1: Halaman Login
// =========================================================
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TUGAS 6: Tampilan Responsive menggunakan MediaQuery
    // Mengatur lebar dinamis agar UI tetap rapi di mode Portrait & Landscape
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingHorizontal = screenWidth > 600 ? screenWidth * 0.25 : 24.0;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          // TUGAS 1b: Layout menggunakan Column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 40), // TUGAS 1b: Jarak antar komponen (SizedBox)
              
              // TUGAS 1a: TextField Username
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              
              // TUGAS 1a: TextField Password
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              
              // TUGAS 1a & 1c: Tombol Login
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), // Tombol melebar penuh
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // TUGAS 2a & 2b: Navigasi menggunakan Navigator.push() ke Dashboard
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardPage()),
                  );
                },
                child: const Text('Login', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================
// TUGAS 3 & 4: Halaman Dashboard (StatefulWidget)
// =========================================================
// TUGAS 4e: Gunakan StatefulWidget
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  List<String> activities = [
    'bersepeda',
    'bekerja',
    'berenang',
    'berlari',
    'menjadi programmer',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Aktivitas'),
        actions: [
          // TUGAS 2c: Tombol kembali/logout (menggunakan pop)
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      // TUGAS 3c: Gunakan ListView
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          // TUGAS 3c: Gunakan Card
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            child: ListTile(
              title: Text(activities[index], style: Theme.of(context).textTheme.bodyMedium),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // TUGAS 5a: Pindah ke halaman detail
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
      // TUGAS 4a: Tombol Tambah (+)
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          // TUGAS 4b: Saat ditekan, tampilkan halaman form
          // Kita menunggu balikan (return) data dari halaman tambah
          final newActivity = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddActivityPage()),
          );

          // TUGAS 4d & 4e: Jika data tidak kosong, tambahkan ke list dan panggil setState()
          if (newActivity != null && newActivity.toString().trim().isNotEmpty) {
            setState(() {
              activities.add(newActivity.toString());
            });
          }
        },
      ),
    );
  }
}

// =========================================================
// TUGAS 4c: Form Tambah Aktivitas
// =========================================================
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

// =========================================================
// TUGAS 5: Halaman Detail Aktivitas
// =========================================================
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