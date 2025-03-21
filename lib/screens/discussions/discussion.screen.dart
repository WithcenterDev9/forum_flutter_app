import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:forum_firebase_app/services/firestore.dart";
import "package:go_router/go_router.dart";

// Discussion Screen will be display all the discussions posts

class DiscussionScreen extends StatefulWidget {
  const DiscussionScreen({super.key});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {

  Future<void> getDiscussion() async {
    final firestore = DatabaseFireStore.instance.discussions;
    final test = await firestore.get();
    print(test.docs.map((e) => e.data()));
  }

  @override
  void initState() {
    super.initState();
    getDiscussion();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text("Discussion")),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Discussion"),
              onTap: () => context.go('/discussion'),
            ),
            ListTile(title: Text("Questions"), onTap: () => context.go('/qna')),
          ],
        ),
      ),
      body: Column(children: [Text("Discussion")]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => context.push('/add_post'),
      ),
    ));
  }
}
