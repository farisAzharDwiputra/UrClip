import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoDownload {
  static Future<String?> downloadAssetVideo(
    String assetPath,
    String fileName,
  ) async {
    final permission = await Permission.storage.request();
    if (!permission.isGranted) return null;

    final dir = await getExternalStorageDirectory();
    if (dir == null) return null;

    final targetDir = Directory('${dir.path}/Movies/Urclip');
    if (!await targetDir.exists()) {
      await targetDir.create(recursive: true);
    }

    final file = File('${targetDir.path}/$fileName');

    final byteData = await rootBundle.load(assetPath);
    await file.writeAsBytes(byteData.buffer.asUint8List());

    return file.path;
  }
}
