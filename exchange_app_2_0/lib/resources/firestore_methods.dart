import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:exchange/resources/storage_methods.dart';
import 'package:exchange_app_2_0/resources/storage_methods.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
// import '../models/posts.dart';
import '../models/posts_model.dart';
import '../models/reply.dart';

// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Upload video reply
  Future<String> uploadPosts(
      String filePath, String uid, String username) async {
    String response = 'There has been an error uploading your post.';
    try {
      String postID = const Uuid().v1();
      Posts post = Posts(
          username: username,
          uid: uid,
          postId: postID,
          postURL: '',
          thinking: 0,
          feeling: 0,
          interactions: []);

      _firestore.collection('posts').doc(postID).set(
        post.toJson(),
      );
      response = 'Success';
    } catch (error) {
      response = error.toString();
      print(response);
    }
    return response;
  }

  Future<String> videoReply(
      String username, String uid, String replyID, String filePath) async {
    String res = "Unfortunately an error has occurred";
    File file = File(filePath);

    try {
      String replyVid =
      await StorageMethods().uploadReplyToStorage('reply', file);
      String replyId = const Uuid().v1();
      Reply reply = Reply(
          username: username,
          uid: uid,
          replyId: replyId,
          replyURL: replyVid,
          thinking: 0,
          feeling: 0,
          interactions: []);

      _firestore.collection('reply').doc(replyId).set(
        reply.toJson(),
      );
      res = "Success";
    } catch (error) {
      res = error.toString();
      print(error.toString());
    }
    return res;
  }



  Future<String> articleResponse(
      String username, String uid, String replyID, String filePath) async {
    String res = "Unfortunately an error has occurred";
    File file = File(filePath);

    try {
      String replyVid =
      await StorageMethods().uploadReplyToStorage('response', file);
      String replyId = const Uuid().v1();
      Reply reply = Reply(
          username: username,
          uid: uid,
          replyId: replyId,
          replyURL: replyVid,
          thinking: 0,
          feeling: 0,
          interactions: []);

      _firestore.collection('article response').doc(replyId).set(
        reply.toJson(),
      );
      res = "Success";
    } catch (error) {
      res = error.toString();
      print(error.toString());
    }
    return res;
  }

  //updating iQ count
  Future<void> logicPostUpdate(String postId, String uid, List logic) async {
    try {
      if (logic.contains(uid)) {
        await _firestore.collection('article response').doc(postId).update({
          'thinking': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('article response').doc(postId).update({
          'thinking': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }

  // Future<void> eQPostUpdate(String postId, String uid, List logic) async {
  //   try {
  //     if (logic.contains(uid)) {
  //       await _firestore.collection('article response').doc(postId).update({
  //         'thinking': FieldValue.arrayRemove([uid]),
  //       });
  //     } else {
  //       await _firestore.collection('article response').doc(postId).update({
  //         'thinking': FieldValue.arrayUnion([uid]),
  //       });
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //   }

  // updating eQ count
  Future<void> eQPostUpdate(String postId, String uid, List eQ) async {
    try {
      if (eQ.contains(uid)) {
        await _firestore.collection('article response').doc(postId).update({
          'feeling': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('article response').doc(postId).update({
          'feeling': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (error) {
      print(error.toString());
      print('There was an error');
    }
  }

  Future<void> saveVideoData(String videoDownloadURL) async{
    await _firestore.collection('article response').add({
      'url': videoDownloadURL,
      'time stamp': FieldValue.serverTimestamp(),
      'username': 'username'
    });
  }

  //deleting post
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> userAudience(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
      await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['audience'];
      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'audience': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(followId).update({
          'ofInterest': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'audience': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(followId).update({
          'audience': FieldValue.arrayUnion([uid])
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }
}