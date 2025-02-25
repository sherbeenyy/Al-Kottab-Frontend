import 'package:flutter/material.dart';
import 'chat_screen.dart'; 
import '../pages/teacher_personal_profile.dart';

class TeacherCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final double rating;
  final String bio;

  const TeacherCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.bio,
    this.rating = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to ChatScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeacherPersonalProfile(
                name: name,
                imagePath: imagePath,
                rating: rating,
                bio: bio,
              )
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Top Row: Image and Name
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  // Profile Image
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2.0,
                      ),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Name and Rating
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF16226F),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        // Star Rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(5, (index) {
                            if (index < rating && index + 1 > rating) {
                              return Icon(
                                Icons.star_half,
                                color: Colors.amber,
                                size: 20,
                              );
                            } else if (index < rating) {
                              return Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              );
                            } else {
                              return Icon(
                                Icons.star_border,
                                color: Colors.amber,
                                size: 20,
                              );
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Bio Section
              Text(
                bio,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 10),
              // Divider
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
              const SizedBox(height: 16),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                textDirection: TextDirection.rtl,
                children: [
                  _buildActionButton(
                    icon: Icons.call,
                    label: 'اتصل الآن',
                    color: const Color(0xFF16226F),
                    onPressed: () {
                      // Implement Call functionality
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.chat,
                    label: 'محادثة',
                    color: const Color(0xFF16226F),
                    onPressed: () {
                   
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            teacherName: name,
                            teacherImage: imagePath,
                          ),
                        ),
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.calendar_today,
                    label: 'حجز',
                    color: const Color(0xFF16226F),
                    onPressed: () {
                      // Implement Reserve functionality
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed, 
      child: Column(
        children: [
          Icon(
            icon,
            size: 28,
            color: color,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}