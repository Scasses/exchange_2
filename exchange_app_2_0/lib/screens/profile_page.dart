import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:exchange/providers/user_provider.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:exchange/providers/user_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
// import '../models/users.dart';
// import '../providers/video_provider.dart';
import '../resources/AuthMethods.dart';
import '../utilities/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  var userData = {};



  @override
  Widget build(BuildContext context) {
    // UserProvider userProvider = Provider.of<UserProvider>(context);
    // VideoProvider videoProvider = Provider.of<VideoProvider>(context);
    // Map<String, dynamic> userData = userProvider.userData;
    return isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 90.0,
              height: 115.0,
              color: Colors.blue,
              child: const Image(
                image: AssetImage('images/exchange_name.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(70.0),
              child: Container(
                color: Colors.red,
                width: 109.0,
                height: 70.0,
                child: SizedBox(
                  child: Center(
                    child: Text(
                      userData['userName'] ?? "Unavailable",
                      style: const TextStyle(color: Colors.white60),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuthMethods().signOut(context);
                print('clicked');
              },
              child: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body:  Column(
        children: [
          // Display video thumbnails
          // for (String videoUrl in videoProvider.videos)
          //   VideoThumbnail(url: videoUrl),
        ],
      ),
    );
  }
}