import 'package:flutter/material.dart';
import '../widgets/teachers_widget.dart'; 

class Teacher {
  final String name;
  final String imagePath;
  final String bio;
  final double rating; 

  Teacher({
    required this.name,
    required this.imagePath,
    required this.bio,
    required this.rating,
  });
}

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  _TeachersPageState createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  List<Teacher> teachers = [
    Teacher(
      name: 'هشام أحمد',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 1,
    ),
    Teacher(
      name: 'عصام محمد',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 3,
    ),
    Teacher(
      name: ' تامر علي',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 4.7,
    ),
    Teacher(
      name: ' أشرف حسن',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 4.2,
    ),
    Teacher(
      name: ' إدريس يوسف',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 4.8,
    ),
    Teacher(
      name: ' رستم عمر',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 4.3,
    ),
    Teacher(
      name: ' محمد محمود',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 4.6,
    ),
    Teacher(
      name: ' علي خالد',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 2,
    ),
    Teacher(
      name: ' هشام طارق',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 3,
    ),
    Teacher(
      name: 'تامر عمرو',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 4.0,
    ),
    Teacher(
      name: 'عمرو حسين',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 4.7,
    ),
    Teacher(
      name: 'عمرو سيف',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 4.2,
    ),
    Teacher(
      name: 'سيف فادي',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 3,
    ),
    Teacher(
      name: 'سيف رامي',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 2.5,
    ),
    Teacher(
      name: 'سيف زياد',
      imagePath: './assets/img/teacher.png',
      bio: 'مدرس لغة عربية ذو خبرة واسعة في تدريس النحو والصرف والأدب.',
      rating: 5,
    ),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Teacher> filteredTeachers = teachers
        .where((teacher) =>
            teacher.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'البحث...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),

            // Teachers List
            Expanded(
              child: ListView.builder(
                itemCount: filteredTeachers.length,
                itemBuilder: (context, index) {
                  return TeacherCard(
                    name: filteredTeachers[index].name,
                    imagePath: filteredTeachers[index].imagePath,
                    bio: filteredTeachers[index].bio,
                    rating: filteredTeachers[index].rating,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}