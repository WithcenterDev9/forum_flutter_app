import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum_firebase_app/models/post.model.dart';
import 'package:forum_firebase_app/widgets/label_textfield.dart';

// This the screen where the user can add a post

class PostAddScreen extends StatefulWidget {
  const PostAddScreen({super.key});

  @override
  State<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  void testValues() {
    print(titleController.text);
    print(bodyController.text);
  }

  Future<void> post() async {
    // final post = <String, dynamic>{
    //   'title': titleController.text,
    //   'body': bodyController.text,
    // };
    final post = Post(title: titleController.text, body: bodyController.text);

    await db.collection('posts').add(post.toFirestore());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            LabelTextfield(label: "Title", controller: titleController),
            LabelTextfield(
              label: "Body",
              controller: bodyController,
              isMultilined: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: 
                post,
              
              child: Text("Post"),
            ),
          ],
        ),
      ),
    );
  }
}
