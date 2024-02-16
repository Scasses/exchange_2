import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  Future<XFile?> captureVideo() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.camera,
      );
      return video;
    } catch (e) {
      print(e);
      // Handle any errors or exceptions here
      return null;
    }
  }




  @override
  Widget build(BuildContext context) {
    return Container();
  }
}