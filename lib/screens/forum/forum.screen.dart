import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum_firebase_app/models/post.model.dart';
import 'package:forum_firebase_app/screens/forum/post.create.screen.dart';
import 'package:forum_firebase_app/screens/forum/post.view.screen.dart';
import 'package:go_router/go_router.dart';

class ForumScreen extends StatefulWidget {
  final String category;
  static const String routeName = '/forum/:category';
  const ForumScreen({super.key, required this.category});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text(widget.category)),

      body: FirestoreListView<Map<String, dynamic>>(
        query: FirebaseFirestore.instance
            .collection('posts')
            .where('category', isEqualTo: widget.category)
            .orderBy('createdAt', descending: true),
        itemBuilder: (context, snapshot) {
          PostModel post = PostModel.fromSnapshot(snapshot);

          return ListTile(
            title: Text(post.title),
            subtitle: Text(post.createdAt.toString()),
            onTap:
                () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PostViewScreen(post: post),
                  ),
                ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:
            () => context.push(
              PostCreateScreen.routeName,
              extra: {'category': widget.category},
            ),
      ),
    ));
  }
}
