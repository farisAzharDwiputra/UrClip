import 'package:flutter/material.dart';
import 'package:urclip_app/models/video_model.dart';
import 'package:urclip_app/local_storage.dart';
import 'package:urclip_app/videodetailpage.dart';
import 'package:urclip_app/home.dart';
import 'package:urclip_app/profile.dart';

class YourVideoScreen extends StatefulWidget {
  const YourVideoScreen({super.key});

  @override
  State<YourVideoScreen> createState() => _YourVideoScreenState();
}

class _YourVideoScreenState extends State<YourVideoScreen> {
  late Future<List<VideoModel>> _purchasedFuture;

  @override
  void initState() {
    super.initState();
    _purchasedFuture = LocalStorage.getPurchasedVideos();
  }

  Future<void> _refresh() async {
    final vids = LocalStorage.getPurchasedVideos();
    setState(() {
      _purchasedFuture = vids;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Image.asset('images/logourclip.png', height: 60),
      ),
      body: FutureBuilder<List<VideoModel>>(
        future: _purchasedFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final videos = snapshot.data ?? [];
          if (videos.isEmpty) {
            return const Center(child: Text('You haven’t purchased any videos yet.'));
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoDetailPage(
                          videoId: video.id,
                          title: video.title,
                          videoUrl: video.downloadUrl,
                          thumbnailUrl: video.thumbnailUrl,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(video.thumbnailUrl, fit: BoxFit.cover),
                        ),
                        Positioned(
                          left: 8,
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              video.title,
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.star_border_outlined), label: 'Activity'),
          NavigationDestination(icon: Icon(Icons.star), label: 'Your Video'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
