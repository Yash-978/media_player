// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:file_picker/file_picker.dart';



import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class YouTubeController extends GetxController {
  final String apiKey = "AIzaSyDUj1q4U1E2AxCReqYgyTgB05eyDOilz94";
  var videos = <dynamic>[].obs; // Observable list for videos
  var isLoading = false.obs; // Loading state


  Future<void> fetchVideos(String query) async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&type=video&maxResults=10&key=$apiKey',
        ),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        videos.value = data['items'];
      } else {
        Get.snackbar("Error", "Failed to fetch videos: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false; // Hide loader
    }
  }
}


class VideoController extends GetxController {
  var searchQuery = ''.obs;
  var videoList = <Video>[].obs;
  var isLoading = false.obs;

  // Fetch videos based on search query
  Future<void> searchVideos(String query) async {
    searchQuery.value = query;
    isLoading.value = true;
    // Call the YouTube API to search for videos
    final results = await fetchVideos(query);
    videoList.value = results;
    isLoading.value = false;
  }
}
