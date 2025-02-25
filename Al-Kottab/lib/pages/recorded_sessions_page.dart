import 'package:flutter/material.dart';
import '../widgets/recorded_sessions_card.dart'; 

class RecordedSessionsPage extends StatelessWidget {
  const RecordedSessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Directionality(
        textDirection: TextDirection.rtl, 
        child: ListView(
          children: [
           
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'بعد يومين سيتم حذف التسجيل، لذا يفضل تحميله الآن', 
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red, 
                ),
                textAlign: TextAlign.center, 
              ),
            ),

            // List of Recorded Sessions
            const RecordedSessionCard(
              teacherName: 'أحمد محمد',
              teacherImage: './assets/img/teacher.png', 
              sessionLink: 'https://www.youtube.com/watch?v=SJtSbkKVyr0',
              sessionDate: '2023-10-15',
            ),
            const RecordedSessionCard(
              teacherName: 'فاطمة علي',
              teacherImage: './assets/img/teacher.png', 
              sessionLink: 'https://www.youtube.com/watch?v=SJtSbkKVyr0',
              sessionDate: '2023-10-16',
            ),
            const RecordedSessionCard(
              teacherName: 'محمد علي',
              teacherImage: './assets/img/teacher.png',
              sessionLink: 'https://www.youtube.com/watch?v=SJtSbkKVyr0',
              sessionDate: '2023-10-17',
            ),
          ],
        ),
      ),
    );
  }
}