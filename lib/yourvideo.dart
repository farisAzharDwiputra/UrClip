import 'package:flutter/material.dart';
import 'package:urclip_app/home.dart';
import 'package:urclip_app/profile.dart';

// (Opsional) Impor layar lain untuk navigasi
// import 'activity_screen.dart';
// import 'profile_screen.dart';

class YourVideoScreen extends StatefulWidget {
  const YourVideoScreen({super.key});

  @override
  State<YourVideoScreen> createState() => _YourVideoScreenState();
}

class _YourVideoScreenState extends State<YourVideoScreen> {
  // Index untuk "Your Video" adalah 1
  final int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. APPBAR (Hanya Logo)
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        // Hapus tombol kembali secara otomatis
        automaticallyImplyLeading: false,
        titleSpacing: 16.0, // Memberi padding kiri untuk logo
        title: Image.asset(
          'assets/images/logourclip.png',
          height: 24,
        ),
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul Halaman
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: Text(
                'Your Video',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Konten Grid Video
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 kolom
                  crossAxisSpacing: 16.0, // Jarak horizontal
                  mainAxisSpacing: 16.0, // Jarak vertikal
                  childAspectRatio: 0.8, // Rasio tinggi:lebar
                ),
                itemCount: 5, // Sesuai gambar, ada 5 item
                itemBuilder: (context, index) {
                  return _buildVideoCardPlaceholder();
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else if (index == 1) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const YourVideoScreen()));
          } else if (index == 2) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()));
          }
        },
        backgroundColor: Colors.white,
        indicatorColor: Colors.grey[300],
        // Nav bar ini sama dengan di ActivityScreen
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.star_border_outlined),
            selectedIcon: Icon(Icons.star),
            label: 'Activity',
          ),
          NavigationDestination(
            icon: Icon(Icons.star_border_outlined),
            selectedIcon: Icon(Icons.star),
            label: 'Your Video',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline), // Sesuai gambar
            selectedIcon: Icon(Icons.star),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Widget helper untuk placeholder kartu video (sama seperti di ActivityScreen)
  Widget _buildVideoCardPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300], // Warna abu-abu sebagai placeholder
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
