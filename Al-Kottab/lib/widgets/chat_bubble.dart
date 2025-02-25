import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isMe ? Color(0xFF16226F) : Colors.grey.shade200, 
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomLeft: isMe ? Radius.circular(12.0) : Radius.circular(0),
            bottomRight: isMe ? Radius.circular(0) : Radius.circular(12.0),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            color: isMe ? Colors.white : Colors.black, 
          ),
        ),
      ),
    );
  }
}
