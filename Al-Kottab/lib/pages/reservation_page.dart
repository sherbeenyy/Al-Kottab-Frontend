import 'package:flutter/material.dart';
import 'package:frontend/widgets/reservation_card.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: const [
            ReservationCard(
              teacherName: 'احمد شوقي',
              teacherImage: './assets/img/teacher.png',
              date: '2023-10-15',
              time: '10:00 AM',
              duration: '1 hour',
            ),
            ReservationCard(
              teacherName: 'عمر باسم',
              teacherImage: './assets/img/teacher.png',
              date: '2023-10-16',
              time: '02:00 PM',
              duration: '1.5 hours',
            ),
           
          ],
        ),
      ),
    );
  }
   }