import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/services/student/student.dart';
import 'package:frontend/services/student/studentApi.dart';
import 'package:frontend/services/student/studentServices.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StudentApi _studentApi = StudentApi();

  // Future<AuthResponse> registerStudent({required Student student}) async {
  //   if (student.email.isEmpty || student.password!.isEmpty) {
  //     return AuthResponse(
  //         success: false, message: "Email and password are required");
  //   }
  //   try {
  //     UserCredential credential = await _auth.createUserWithEmailAndPassword(
  //         email: student.email, password: student.password!);
//
  //     await _firestore
  //         .collection("students")
  //         .doc(credential.user!.uid)
  //         .set(student.toFirebaseMap());
  //     return AuthResponse(
  //         success: true, message: "Account Registered Successfully!");
  //   } on FirebaseAuthException catch (e) {
  //     String errorMessage;
  //     print(e);
  //     if (e.code == 'weak-password') {
  //       errorMessage = 'The password provided is too weak.';
  //     } else if (e.code == 'email-already-in-use') {
  //       errorMessage = 'The account already exists for that email.';
  //     } else {
  //       errorMessage = 'An unknown error occurred.';
  //     }
  //     return AuthResponse(success: false, message: errorMessage);
  //   } on FirebaseException catch (e) {
  //     String errorMessage;
  //     print(e);
  //     if (e.code == 'permission-denied') {
  //       errorMessage = 'You do not have permission to perform this action.';
  //     } else {
  //       errorMessage = 'An unknown Firestore error occurred.';
  //     }
  //     return AuthResponse(success: false, message: errorMessage);
  //   } catch (e) {
  //     print(e);
  //     return AuthResponse(
  //         success: false, message: 'An unknown error occurred.');
  //   }
  // }

  Future<AuthResponse> registerStudent(
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      return AuthResponse(
          success: false, message: "Email and Password are Required");
    }
    try {
      http.Response response =
          await _studentApi.registerStudent(email, password);
      StudentResponse studentResponse = StudentResponse.fromJson(
          jsonDecode(response.body), response.statusCode);

      if (studentResponse.statusCode == 201) {
        try {
          final userCredential = await FirebaseAuth.instance
              .signInWithCustomToken(studentResponse.customToken!);
          print("Sign-in successful.");

          return AuthResponse(success: true, message: "Sign-in successful.");
        } on FirebaseAuthException catch (e) {
          return AuthResponse(success: true, message: studentResponse.message);
        }
      } else {
        return AuthResponse(success: false, message: studentResponse.message);
      }
    } catch (e) {
      print(e);
      return AuthResponse(
          success: false, message: 'An unknown error occurred.');
    }
  }

  Future<AuthResponse> loginStudent(
      {required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      return AuthResponse(
          success: false, message: "Email and password are required");
    }
    try {
      final QuerySnapshot student = await _firestore
          .collection('students')
          .where('email', isEqualTo: email)
          .get();

      if (student.docs.isEmpty) {
        return AuthResponse(success: false, message: "Failed to login");
      }
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return AuthResponse(success: true, message: "Login Successful!");
    } catch (e) {
      return AuthResponse(success: false, message: "Failed to login");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class AuthResponse {
  final bool success;
  final String message;

  AuthResponse({required this.success, required this.message});
}
