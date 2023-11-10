class VideoModel {
  String etag;
  String videoId;
  String title;
  String description;
  String thumbnailUrl;

  VideoModel({
    required this.etag,
    required this.videoId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    final snippet = json['snippet'];
    final thumbnails = snippet['thumbnails'];
    final defaultThumbnail = thumbnails['default'];

    return VideoModel(
      etag: json['etag'],
      videoId: json['id']['videoId'],
      title: snippet['title'],
      description: snippet['description'],
      thumbnailUrl: defaultThumbnail['url'],
    );
  }
}
