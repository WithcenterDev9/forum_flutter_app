import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:forum_firebase_app/models/post.model.dart';
import 'package:go_router/go_router.dart';

// Home Screen will be display all the posts whether it is a question or a discussion

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Post> posts = [];

  Future<void> getPosts() async {
    final ref = await db.collection('posts').get();

    posts =
        ref.docs.map((doc) {
          final data = doc.data();
          return Post(
            id: doc.id,
            title: data['title'] ?? '',
            body: data['body'] ?? '',
          );
        }).toList();
    // for (final doc in (await ref).docs) {
    //   print(doc.id);
    //   print(doc.data());
    // }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(title: Text("Home"), onTap: () => context.go('/')),
              ListTile(
                title: Text("Discussion"),
                onTap: () => context.go('/discussion'),
              ),
              ListTile(
                title: Text("Questions"),
                onTap: () => context.go('/qna'),
              ),
            ],
          ),
        ),
        appBar: AppBar(title: Text("Forooom")),
        body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return ListTile(
              title: Text(post.title),
              subtitle: Text(post.body),
              onTap: () => context.push('/post/${post.id}'),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => context.push('/add_post'),
        ),
      ),
    );
  }
}
