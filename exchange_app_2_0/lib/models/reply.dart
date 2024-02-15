import 'package:cloud_firestore/cloud_firestore.dart';

class Reply {
  final String username;
  final String uid;
  final String replyId;
  final String replyURL;
  final double thinking;
  final double feeling;
  final List interactions;

  const Reply(
      {required this.username,
        required this.uid,
        required this.replyId,
        required this.replyURL,
        required this.thinking,
        required this.feeling,
        required this.interactions});


  Map<String, dynamic> toJson() => {
    "username" : username,
    "uid" : uid,
    "replyID" : replyId,
    "replyURL" : replyURL,
    "thinking" : thinking,
    "feeling" : feeling,
    "interactions" : interactions,
  };

  static Reply fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Reply(
      username: snapshot['username'],
      uid: snapshot['uid'],
      replyId: snapshot['replyId'],
      replyURL: snapshot['replyURL'],
      thinking: snapshot['thinking'],
      feeling: snapshot['feeling'],
      interactions: snapshot['interactions'],
    );
  }
}