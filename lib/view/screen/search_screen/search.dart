import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/utils/global.dart';
import 'package:redacted/redacted.dart';

import '../../../controller/controller.dart';
import '../../../modal/modal.dart';
import '../video_screen/video.dart';

// class SearchScreen extends StatelessWidget {
//   final YouTubeController _controller = Get.put(YouTubeController());
//   final TextEditingController _searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("YouTube Search"),
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: "Search YouTube",
//                 border: OutlineInputBorder(),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: () {
//                     _controller.fetchVideos(_searchController.text);
//                   },
//                 ),
//               ),
//             ),
//           ),
//           // Video List
//           Expanded(
//             child: Obx(() {
//               if (_controller.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               if (_controller.videos.isEmpty) {
//                 return Center(child: Text("No videos found"));
//               }
//               return ListView.builder(
//                 itemCount: _controller.videos.length,
//                 itemBuilder: (context, index) {
//                   final video = _controller.videos[index];
//                   final videoId = video['id']['videoId'];
//                   final title = video['snippet']['title'];
//                   final thumbnail = video['snippet']['thumbnails']['default']['url'];
//                   return ListTile(
//                     leading: Image.network(thumbnail),
//                     title: Text(title),
//                     onTap: () {
//                       Get.to(() => VideoPlayerScreen(videoId: videoId));
//                     },
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/youtube_logo2.jpg',
              width: 35,
              height: 35,
            ),
            SizedBox(
              width: w * 0.025,
            ),
            Text(
              'YouTube',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: white,),
            onPressed: () {
              showSearch(context: context, delegate: VideoSearchDelegate());
            },
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.cast,color: white)),
          IconButton(
              onPressed: () {}, icon: Badge(child: Icon(Icons.notifications,color: white))),
        ],
      ),
      body: Center(
        child: Text("Search YouTube videos"),
      ),
    );
  }
}

class VideoSearchDelegate extends SearchDelegate {
  final YouTubeController _controller = Get.put(YouTubeController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _controller.fetchVideos(query);
    return Obx(() {
      if (_controller.isLoading.value) {
        return ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                leading: Container(
                  width: 80,
                  height: 50,
                  color: Colors.grey[300],
                ).redacted(context: context, redact: true),
                title: Container(
                  height: 10,
                  color: Colors.grey[300],
                ).redacted(context: context, redact: true),
                subtitle: Container(
                  height: 10,
                  width: 100,
                  color: Colors.grey[300],
                ).redacted(context: context, redact: true),
              ),
            );
          },
        );
      }
      if (_controller.videos.isEmpty) {
        return Center(child: Text("No results found"));
      }
      return ListView.builder(
        itemCount: _controller.videos.length,
        itemBuilder: (context, index) {
          final video = VideoModel.fromJson(_controller.videos[index]);
          return ListTile(
            leading: Image.network(video.thumbnail),
            title: Text(video.title),
            onTap: () {
              Get.to(() => VideoPlayerScreen(videoId: video.videoId));
            },
          );
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    if (query.isEmpty) {
      return Center(
          child: Container(
              height: h * 1,
              width: w * 1,
              decoration: BoxDecoration(color: bgColor),
              alignment: Alignment.center,
              child: Text(
                "Search for videos",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              )));
    }
    return Container(
      height: h * 1,
      width: w * 1,
      decoration: BoxDecoration(color: bgColor),
    );
  }
}
