import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  final String id;
  const PostScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post")),
      body: Column(children: [Text("Post $id")]),
    );
  }
}
