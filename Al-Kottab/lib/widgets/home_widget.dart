import 'package:flutter/material.dart';
import 'package:frontend/services/student/student.dart';

class HomeWidget extends StatelessWidget {
  final Student? student;

  const HomeWidget({super.key, this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'الصفحة الرئيسية',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (student != null) ...[
            SizedBox(height: 20),
            Text(
              'مرحبًا، ${student!.firstName} ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    ));
  }
}
