class VideoModel {
  final String id;
  final String title;
  final String court;
  final String downloadUrl;
  final String thumbnailUrl;

  VideoModel({
    required this.id,
    required this.title,
    required this.court,
    required this.downloadUrl,
    required this.thumbnailUrl,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json['id'],
        title: json['title'],
        court: json['court'],
        downloadUrl: json['downloadUrl'],
        thumbnailUrl: json['thumbnailUrl'],
      );
}
