import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:urclip_app/models/video_model.dart';
import 'package:urclip_app/local_storage.dart';
import 'package:urclip_app/utils/media_utils.dart';
import 'package:urclip_app/payment_simulation.dart';
import 'package:share_plus/share_plus.dart';

class VideoDetailPage extends StatefulWidget {
  final String videoId;
  final String title;
  final String videoUrl;
  final String? thumbnailUrl;
  final int? courtNumber;

  const VideoDetailPage({
    super.key,
    required this.videoId,
    required this.title,
    required this.videoUrl,
    this.thumbnailUrl,
    this.courtNumber,
  });

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isPurchased = false;
  Duration? _videoDuration;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _checkPurchased();
  }

  Future<void> _checkPurchased() async {
    final purchased = await LocalStorage.isPurchased(widget.videoId);
    setState(() => _isPurchased = purchased);
  }

  Future<void> _initializeVideo() async {
    if (isAssetPath(widget.videoUrl)) {
      _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
    } else {
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    }

    await _videoPlayerController!.initialize();
    _videoDuration = _videoPlayerController!.value.duration;

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: false,
      looping: false,
    );

    setState(() {});
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> _goToPayment() async {
    final video = VideoModel(
      id: widget.videoId,
      title: widget.title,
      court: 'Senopati Padel Court',
      courtNumber: widget.courtNumber ?? 0,
      downloadUrl: widget.videoUrl,
      thumbnailUrl: widget.thumbnailUrl ?? '',
    );

    final success = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentSimulationPage(video: video),
      ),
    );

    if (success == true) {
      setState(() => _isPurchased = true);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Purchase successful')),
      );
    }
  }

  void _downloadVideo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Download feature coming soon'),
      ),
    );
  }

  void _shareVideo() {
    // final url = 'https://urclip.app/videos/${widget.videoId}';
    Share.share(
      '🎾 Check out my padel clip on Urclip!\n\n'
      '🎬 ${widget.title}\n'
      '📍 Senopati Padel Court\n\n'
      'Link sharing coming soon 🚀',
      subject: widget.title,
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
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: _videoPlayerController?.value.aspectRatio ?? 16 / 9,
                  child: _chewieController != null
                      ? Chewie(controller: _chewieController!)
                      : Container(color: Colors.grey[300]),
                ),

                if (!_isPurchased)
                  const Positioned.fill(
                    child: IgnorePointer(
                      child: Center(
                        child: Opacity(
                          opacity: 0.15,
                          child: Text(
                            'URCLIP PREVIEW',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Location: Senopati Padel Court",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    _videoDuration != null
                        ? 'Duration: ${_formatDuration(_videoDuration!)}'
                        : 'Duration: --:--',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),

                  if (!_isPurchased)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text('Purchase Video'),
                        onPressed: _goToPayment,
                      ),
                    )
                  else
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.download),
                                label: const Text('Download'),
                                onPressed: _downloadVideo,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: const Icon(Icons.share),
                                label: const Text('Share'),
                                onPressed: _shareVideo,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.delete),
                            label: const Text('Remove from Library'),
                            onPressed: () async {
                              await LocalStorage.removeVideo(widget.videoId);
                              setState(() => _isPurchased = false);
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Removed from library')),
                              );
                            },
                          ),
                        ),
                      ],
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
