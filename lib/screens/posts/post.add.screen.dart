import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum_firebase_app/models/post.model.dart';
import 'package:forum_firebase_app/widgets/label_textfield.dart';
import 'package:forum_firebase_app/widgets/photo_picker.dart';

// This the screen where the user can add a post

class PostAddScreen extends StatefulWidget {
  const PostAddScreen({super.key});

  @override
  State<PostAddScreen> createState() => _PostAddScreenState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _PostAddScreenState extends State<PostAddScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isLoading = false;

  static const List<String> list = <String>["Discussion", "Question"];
  static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    list.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  );
  String dropdownValue = list.first;

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  void mountHelp(String message) {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> addPost() async {
    try {
      isLoading = true;
      setState(() {});
      final post = PostModel(
        title: titleController.text,
        body: bodyController.text,
        category: dropdownValue,
      );
      await db.collection('posts').add(post.toFirestore());
      mountHelp("Post added successfully");
    } catch (e) {
      mountHelp("Failed to add post: $e");
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Post")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              PhotoPicker(),
              const SizedBox(height: 20),
              LabelTextfield(label: "Title", controller: titleController),
              LabelTextfield(
                label: "Body",
                controller: bodyController,
                isMultilined: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Post Type:"),
                  SizedBox(width: 20),
                  DropdownMenu(
                    initialSelection: list.first,
                    onSelected: (String? value) {
                      dropdownValue = value!;
                      setState(() {});
                    },
                    dropdownMenuEntries: menuEntries,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(onPressed: addPost, child: Text("Post")),
            ],
          ),
        ),
      ),
    );
  }
}
