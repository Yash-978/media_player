// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'package:video_player/video_player.dart';
//
// import '../../../controller/controller.dart';
//
// class VideoPlayerScreen extends StatelessWidget {
//   final VideoAudioController controller = Get.find<VideoAudioController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video Player"),
//       ),
//       body: Center(
//         child: controller.videoPlayerController == null
//             ? Text("No video selected")
//             : Column(
//           children: [
//             AspectRatio(
//               aspectRatio: controller.videoPlayerController!.value.aspectRatio,
//               child: VideoPlayer(controller.videoPlayerController!),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: controller.toggleVideoPlayPause,
//               child: Obx(() {
//                 return Text(
//                   controller.videoPlayerController!.value.isPlaying ? "Pause" : "Play",
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class VideoPlayerScreen extends StatelessWidget {
//   final String videoId;
//
//   VideoPlayerScreen({required this.videoId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video Player"),
//       ),
//       body: Center(
//         child: YoutubePlayer(
//           showVideoProgressIndicator: true,
//           controller: YoutubePlayerController(
//             initialVideoId: videoId,
//             flags: YoutubePlayerFlags(
//               autoPlay: true,
//               mute: false,
//               // captionLanguage:
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../utils/global.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoId;
  final String title;




  VideoPlayerScreen({required this.videoId,required this.title,});

  final List<Map<String, String>> relatedVideos = [
    {
      "videoId": "dQw4w9WgXcQ",
      "title": "Never Gonna Give You Up",
      "thumbnail": "https://img.youtube.com/vi/dQw4w9WgXcQ/0.jpg"
    },
    {
      "videoId": "oHg5SJYRHA0",
      "title": "Another Cool Video",
      "thumbnail": "https://img.youtube.com/vi/oHg5SJYRHA0/0.jpg"
    },
    // Add more related videos here
  ];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Video Player
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
            ),
            builder: (context, player) {
              return Column(
                children: [
                  // Video Player Section
                  Container(
                    height: h * 0.35,
                    width: w,
                    color: Colors.black,
                    child: player,
                  ),
                  // Video Info Section
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 8),
                        Text(
                          "1.2M views • 2 days ago",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _interactionButton(Icons.thumb_up, "Like"),
                            _interactionButton(Icons.thumb_down, "Dislike"),
                            _interactionButton(Icons.share, "Share"),
                            _interactionButton(Icons.download, "Download"),
                            _interactionButton(Icons.save_alt, "Save"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Divider(color: Colors.grey[800], thickness: 1),
          // Related Videos
          Expanded(
            child: ListView.builder(
              itemCount: relatedVideos.length,
              itemBuilder: (context, index) {
                final relatedVideo = relatedVideos[index];
                return GestureDetector(
                  onTap: () {
                    // Get.to(() => VideoPlayerScreen(videoId: relatedVideo["videoId"]!, title: title, showVideoInfo:true,));
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: h * 0.25,
                          width: w * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // border: Border.all(color: white,),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(relatedVideo["thumbnail"]!),
                            ),
                          ),
                        ),
                        Text(
                          relatedVideo["title"]!,
                          style: TextStyle(color: white),
                        ),
                        SizedBox(
                          height: h * 0.01,
                        ),
                      ],
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: Row(
                      children: [
                        // Thumbnail
                        Container(
                          width: w * 0.4,
                          height: h * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(relatedVideo["thumbnail"]!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        // Title
                        Expanded(
                          child: Text(
                            relatedVideo["title"]!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),*/
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Interaction Buttons
  Widget _interactionButton(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
