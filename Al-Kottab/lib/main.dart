import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';
import './config/theme.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _isUserValid(User? user) async {
    if (user == null) return false;
    try {
      // Check if the user's UID exists in Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('students') // Replace with your actual collection name
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        print(userDoc.data());
        return true; // User is valid
      } else {
        await FirebaseAuth.instance.signOut(); // Log out if user is not found
        return false;
      }
    } catch (e) {
      await FirebaseAuth.instance.signOut(); // Handle errors by logging out
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final user = snapshot.data;

          return FutureBuilder<bool>(
            future: _isUserValid(user),
            builder: (context, validSnapshot) {
              if (validSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if (validSnapshot.data == true) {
                return const HomePage();
              }

              return const LoginPage();
            },
          );
        },
      ),
    );
  }
}
