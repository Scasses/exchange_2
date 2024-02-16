import 'package:camera/camera.dart';
// import 'package:exchange/utilities/video_page.dart';
import 'package:exchange_app_2_0/utilities/video_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import '../resources/constants.dart';
import 'package:video_player/video_player.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool isLoading = true;
  bool _IsRecording = false;
  late CameraController _cameraController;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() {
      isLoading = false;
    });
  }

  _recordVideo() async {
    if (_IsRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() {
        _IsRecording = false;
      });
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(
          filePath: file.path,
          uid: FirebaseAuth.instance.currentUser!.uid,
        ),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() {
        _IsRecording = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        color: Colors.white,
        child: CircularProgressIndicator(),
      );
    } else {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CameraPreview(_cameraController),
          FloatingActionButton(onPressed: () {
            _recordVideo();
          })
        ],
      );
    }
  }
}