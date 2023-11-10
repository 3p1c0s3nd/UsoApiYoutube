import 'dart:convert';
import 'package:aplicacion_videos/models/VideoModel.dart';
import 'package:aplicacion_videos/main.dart';
import 'package:http/http.dart' as http;

class ConexionHttp {
  final String url;
  ConexionHttp({required this.url});

  static Future<List<VideoModel>> searchVideos(String query) async {
    const num = 33;
    var apiKey =
        'AIzaSyB8PzTxmzUo38BCclNkMlsuwkU4K5B5xK8'; // Replace with your YouTube API Key
    var url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&maxResults=$num&&type=video&key=$apiKey';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<dynamic> videosJson = jsonData['items'];
      //
      List<VideoModel> videos = videosJson
        .map((json) => VideoModel.fromJson(json))
        .toList();
      /*print("Contenido de la lista videos:");
videos.forEach((video) {
  print("Etag: ${video.etag}");
  print("Video ID: ${video.videoId}");
  print("Título: ${video.title}");
  print("Descripción: ${video.description}");
  print("URL de la miniatura: ${video.thumbnailUrl}");
  print("--------------------------");
});*/
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
