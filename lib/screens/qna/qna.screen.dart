import "package:flutter/material.dart";
import "package:forum_firebase_app/services/firestore.dart";
import "package:go_router/go_router.dart";

class QnaScreen extends StatefulWidget {
  const QnaScreen({super.key});

  @override
  State<QnaScreen> createState() => _QnaScreenState();
}

class _QnaScreenState extends State<QnaScreen> {
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
      appBar: AppBar(title: Text("Questions")),
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
      body: Column(children: [Text("QNA")]),
    ));
  }
}
