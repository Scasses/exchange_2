import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:exchange/responsive/mobile_screen_layout.dart';
// import 'package:exchange/responsive/responsive_screen.dart';
// import 'package:exchange/responsive/web_screen_layout.dart';
// import 'package:exchange/screens/news_headlines_page.dart';
// import 'package:exchange/utilities/utils.dart';
import 'package:exchange_app_2_0/utilities/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../resources/firestore_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_screen.dart';
import '../responsive/web_screen_layout.dart';

class VideoPage extends StatefulWidget {
  final String filePath;
  final String uid;
  const VideoPage({Key? key, required this.filePath, required this.uid})
      : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  var userData = {};
  bool _isLoading = false;
  String errorRes = 'An error has occurred. Please try agaain.';

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  // Future _initVideoPlayer() async {
  //   // final videoFile = widget.filePath;
  //   // String videoURL = await _firestoreMethods.videoReply(
  //   //     userData['userName'], widget.uid, widget.uid, videoFile);
  //   _videoPlayerController = VideoPlayerController.networkUrl(Uri(path: videoURL)); // Use the network constructor
  //   await _videoPlayerController.initialize();
  //   await _videoPlayerController.setLooping(true);
  //   await _videoPlayerController.play();
  // }

  getData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      userData = userSnap.data()!;
      print(userData);
      if (userData != null) {
        print('User data is not null');
      } else {
        print('It is working');
        setState(() {});
      }
    } catch (error) {
      showSnackBar(error.toString(), context);
      print(error.toString());
      print('An error has occurred, Null again.');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            onPressed: () async {
              final videoFile = widget.filePath;
              if (videoFile != null) {
                String videoURL = await _firestoreMethods.articleResponse(
                    userData['userName'], widget.uid, widget.uid, videoFile);
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => NewsHeadlinesScreen(
                //         uid: FirebaseAuth.instance.currentUser!.uid),
                //   ),
                // );
                print('Video uploaded successfully. VideoURL: $videoURL');
              } else {
                showSnackBar(errorRes, context);
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ResponsiveLayout(
                      webScreenLayout: const WebScreenLayout(),
                      mobileScreenLayout: MobileScreenLayout(),
                    )),
              );
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _initVideoPlayer(),
        builder: (BuildContext context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController);
          }
        },
      ),
    );
  }
}