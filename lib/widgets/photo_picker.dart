import 'package:flutter/material.dart';

class PhotoPicker extends StatefulWidget {
  const PhotoPicker({super.key});

  @override
  State<PhotoPicker> createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("Add photo"),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Click here to add photo")],
          ),
        ),
      ),
    );
  }
}
