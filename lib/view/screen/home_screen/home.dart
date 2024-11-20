// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../controller/controller.dart';
// import '../video_screen/video.dart';
//
// class HomeScreen extends StatelessWidget {
//   final VideoAudioController controller = Get.put(VideoAudioController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Video & Audio Player with GetX"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: controller.pickAndPlayVideo,
//               child: Text("Pick and Play Video"),
//             ),
//             Obx(() {
//               if (controller.isVideoPlaying.value && controller.videoPlayerController != null) {
//                 return ElevatedButton(
//                   onPressed: () => Get.to(() => VideoPlayerScreen()),
//                   child: Text("Watch Video"),
//                 );
//               }
//               return SizedBox();
//             }),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: controller.pickAndPlayAudio,
//               child: Text("Pick and Play Audio"),
//             ),
//             Obx(() {
//               if (controller.isAudioPlaying.value) {
//                 return Text("Audio is playing...");
//               }
//               return SizedBox();
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
