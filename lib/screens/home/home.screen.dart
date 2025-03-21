import 'package:flutter/material.dart';
import 'package:forum_firebase_app/global.dart';
import 'package:forum_firebase_app/screens/forum/forum.screen.dart';
import 'package:go_router/go_router.dart';

class HomeScreenScreen extends StatefulWidget {
  static const String routeName = '/';
  const HomeScreenScreen({super.key});

  @override
  State<HomeScreenScreen> createState() => _HomeScreenScreenState();
}

class _HomeScreenScreenState extends State<HomeScreenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeScreen')),
      body: Column(
        children: [
          Text("HomeScreen"),

          ElevatedButton(
            onPressed:
                () => context.push(
                  ForumScreen.routeName,
                  extra: {'category': Category.discussion},
                ),
            child: const Text('Discussion'),
          ),
          ElevatedButton(
            onPressed:
                () => context.push(
                  ForumScreen.routeName,
                  extra: {'category': Category.qna},
                ),
            child: const Text('QNA'),
          ),
        ],
      ),
    );
  }
}
