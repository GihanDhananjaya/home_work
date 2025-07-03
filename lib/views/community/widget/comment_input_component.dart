import 'package:flutter/material.dart';

class CommentInputBox extends StatelessWidget {
  TextEditingController controller;
  VoidCallback sendTap;


  CommentInputBox({required this.controller,required this.sendTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Profile picture / Avatar placeholder
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey.shade400,
            child: Icon(Icons.person, color: Colors.white, size: 18),
          ),

          SizedBox(width: 8),

          // Comment input
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Add comment...',
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),

          // Action icons
          IconButton(
            icon: Icon(Icons.alternate_email, size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.emoji_emotions_outlined, size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.send, size: 20),
            onPressed: sendTap,
          ),
        ],
      ),
    );
  }
}
