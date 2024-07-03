import 'package:flutter/material.dart';

class AnnouncementInputTile extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String type;
  const AnnouncementInputTile({
    super.key,
    required this.controller,
    required this.hintText,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          fillColor: Colors.grey[200],
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey[400],
          ),
          prefixIcon: type == "notTitle" ? const Icon(Icons.wrap_text_rounded) :const Icon(Icons.title) ,
        ),
        maxLines: null,
      ),
    );
  }
}
