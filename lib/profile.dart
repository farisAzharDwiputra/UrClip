import 'package:flutter/material.dart';
// Pastikan path import ini sesuai dengan struktur folder Anda
import 'package:urclip_app/home.dart';
import 'package:urclip_app/yourvideo.dart';
// Anda tidak perlu import ProfileScreen di dalam ProfileScreen
// import 'package:urclip_app/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // --- State Variables ---
  int _selectedIndex = 2; // Index 2 untuk "Profile"
  bool _isFaceIdEnabled = false; // Status untuk toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24.0), // Padding di bawah
          children: [
            // 1. Judul "Profile"
            _buildScreenTitle(),

            // 2. Kartu Header Biru
            _buildProfileHeader(),

            // 3. Kartu Pengaturan Pertama
            _buildSettingsCard(),

            // 4. Judul "More"
            _buildMoreTitle(),

            // 5. Kartu Pengaturan Kedua
            _buildMoreCard(),
          ],
        ),
      ),
      // Menggunakan BottomNav yang sudah disesuaikan
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- Helper Widgets ---

  /// 1. Judul "Profile" di bagian atas
  Widget _buildScreenTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Text(
        'Profile',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  /// 2. Kartu Header Biru dengan info user
  Widget _buildProfileHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF00008B), // Biru gelap (Dark Blue)
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Itunuoluwa Abidoye',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Referral Code: 12321214214',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 3. Kartu putih pertama untuk pengaturan akun
  Widget _buildSettingsCard() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      // ClipRRect agar Divider tidak keluar dari radius
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Column(
          children: [
            _buildListTile(
              icon: Icons.person_outline,
              title: 'My Account',
              subtitle: 'Make changes to your account',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.warning_amber, color: Colors.red, size: 18),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            _buildListTile(
              icon: Icons.bookmark_border,
              title: 'Saved Beneficiary',
              subtitle: 'Manage your saved account',
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey),
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            _buildListTile(
              icon: Icons.fingerprint, // Ikon Face ID / Touch ID
              title: 'Face ID / Touch ID',
              subtitle: 'Manage your device security',
              trailing: Switch(
                value: _isFaceIdEnabled,
                onChanged: (value) {
                  setState(() {
                    _isFaceIdEnabled = value;
                  });
                },
                activeColor: Colors.green, // Warna toggle
              ),
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            _buildListTile(
              icon: Icons.shield_outlined,
              title: 'Two-Factor Authentication',
              subtitle: 'Further secure your account for safety',
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey),
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            _buildListTile(
              icon: Icons.logout,
              title: 'Log out',
              subtitle: 'Further secure your account for safety',
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  /// 4. Judul "More"
  Widget _buildMoreTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: Text(
        'More',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  /// 5. Kartu putih kedua untuk info tambahan
  Widget _buildMoreCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Column(
          children: [
            _buildListTile(
              icon: Icons.help_outline,
              title: 'Help & Support',
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey),
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            _buildListTile(
              icon: Icons.info_outline,
              title: 'About App',
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  /// 6. Bottom Navigation Bar (SUDAH DISESUAIKAN)
  Widget _buildBottomNav() {
    return NavigationBar(
      selectedIndex: _selectedIndex, // Index "Profile"
      onDestinationSelected: (index) {
        // Logika navigasi dari kode ProfileScreen Anda
        // (Ini sudah menangani perpindahan layar dengan benar)
        if (index == 0) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else if (index == 1) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const YourVideoScreen()));
        }
        // Tidak perlu navigasi jika index == 2 (halaman ini)
        // Cukup setState untuk update UI jika diperlukan
        if (index != 2) {
          // Hanya setState jika pindah
          setState(() {
            _selectedIndex = index;
          });
        }
      },
      backgroundColor: Colors.white,
      indicatorColor: Colors.grey[300], // <-- DIGANTI dari snippet Anda
      destinations: const [
        // vvv DESTINATIONS DIGANTI DARI SNIPPET ANDA vvv
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
          icon: Icon(Icons.person_outline), // <-- Ikon berubah
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
  }) {
    return ListTile(
      leading: CircleAvatar(
        // Latar belakang ikon
        backgroundColor: const Color(0xFFF3F4F6), // Abu-abu sangat muda
        child: Icon(
          icon,
          color: const Color(0xFF00008B), // Ikon biru gelap
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w600, color: Colors.black, fontSize: 14),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            )
          : null,
      trailing: trailing,
    );
  }
}
