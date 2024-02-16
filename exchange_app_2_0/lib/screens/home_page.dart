import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:exchange/resources/AuthMethods.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:exchange/resources/constants.dart';
// import 'package:exchange/utilities/utils.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../resources/AuthMethods.dart';
import '../widgets/modal_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String errResponse = 'An error has occurred.';
  late String videoURL = '';

  @override
  void initState() {
    super.initState();
    fetchVideoURL();
  }

  Future<void> fetchVideoURL() async {
    try {
      final String url =
      await FirebaseStorage.instance.ref('response').getDownloadURL();
      print(url);
      print('The URL is above');
      setState(() {
        videoURL = url;
        // print(videoURL);
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future<Uint8List?> generateThumbnail(String passedVideoURL) async {
    final thumbnail = await VideoThumbnail.thumbnailData(
        video: passedVideoURL, imageFormat: ImageFormat.JPEG, quality: 25);
    return thumbnail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 125.0,
              height: 115.0,
              child: const Image(
                image: AssetImage('images/exchange_name.png'),
              ),
            ),
            Container(
              color: Colors.white10,
              width: 30.0,
              height: 70.0,
              child: GestureDetector(
                onTap: () {
                  FirebaseAuthMethods().signOut(context);
                  print('clicked');
                },
                child: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: FutureBuilder<Uint8List?>(
          future: generateThumbnail(videoURL),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data is Uint8List) {
                return Image.memory(snapshot.data);
              } else {
                return const Text('Thumbnail unavailable right now');

              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      // Stack(
      //   alignment: Alignment.topCenter,
      //   children: [
      //     Container(
      //       height: 500,
      //       child: const Image(
      //         image: AssetImage('images/earthRise.png'),
      //       ),
      //     ),
      //     Opacity(
      //       opacity: .7,
      //       child: Container(
      //         height: 415,
      //         child: const Image(
      //           image: AssetImage('images/exchangeS.png'),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
