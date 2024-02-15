import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  final String username;
  final String uid;
  final String postId;
  final String postURL;
  final double thinking;
  final double feeling;
  final List interactions;

  const Posts(
      {required this.username,
        required this.uid,
        required this.postId,
        required this.postURL,
        required this.thinking,
        required this.feeling,
        required this.interactions});



  Map<String, dynamic> toJson() => {
    "username" : username,
    "uid" : uid,
    "postID" : postId,
    "postURL" : postURL,
    "thinking" : thinking,
    "feeling" : feeling,
    "interactions" : interactions,
  };



  static Posts fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Posts(
      username: snapshot['username'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      postURL: snapshot['postURL'],
      thinking: snapshot['thinking'],
      feeling: snapshot['feeling'],
      interactions: snapshot['interactions'],
    );
  }


  Map<String, dynamic> toFirestore() {
    return {
      if (username != null) "username": username,
      if (uid != null) "uid": uid,
      if (postId != null) "postId": postId,
      if (postURL != null) "postURL": postURL,
      if (thinking != null) "thinking": thinking,
      if (feeling != null) "feeling": feeling,
    };
  }


}