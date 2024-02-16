import 'dart:typed_data';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:exchange/models/reply.dart';
// import 'package:exchange/models/posts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


class StorageMethods {


  //Add an image to Firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List data, bool isPost) async {
    Reference reference = _storage
        .ref()
        .child('profile image/${DateTime.now()}.mp4')
        .child(_auth.currentUser!.uid);
    String response = 'Some error has occurred with the upload.';

    try {
      if (isPost) {
        String id = const Uuid().v1();
        reference = reference.child(id);

        UploadTask uploadTask = reference.putData(data);

        TaskSnapshot snapshot = await uploadTask;
        String downloadURL = await snapshot.ref.getDownloadURL();
        print(downloadURL);

        return downloadURL;
      }
    } catch (error) {
      response = error.toString();
    }
    return response;
  }

  //add a reply to firebase
  Future<String> uploadReplyToStorage(String childName, file) async {
    String response = 'There appears to be an error interrupting the upload.';

    try {
      Reference reference =
      _storage.ref().child(childName).child(_auth.currentUser!.uid);
      UploadTask uploadTask = reference.putFile(file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      saveVideoData(downloadURL);
      print(downloadURL);
      return downloadURL;
    } catch (error) {
      response = error.toString();
    }
    return response;
  }

  UploadTask? upLoadBytes(String destination, Uint8List data) {
    try {
      final reference = FirebaseStorage.instance.ref(destination);
    } on FirebaseException catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future<void> saveVideoData(String videoDownloadURL) async{
    await _firestore.collection('article response').add({
      'url': videoDownloadURL,
      'time stamp': FieldValue.serverTimestamp(),
      'username': 'username'
    });
  }
}