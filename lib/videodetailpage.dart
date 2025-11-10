import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:urclip_app/models/video_model.dart';
import 'package:urclip_app/utils/local_storage.dart';
import 'package:urclip_app/utils/media_utils.dart';

class VideoDetailPage extends StatefulWidget {
  final String videoId;
  final String title;
  final String videoUrl;
  final String? thumbnailUrl;

  const VideoDetailPage({
    super.key,
    required this.videoId,
    required this.title,
    required this.videoUrl,
    this.thumbnailUrl,
  });

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isPurchased = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _checkPurchased();
  }

  Future<void> _checkPurchased() async {
    final purchased = await LocalStorage.isPurchased(widget.videoId);
    setState(() {
      _isPurchased = purchased;
    });
  }

  Future<void> _initializeVideo() async {
    if (isAssetPath(widget.videoUrl)) {
      _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
    } else {
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    }
    await _videoPlayerController!.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: false,
      looping: false,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> _purchase() async {
    final video = VideoModel(
      id: widget.videoId,
      title: widget.title,
      court: 'Senopati Padel Court', // example, could be passed in
      downloadUrl: widget.videoUrl,
      thumbnailUrl: widget.thumbnailUrl ?? '',
    );
    await LocalStorage.purchaseVideo(video);
    setState(() => _isPurchased = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to Your Videos')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video player
            if (_videoPlayerController != null &&
                _videoPlayerController!.value.isInitialized)
              AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: Chewie(controller: _chewieController!),
              )
            else
              Container(
                height: 200,
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.videocam)),
              ),

            // Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Location: Senopati Padel Court",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const Text(
                    "Duration: 45s",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Price: Rp 25.000",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart),
                      label: Text(_isPurchased
                          ? 'Purchased'
                          : 'Purchase Video'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _isPurchased ? Colors.grey : Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isPurchased ? null : _purchase,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
