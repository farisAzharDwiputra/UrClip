import 'package:flutter/material.dart';
import 'package:urclip_app/activity.dart';
import 'package:urclip_app/profile.dart';
import 'package:urclip_app/yourvideo.dart';
import 'package:urclip_app/clipsimulationpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildSearchBar(),
            const SizedBox(height: 24),
            // const SizedBox(height: 24),
            _buildClipCard(),
            const SizedBox(height: 24),

            _buildCourtCard(
              imagePath: 'images/konten1.png',
              title: 'Senopati Padel Court',
            ),
            const SizedBox(height: 16),
            _buildCourtCard(
              imagePath: 'images/konten2.png',
              title: 'Kemang Padel Court',
            ),
            const SizedBox(height: 16),
            _buildCourtCard(
              imagePath: 'images/konten3.png',
              title: 'Slipi Padel Court',
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

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Image.asset('images/logourclip.png', height: 60),
          ],
        ),
        const SizedBox(height: 8),
        // Judul Halaman
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            'Home',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  // Widget helper untuk Search Bar
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[200],
        // Border tanpa garis tepi
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _buildClipCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ClipSimulationPage(),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: const [
              Icon(Icons.cut, color: Colors.white, size: 32),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Clip Your Game\nCreate highlights from the last minute',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios,
                  color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }


  // Widget helper untuk Kartu Lapangan
  Widget _buildCourtCard({required String imagePath, required String title}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivityScreen(courtName: title),
          ),
        );
      },
      child: Card(
        // Mengatur agar gambar di dalam card ikut bulat
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4, // Sedikit bayangan
        child: Stack(
          alignment: Alignment.bottomLeft, // Teks menempel di kiri bawah
          children: [
            // Gambar Background
            Image.asset(
              imagePath,
              height: 180, // Tinggi kartu
              width: double.infinity, // Lebar penuh
              fit: BoxFit.cover,

              // Error handling jika gambar tidak ditemukan
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child:
                      const Icon(Icons.image_not_supported, color: Colors.grey),
                );
              },
            ),

            // Efek gradient gelap agar teks terbaca
            Container(
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
            ),

            // Teks Judul
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
