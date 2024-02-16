import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchange_app_2_0/widgets/think_feel.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../resources/firestore_methods.dart';
import '../utilities/image_picker.dart';
import '../utilities/utils.dart';

class ModalScreen extends StatefulWidget {
  final snap;
  final String videoURL;
  final String videoUsername;
  final String uid;
  const ModalScreen(
      {super.key,
        this.snap,
        required this.videoURL,
        required this.videoUsername,
        required this.uid});
  @override
  State<ModalScreen> createState() => _ModalScreenState();
}

class _ModalScreenState extends State<ModalScreen> {
  late VideoPlayerController _controller;
  bool isLoading = false;
  var userData = {};

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoURL),
    );
    // videoPlay();
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    super.initState();
  }

  //
  // void videoPlay() {
  //   _controller.setLooping(true);
  //   _controller.initialize().then((_) => setState(() {}));
  //   _controller.play();
  // }

  final List people = [
    'Sheldon',
    'Bobby',
    'Cory',
    'John',
    'Anthony',
    'Osirus',
    'Socrates'
  ];

  getData() async {
    setState(() {
      isLoading = true;
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
      isLoading = false;
    });
  }

  // void postVideoUser(
  //     String title, String uid, String username, String profImage) async {
  //   try {
  //     String response = await FirestoreMethods()
  //         .uploadPosts(_title.text, _file!, uid, username, profImage);
  //     if (response == 'success') {
  //       showSnackBar('Reply Submitted', context);
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       clearVid();
  //     } else {
  //       showSnackBar(response, context);
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   } catch (error) {
  //     showSnackBar(error.toString(), context);
  //   }
  // }
  //
  // void clearVid() {
  //   setState(() {
  //     _file = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final User? user = Provider.of<UserProvider>(context).getUser;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   //\If video is playing, pause it
                    //   if (_controller.value.isPlaying) {
                    //     _controller.pause();
                    //   } else {
                    //     //If the video is paused, play it
                    //     _controller.play();
                    //   }
                    // });
                    print('clicked');
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          width: 250.0,
                          height: 270.0,
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(child: VideoPlayer(_controller)),
                                Container(
                                  child: const Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Name: ',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Logic: ',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'EQ: ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 130,
                        height: 270,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: people.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  print('clicked');
                                },
                                child: Container(
                                  width: 100,
                                  margin: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                  ),
                                  height: 100,
                                  child: const Center(
                                    child: Text(
                                      'Video',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 400.0,
                      height: 40.0,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: LinearProgressIndicator(
                        value: 0.7,
                        color: Colors.red.withAlpha(100),
                        backgroundColor: Colors.blue.withAlpha(110),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ThinkFeel(
                          color: Colors.white,
                          buttonType: 'Feeling',
                          onPressed: () async {
                            await FirestoreMethods().eQPostUpdate(
                                widget.snap['article response'],
                                widget.videoUsername,
                                widget.snap['feeling']);
                            print('Feeling clicked');
                          },
                          width: 110,
                          icon: const Icon(Icons.monitor_heart,
                              color: Colors.red),
                          height: 90,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ThinkFeel(
                          color: Colors.white,
                          buttonType: 'Reply',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const CameraPage(),
                              ),
                            );
                          },
                          width: 110,
                          icon: const Icon(Icons.reply),
                          height: 90,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        // child: ReactResponse(
                        //   color: Colors.white,
                        //   buttonType: 'Response',
                        //   onPressed: () async {
                        //     await FirestoreMethods().iQPostUpdate(
                        //         widget.snap['replyId'],
                        //         user!.uid,
                        //         widget.snap['iQ']);
                        //   },
                        //   width: 80,
                        // ),
                        child: ThinkFeel(
                          color: Colors.white,
                          buttonType: 'Thinking',
                          onPressed: () async {
                            await FirestoreMethods().logicPostUpdate(
                                widget.snap['article response'],
                                widget.videoUsername,
                                widget.snap['thinking']);
                            print('Thinking Clicked');
                            print(widget.snap['Thinking']);
                          },
                          width: 110,
                          icon: const Icon(
                            Icons.smart_toy_outlined,
                            color: Colors.blue,
                          ),
                          height: 90,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

