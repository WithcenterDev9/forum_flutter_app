import 'package:flutter/material.dart';

class LabelTextfield extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isMultilined;

  const LabelTextfield({
    required this.label,
    required this.controller,
    this.isMultilined = false,
    super.key,
  });

  @override
  State<LabelTextfield> createState() => _LabelTextfieldState();
}

class _LabelTextfieldState extends State<LabelTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(fontWeight: FontWeight.w800)),

        widget.isMultilined
            ? SizedBox(
              height: 200,
              child: TextField(
                controller: widget.controller,
                keyboardType: TextInputType.multiline,
                expands: true,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            )
            : TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
      ],
    );
  }
}
