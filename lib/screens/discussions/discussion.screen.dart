import "package:flutter/material.dart";


// Discussion Screen will be display all the discussions posts

class DiscussionScreen extends StatelessWidget { 
  const DiscussionScreen({super.key});

  @override
  Widget build(BuildContext context){ 
    return ( 
      Scaffold(
        appBar: AppBar(
          title: Text("Discussion"),
        ), 
        body: Column(
          children: [
            Text("Discussion")
          ],
        ),
      )
    );
  }
}