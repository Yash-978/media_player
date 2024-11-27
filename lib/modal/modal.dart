import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoModel {
  final String videoId;
  final String title;
  final String thumbnail;
  final bool autoPlay; // Automatically play the video
  final bool mute; // Start video with muted audio
  final bool loop; // Enable looping of the video
  final bool showControls; // Show video player controls
  final bool showFullscreenButton; // Show fullscreen button
  final bool showAnnotations; // Show annotations on video
  final bool showVideoInfo; // Display video information
  final double playbackRate;


  VideoModel({required this.videoId, required this.title, required this.thumbnail,this.autoPlay = false,
    this.mute = false,
    this.loop = false,
    this.showControls = true,
    this.showFullscreenButton = true,
    this.showAnnotations = true,
    this.showVideoInfo = true,
    this.playbackRate = 1.0,});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      videoId: json['id']['videoId'],
      title: json['snippet']['title'],
      thumbnail: json['snippet']['thumbnails']['default']['url'],
    );
  }
  YoutubePlayerController createController() {
    return YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: autoPlay,
        mute: mute,
        loop: loop,
        controlsVisibleAtStart: showControls,
        // forceHideAnnotation: !showAnnotations,
        disableDragSeek: false, // Allow scrubbing through the video
        hideControls: !showControls,
        enableCaption: true, // Enable captions (if available)
        // showVideoProgressIndicator: true, // Show progress bar
      ),
    )..setPlaybackRate(playbackRate); // Set playback speed
  }
}

// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Modal class for managing YouTube Player attributes
class YouTubeVideo {
  final String videoId; // YouTube video ID
  final bool autoPlay; // Automatically play the video
  final bool mute; // Start video with muted audio
  final bool loop; // Enable looping of the video
  final bool showControls; // Show video player controls
  final bool showFullscreenButton; // Show fullscreen button
  final bool showAnnotations; // Show annotations on video
  final bool showVideoInfo; // Display video information
  final double playbackRate; // Playback speed (e.g., 1.0, 1.5, 2.0)

  YouTubeVideo({
    required this.videoId,
    this.autoPlay = false,
    this.mute = false,
    this.loop = false,
    this.showControls = true,
    this.showFullscreenButton = true,
    this.showAnnotations = true,
    this.showVideoInfo = true,
    this.playbackRate = 1.0,
  });

  /// Generates a YouTubePlayerController with specified attributes
  YoutubePlayerController createController() {
    return YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: autoPlay,
        mute: mute,
        loop: loop,
        controlsVisibleAtStart: showControls,
        // forceHideAnnotation: !showAnnotations,
        disableDragSeek: false, // Allow scrubbing through the video
        hideControls: !showControls,
        enableCaption: true, // Enable captions (if available)
        // showVideoProgressIndicator: true, // Show progress bar
      ),
    )..setPlaybackRate(playbackRate); // Set playback speed
  }
}
class RelatedVideo {
  final String videoId;
  final String title;
  final String thumbnailUrl;
  final String channelName;

  RelatedVideo({
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
    required this.channelName,
  });

  factory RelatedVideo.fromJson(Map<String, dynamic> json) {
    return RelatedVideo(
      videoId: json['id']['videoId'],
      title: json['snippet']['title'],
      thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
      channelName: json['snippet']['channelTitle'],
    );
  }
}
