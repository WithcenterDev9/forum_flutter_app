import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum_firebase_app/global.dart';
import 'package:forum_firebase_app/models/post.model.dart';
import 'package:forum_firebase_app/widgets/label_textfield.dart';
import 'package:forum_firebase_app/widgets/photo_picker.dart';
import 'package:go_router/go_router.dart';

// This the screen where the user can add a post

class PostCreateScreen extends StatefulWidget {
  static const String routeName = '/post_create/:category';
  final String category;
  const PostCreateScreen({super.key, required this.category});

  @override
  State<PostCreateScreen> createState() => _PostCreateScreenState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _PostCreateScreenState extends State<PostCreateScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isLoading = false;
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category;
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

  Future<void> createPost() async {
    try {
      isLoading = true;
      setState(() {});
      final post = PostModel.create(
        title: titleController.text,
        body: bodyController.text,
        category: selectedCategory,
      );
      await db.collection('posts').add(post);
      displaySnackbar("Post added successfully");
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
