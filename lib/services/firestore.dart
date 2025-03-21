import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseFireStore {
  static final _instance = DatabaseFireStore._internal();
  final db = FirebaseFirestore.instance;

  DatabaseFireStore._internal();

  // Example method to access DatabaseFireStore instance
  static DatabaseFireStore get instance => _instance;

  get allPosts => db.collection('posts');
  Query get discussions =>
      db.collection('posts').where('category', isEqualTo: 'Discussion');
  
}
