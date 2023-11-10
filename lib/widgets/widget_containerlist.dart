import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:aplicacion_videos/conexion_http/conexion_http.dart';

import '../screen/VideoPlayerScreen.dart';

class VideoData {
  final String etag;
  final String videoId;
  final String title;
  final String description;
  final String thumbnailUrl;

  VideoData({
    required this.etag,
    required this.videoId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
  });
}

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final TextEditingController inputSearchController = TextEditingController();
  List<YoutubePlayerController> controllersYoutubePlayer = [];
  bool buscar = false;
  List<VideoData> videos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prueba de videos youtube")),
      body: Column(
        children: [
          TextField(
            controller: inputSearchController,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Buscar',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    ConexionHttp.searchVideos(inputSearchController.text).then((videosData) {
                      videos = videosData.map((video) {
                        return VideoData(
                          etag: video.etag,
                          videoId: video.videoId,
                          title: video.title,
                          description: video.description,
                          thumbnailUrl: video.thumbnailUrl,
                        );
                      }).toList();

                      controllersYoutubePlayer = videos.map((videoData) {
                        return YoutubePlayerController(
                          initialVideoId: videoData.videoId,
                          flags: const YoutubePlayerFlags(
                            mute: false,
                            autoPlay: false,
                            disableDragSeek: false,
                            loop: false,
                            isLive: false,
                            forceHD: false,
                            enableCaption: true,
                          ),
                        );
                      }).toList();

                      buscar = true;
                      setState(() {});
                    }).catchError((error) {
                      print(error);
                    });
                  },
                )),
          ),
          if (buscar)
            Expanded(
                child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return WidgetContainerList(videoData: videos[index]);
              },
            ))
        ],
      ),
    );
  }
}

class WidgetContainerList extends StatelessWidget {
  final VideoData videoData;

  const WidgetContainerList({
    Key? key,
    required this.videoData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Aquí puede manejar la acción de tocar para reproducir el video
        print("Video tapped: ${videoData.title}");
         Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerScreen(videoId: videoData.videoId),
        ),
      );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(videoData.thumbnailUrl, width: 150, height: 100),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    videoData.title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
