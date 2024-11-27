import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/utils/global.dart';
import 'package:redacted/redacted.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/controller.dart';
import '../../../modal/modal.dart';
import '../video_screen/video.dart';



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
            SizedBox(width: w * 0.025),
            Text(
              'YouTube',
              style: TextStyle(color: white),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: white),
            onPressed: () {
              showSearch(context: context, delegate: VideoSearchDelegate());
            },
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.cast, color: white)),
          IconButton(
            onPressed: () {},
            icon: Badge(child: Icon(Icons.notifications, color: white)),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Search YouTube videos",
          style: TextStyle(
            color: white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class VideoSearchDelegate extends SearchDelegate {
  final YouTubeController controller = Get.put(YouTubeController());

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: white,
      appBarTheme: AppBarTheme(
        backgroundColor: bgColor,

        iconTheme: IconThemeData(color: white), // Icon color
        toolbarTextStyle: TextStyle(color: white, fontSize: 18),
        titleTextStyle: TextStyle(color: white, fontSize: 18),
      ),
      inputDecorationTheme: InputDecorationTheme(
        // filled: true,
        fillColor: white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: white),
          borderRadius: BorderRadius.circular(30),
          // borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: white),
          borderRadius: BorderRadius.circular(30),
          // borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: white.withOpacity(0.7)), // Hint color
      ),
    );
  }

  @override
  // InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
  //       filled: true,
  //       fillColor: Colors.grey[900],
  //       // Background color of the text field
  //       contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         borderSide: BorderSide.none,
  //       ),
  //       hintStyle: TextStyle(color: Colors.white70), // Hint text color
  //     );

  @override
  TextStyle? get searchFieldStyle => const TextStyle(
        color: Colors.white, // Search text color
        fontSize: 16,
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: white),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: white),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    controller.fetchVideos(query);
    return Obx(() {
      if (controller.isLoading.value) {
        return Container(
          decoration: BoxDecoration(
            color: bgColor,
          ),
          child: ListView.builder(
            itemCount: 12,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListTile(
                    leading: Container(
                      width: 80,
                      height: 50,
                      color: Colors.grey[300],
                    ),
                    title: Container(
                      height: 10,
                      color: Colors.grey[300],
                    ),
                    subtitle: Container(
                      height: 10,
                      width: 100,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
      if (controller.videos.isEmpty) {
        return Center(
          child: Text(
            "No results found",
            style: TextStyle(color: white),
          ),
        );
      }
      return ListView.builder(
        itemCount: controller.videos.length,
        itemBuilder: (context, index) {
          final video = VideoModel.fromJson(controller.videos[index]);
          return Container(
            decoration: BoxDecoration(color: bgColor),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => VideoPlayerScreen(
                        videoId: video.videoId,
                        title: video.title,
                      ),
                    );
                  },
                  child: Container(
                    height: h * 0.25,
                    width: w * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(color: white,),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(video.thumbnail),
                      ),
                    ),
                  ),
                ),
                Text(
                  video.title,
                  style: TextStyle(color: white),
                ),
                SizedBox(
                  height: h * 0.01,
                ),
              ],
            ),
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
          height: h,
          width: w,
          color: bgColor,
          alignment: Alignment.center,
          child: Text(
            "Search for videos",
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      );
    }
    return Container(
      height: h,
      width: w,
      color: bgColor,
    );
  }
}
