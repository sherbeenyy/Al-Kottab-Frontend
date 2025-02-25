import 'package:flutter/material.dart';
import 'chat_bubble.dart'; 

class ChatScreen extends StatelessWidget {
  final String teacherName;
  final String teacherImage;

  const ChatScreen({
    super.key,
    required this.teacherName,
    required this.teacherImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        title: Row(
          children: [
            
            CircleAvatar(
              backgroundImage: AssetImage(teacherImage),
              radius: 20,
            ),
            const SizedBox(width: 10), //space between name and img
            
            Text(teacherName, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: const [
                ChatBubble(
                  message: "أريد حجز جلسة لتعليم التجويد",
                  isMe: true,
                ),
                ChatBubble(
                  message: "بالطبع! ما هو الوقت المناسب لك؟",
                  isMe: false,
                ), 
                ChatBubble(
                  message: "هل يوم الخميس الساعة 10 صباحًا مناسب؟",
                  isMe: true,
                ),
                ChatBubble(
                  message: "نعم، هذا الوقت مناسب.",
                  isMe: false,
                ),
              ],
            ),
          ),
          // Message input field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "اكتب رسالة...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send), color: Color(0xFF16226F),
                  onPressed: () {
                    // Implement send message functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}