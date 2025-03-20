import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String? id;
  final String title;
  final String body;

  Post({this.id, required this.title, required this.body});

  factory Post.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return Post(id: snapshot.id, title: data['title'], body: data['body']);
  }

  Map<String, dynamic> toFirestore() {
    return {'title': title, 'body': body};
  }
}
