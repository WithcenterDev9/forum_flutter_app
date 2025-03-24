import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:forum_firebase_app/global.dart';
import 'package:forum_firebase_app/models/post.model.dart';
import 'package:forum_firebase_app/widgets/label_textfield.dart';
import 'package:forum_firebase_app/widgets/photo_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

// This the screen where the user can add a post

class PostCreateScreen extends StatefulWidget {
  static const String routeName = '/post_create/:category';
  final String category;
  final PostModel? post;
  const PostCreateScreen({super.key, required this.category, this.post});

  @override
  State<PostCreateScreen> createState() => _PostCreateScreenState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _PostCreateScreenState extends State<PostCreateScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance.ref();

  bool isLoading = false;
  late String selectedCategory;

  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category;
    if (widget.post != null) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
      selectedCategory = widget.post!.category;
    }
    if (widget.post != null && widget.post!.photoUrl != null) {
      _image = File(widget.post!.photoUrl!);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  void displaySnackbar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {});
    }
    print(_image);
  }

  Future<void> createPost() async {
    try {
      isLoading = true;
      setState(() {});

      String? photoUrl;
      if (_image != null) {
        // Delete the previous image if it exists
        if (widget.post != null && widget.post!.photoUrl != null) {
          final previousImageRef = storage.child(widget.post!.photoUrl!);
          await previousImageRef.delete();
        }

        final storageRef = storage.child(
          'posts/${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
        await storageRef.putFile(_image!);
        photoUrl = await storageRef.getDownloadURL();
      }

      final post = PostModel.create(
        title: titleController.text,
        body: bodyController.text,
        category: selectedCategory,
        photoUrl: photoUrl,
      );
      if (widget.post == null) {
        await db.collection('posts').add(post);
        displaySnackbar("Post added successfully");
      } else {
        await db.collection('posts').doc(widget.post!.id).update(post);
        displaySnackbar("Post updated successfully");
      }
      if (mounted) {
        context.pop();
      }
    } catch (e) {
      displaySnackbar("Failed to add post: $e");
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? "Add Post" : "Edit Post"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text("TEST: Add Photo"),
              ),
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
                    initialSelection: widget.category,
                    onSelected: (String? value) {
                      selectedCategory = value!;
                      setState(() {});
                    },
                    dropdownMenuEntries:
                        Category.categories
                            .map(
                              (e) =>
                                  DropdownMenuEntry<String>(value: e, label: e),
                            )
                            .toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(onPressed: createPost, child: Text("Post")),
            ],
          ),
        ),
      ),
    );
  }
}
