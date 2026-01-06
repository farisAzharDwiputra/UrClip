class VideoModel {
  final String id;
  final String title;
  final String court;
  final int courtNumber;
  final String downloadUrl;
  final String thumbnailUrl;
  final int? clipStartSeconds;
  final int? clipDurationSeconds;


  VideoModel({
    required this.id,
    required this.title,
    required this.court,
    required this.courtNumber,
    required this.downloadUrl,
    required this.thumbnailUrl,
    this.clipStartSeconds,
    this.clipDurationSeconds,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
    id: json['id'],
    title: json['title'],
    court: json['court'],
    courtNumber: json['courtNumber'],
    downloadUrl: json['downloadUrl'],
    thumbnailUrl: json['thumbnailUrl'],
    clipStartSeconds: json['clipStartSeconds'],
    clipDurationSeconds: json['clipDurationSeconds'], 
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'court': court,
    'courtNumber': courtNumber,
    'downloadUrl': downloadUrl,
    'thumbnailUrl': thumbnailUrl,
    'clipStartSeconds': clipStartSeconds,
    'clipDurationSeconds': clipDurationSeconds,
  };
}
