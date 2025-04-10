import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String hint;
  final TextEditingController textController;

  const CustomTextfield({
    Key? key,
    required this.hint,
    required this.textController,
  }) : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,  
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hint,
      ),
    );
  }
}
