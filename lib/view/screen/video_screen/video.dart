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

class VideoPlayerScreen extends StatelessWidget {
  final String videoId;

  VideoPlayerScreen({required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: Center(
        child: YoutubePlayer(

          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
              // captionLanguage:
            ),
          ),
        ),
      ),
    );
  }
}
