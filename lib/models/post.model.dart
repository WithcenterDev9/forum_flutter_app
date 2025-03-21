import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? id;
  final String title;
  final String body;
  final String? photoUrl;
  final String category;
  final DateTime createdAt;

  PostModel({
    this.id,
    required this.title,
    required this.body,
    required this.category,
    this.photoUrl,
    required this.createdAt,
  });

  factory PostModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return PostModel(
      id: snapshot.id,
      title: data['title'],
      body: data['body'],
      category: data['category'],
      photoUrl: data['photoUrl'] ?? "",
      createdAt: data['createdAt']?.toDate() ?? DateTime.now(),
    );
  }

  static Map<String, dynamic> create({
    required String title,
    required String body,
    required String category,
    String? photoUrl,
  }) {
    return {
      'title': title,
      'body': body,
      'category': category,
      'photoUrl': photoUrl,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
