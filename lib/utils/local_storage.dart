import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urclip_app/models/video_model.dart';

class LocalStorage {
  static const String purchasedKey = 'purchased_videos';

  /// Save a video to purchased list
  static Future<void> purchaseVideo(VideoModel video) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> purchased = prefs.getStringList(purchasedKey) ?? [];
    if (!purchased.contains(video.id)) {
      purchased.add(video.id);
      await prefs.setStringList(purchasedKey, purchased);

      // Also store the details in a map for later retrieval
      final videoDetailsKey = 'video_${video.id}';
      await prefs.setString(videoDetailsKey, jsonEncode({
        'id': video.id,
        'title': video.title,
        'court': video.court,
        'downloadUrl': video.downloadUrl,
        'thumbnailUrl': video.thumbnailUrl,
      }));
    }
  }

  /// Get all purchased videos
  static Future<List<VideoModel>> getPurchasedVideos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> purchased = prefs.getStringList(purchasedKey) ?? [];
    List<VideoModel> videos = [];

    for (var id in purchased) {
      final jsonStr = prefs.getString('video_$id');
      if (jsonStr != null) {
        final data = jsonDecode(jsonStr);
        videos.add(VideoModel.fromJson(data));
      }
    }
    return videos;
  }

  /// Check if a video is purchased
  static Future<bool> isPurchased(String videoId) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> purchased = prefs.getStringList(purchasedKey) ?? [];
    return purchased.contains(videoId);
  }
}
