import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:forum_firebase_app/models/post.model.dart';
import 'package:forum_firebase_app/screens/forum/post.create.screen.dart';

class PostViewScreen extends StatefulWidget {
  static const String routeName = '/forum/view';
  final PostModel post;

  const PostViewScreen({super.key, required this.post});

  @override
  State<PostViewScreen> createState() => _PostViewScreenState();
}

class _PostViewScreenState extends State<PostViewScreen> {
  Future<void> _deletePost() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      await db.collection('posts').doc(widget.post.id).delete();

      if (widget.post.photoUrl != null) {
        final previousImageRef = FirebaseStorage.instance.refFromURL(
          widget.post.photoUrl!,
        );
        await previousImageRef.delete();
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to delete post: $e')));
      }
    }
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this post?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Dismiss the dialog
                await _deletePost();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post View"),
        actions: [
          IconButton(icon: const Icon(Icons.delete), onPressed: _confirmDelete),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (widget.post.photoUrl != null)
              Image.network(widget.post.photoUrl!),
            Text(widget.post.title),
            Text(widget.post.body),
            Text(widget.post.category),
            Text(widget.post.createdAt.toString()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => PostCreateScreen(
                    category: widget.post.category,
                    post: widget.post,
                  ),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
