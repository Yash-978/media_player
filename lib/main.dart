import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/view/screen/bottomNavBar.dart';
import 'package:media_player/view/screen/home_screen/home.dart';
import 'package:media_player/view/screen/search_screen/search.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

import 'controller/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: Color(0xff212121),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff212121)),
        useMaterial3: true,
      ),
      // home: HomeScreen(),
      getPages: [
        GetPage(
          name: '/',
          page: () => HomeScreen(),
        ),
      ],
    );
  }
}

class Video {
  final String id;
  final String title;
  final String description;

  Video({required this.id, required this.title, required this.description});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id']['videoId'],
      title: json['snippet']['title'],
      description: json['snippet']['description'],
    );
  }
}

Future<List<Video>> fetchVideos(String query) async {
  final apiKey = 'AIzaSyDUj1q4U1E2AxCReqYgyTgB05eyDOilz94';
  final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&type=video&key=$apiKey');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return List<Video>.from(data['items'].map((item) => Video.fromJson(item)));
  } else {
    throw Exception('Failed to load videos');
  }
}

// class YoutubePlayerApp extends StatelessWidget {
//   final videoController = Get.put(VideoController());
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'YouTube Player',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('YouTube Player'),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 showSearch(context: context, delegate: VideoSearchDelegate());
//               },
//             ),
//           ],
//         ),
//         body: GetX<VideoController>(
//           builder: (controller) {
//             if (controller.isLoading.value) {
//               return Center(child: CircularProgressIndicator());
//             }
//
//             return ListView.builder(
//               itemCount: controller.videoList.length,
//               itemBuilder: (context, index) {
//                 final video = controller.videoList[index];
//                 return ListTile(
//                   title: Text(video.title),
//                   subtitle: Text(video.description),
//                   onTap: () {
//                     // Play the selected video
//                     _playVideo(video.id);
//                   },
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void _playVideo(String videoId) {
//     Get.to(() => VideoPlayerScreen(videoId: videoId));
//   }
// }

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  const VideoPlayerScreen({Key? key, required this.videoId}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(autoPlay: true),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Player')),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
      ),
    );
  }
}
