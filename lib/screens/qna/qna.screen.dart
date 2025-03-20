import "package:flutter/material.dart";


class QnaScreen extends StatelessWidget { 
  const QnaScreen({super.key});

  @override
  Widget build(BuildContext context){ 
    return ( 
      Scaffold(
        appBar: AppBar(
          title: Text("Questions"),
        ),
        body: Column(
          children: [
            Text("QNA")
          ],
        ),
      )
    );
  }
}