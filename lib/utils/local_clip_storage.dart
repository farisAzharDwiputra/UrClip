import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urclip_app/models/video_model.dart';

class LocalClipStorage {
  static const _key = 'generated_clips';

  static Future<void> saveClip(VideoModel clip) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    list.add(jsonEncode(clip.toJson()));
    await prefs.setStringList(_key, list);
  }

  static Future<List<VideoModel>> getClips() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    return list
        .map((e) => VideoModel.fromJson(jsonDecode(e)))
        .toList();
  }
}
