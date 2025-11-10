import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:urclip_app/models/video_model.dart';
import 'package:urclip_app/videodetailpage.dart';
import 'package:urclip_app/home.dart';
import 'package:urclip_app/profile.dart';
import 'package:urclip_app/yourvideo.dart';

class ActivityScreen extends StatefulWidget {
  final String courtName;
  const ActivityScreen({super.key, required this.courtName});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late Future<List<VideoModel>> _videosFuture;

  Future<List<VideoModel>> _loadVideos() async {
    final jsonString = await rootBundle.loadString('assets/data/videos.json');
    final List data = json.decode(jsonString);
    return data
        .map((e) => VideoModel.fromJson(e))
        .where((video) => video.court == widget.courtName)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _videosFuture = _loadVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/logourclip.png', height: 60),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    widget.courtName,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<VideoModel>>(
                future: _videosFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final videos = snapshot.data ?? [];
                  if (videos.isEmpty) {
                    return const Center(child: Text('No videos available.'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
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
                                child: Image.asset(
                                  video.thumbnailUrl,
                                  fit: BoxFit.cover,
                                ),
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
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          } else if (index == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const YourVideoScreen()));
          } else if (index == 2) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.star_border_outlined), label: 'Activity'),
          NavigationDestination(icon: Icon(Icons.star_border_outlined), label: 'Your Video'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
