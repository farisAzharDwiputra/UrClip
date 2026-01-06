import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:urclip_app/models/video_model.dart';
import 'package:urclip_app/utils/local_clip_storage.dart';

class ClipSimulationPage extends StatefulWidget {
  const ClipSimulationPage({super.key});

  @override
  State<ClipSimulationPage> createState() => _ClipSimulationPageState();
}

class _ClipSimulationPageState extends State<ClipSimulationPage> {
  String _selectedCourt = 'Senopati Padel Court';
  int _selectedField = 1;
  int _clipDuration = 10;

  late VideoPlayerController _controller;
  Duration _videoDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/videos/4.mp4',
    )..initialize().then((_) {
        setState(() {
          _videoDuration = _controller.value.duration;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _trimAndSave() async {
    final start = _videoDuration.inSeconds - _clipDuration;

    final clip = VideoModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Clip ${_clipDuration}s - Court $_selectedField',
      court: _selectedCourt,
      courtNumber: _selectedField,
      downloadUrl: 'assets/videos/4.mp4',
      thumbnailUrl: 'assets/thumbnails/thumbnail.png',
      clipStartSeconds: start < 0 ? 0 : start,
      clipDurationSeconds: _clipDuration,
    );

    await LocalClipStorage.saveClip(clip);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Clip saved successfully')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Clip')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Court'),
            DropdownButton<String>(
              value: _selectedCourt,
              items: const [
                DropdownMenuItem(
                  value: 'Senopati Padel Court',
                  child: Text('Senopati Padel Court'),
                ),
              ],
              onChanged: (v) => setState(() => _selectedCourt = v!),
            ),

            const SizedBox(height: 12),

            const Text('Field Number'),
            DropdownButton<int>(
              value: _selectedField,
              items: List.generate(
                4,
                (i) => DropdownMenuItem(
                  value: i + 1,
                  child: Text('Court ${i + 1}'),
                ),
              ),
              onChanged: (v) => setState(() => _selectedField = v!),
            ),

            const SizedBox(height: 12),

            const Text('Clip Duration (seconds)'),
            Wrap(
              spacing: 8,
              children: [5, 10, 20, 30, 60].map((sec) {
                return ChoiceChip(
                  label: Text('$sec s'),
                  selected: _clipDuration == sec,
                  onSelected: (_) => setState(() => _clipDuration = sec),
                );
              }).toList(),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.content_cut),
                label: const Text('Trim Last Clip'),
                onPressed: _trimAndSave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
