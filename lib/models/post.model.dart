import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? id;
  final String title;
  final String body;
  final String? photoUrl;
  final String category;

  PostModel({
    this.id,
    required this.title,
    required this.body,
    required this.category,
    this.photoUrl,
  });

  factory PostModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return PostModel(
      id: snapshot.id,
      title: data['title'],
      body: data['body'],
      category: data['category'],
      photoUrl: data['photoUrl'] | "",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'body': body,
      'category': category,
      'photoUrl': photoUrl,
    };
  }
}
