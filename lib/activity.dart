import 'package:flutter/material.dart';
import 'package:urclip_app/home.dart';
import 'package:urclip_app/profile.dart';
import 'package:urclip_app/yourvideo.dart';

class ActivityScreen extends StatelessWidget {
  // Menerima judul lapangan sebagai parameter
  final String courtName;
  final int _selectedIndex = 0;

  const ActivityScreen({super.key, required this.courtName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logourclip.png',
              height: 60,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Colors.black, size: 20),
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke layar sebelumnya
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    courtName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                    width: 80), // Spasi untuk memisahkan judul dan ikon filter
                IconButton(
                  icon: const Icon(Icons.tune,
                      color: Colors.black), // Ikon filter
                  onPressed: () {
                    // TODO: Aksi untuk filter
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Konten Grid Video (Menggunakan GridView.builder agar bisa di-scroll)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 kolom
                  crossAxisSpacing: 16.0, // Jarak horizontal antar item
                  mainAxisSpacing: 16.0, // Jarak vertikal antar item
                  childAspectRatio:
                      0.8, // Rasio aspek item (tinggi lebih besar dari lebar)
                ),
                itemCount: 8, // Contoh 8 item video
                itemBuilder: (context, index) {
                  return _buildVideoCardPlaceholder();
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar (Sama seperti HomeScreen, tapi _selectedIndex bisa berbeda)
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
            icon: Icon(Icons
                .star_border_outlined), // Menggunakan ikon bintang untuk Activity
            selectedIcon: Icon(Icons.star),
            label: 'Activity', // Mengganti label Home menjadi Activity
          ),
          NavigationDestination(
            icon: Icon(Icons.star_border_outlined),
            selectedIcon: Icon(Icons.star),
            label: 'Your Video',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Widget helper untuk placeholder kartu video
  Widget _buildVideoCardPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300], // Warna abu-abu sebagai placeholder
        borderRadius: BorderRadius.circular(12),
      ),
      // Anda bisa menambahkan ikon play atau teks di sini jika mau
      // child: Icon(Icons.play_circle_fill, size: 50, color: Colors.grey[500]),
    );
  }
}
