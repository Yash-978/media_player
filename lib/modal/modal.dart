class VideoModel {
  final String videoId;
  final String title;
  final String thumbnail;

  VideoModel({required this.videoId, required this.title, required this.thumbnail});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      videoId: json['id']['videoId'],
      title: json['snippet']['title'],
      thumbnail: json['snippet']['thumbnails']['default']['url'],
    );
  }
}