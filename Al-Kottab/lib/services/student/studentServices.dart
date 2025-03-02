import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/services/student/student.dart';
import 'package:frontend/services/student/studentApiSchema.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'studentApi.dart';

class StudentServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StudentApi _studentApi = StudentApi();

  // Get the current logged-in user's data from Firestore
  Future<Student?> getCurrentStudent() async {
    try {
      // Get the current user
      User? user = _auth.currentUser;

      if (user != null) {
        // Fetched the student document from Firestore using the user's UID

        http.Response response = await _studentApi.getCurrentStudent(user.uid);
        late StudentResponse studentResponse;
        try {
          studentResponse = StudentResponse.fromJson(
              jsonDecode(response.body), response.statusCode);
          print('Response: ${response.body}');
        } catch (e) {
          print('Error parsing student response: $e');
          print('Incoming response: ${response.body}');
          return null;
        }

        if (studentResponse.student != null) {
          // Convert the Firestore document to a Student object
          return Student.fromFirebaseMap(
            studentResponse.student as Map<String, dynamic>,
            uid: user.uid, // Pass the uid explicitly
          );
        } else if (studentResponse.statusCode == 404) {
          print('Student document does not exist');
          return null;
        }
      } else {
        print('No user is currently logged in');
        return null;
      }
    } catch (e) {
      print('Error fetching current student data: $e');
      return null;
    }
    return null;
  }

  Future<StudentSnackBar> editStudent(EditStudentRequest request) async {
    try {
      // Get the current user
      User? user = _auth.currentUser;

      if (user != null) {
        // Convert the Student object to a map
        http.Response response =
            await _studentApi.editStudent(request); // Pass the uid explicitly

        late StudentResponse studentResponse;
        try {
          studentResponse = StudentResponse.fromJson(
              jsonDecode(response.body), response.statusCode);
          print('Response: ${response.body}');
        } catch (e) {
          print('Error parsing student response: $e');
          print('Incoming response: ${response.body}');
          return StudentSnackBar(
              success: false, message: 'Error parsing student response: $e');
        }

        if (studentResponse.statusCode == 200) {
          return StudentSnackBar(
              success: true, message: studentResponse.message);
        } else if (studentResponse.statusCode == 404) {
          return StudentSnackBar(
              success: false, message: studentResponse.message);
        } else if (studentResponse.statusCode == 500) {
          return StudentSnackBar(
              success: false, message: studentResponse.message);
        } else {
          return StudentSnackBar(
              success: false, message: studentResponse.message);
        }
      } else {
        return StudentSnackBar(
            success: false,
            message: 'User is not logged in or UID does not match');
      }
    } catch (e) {
      print('Error updating student data: $e');
      return StudentSnackBar(
          success: false, message: 'Error updating student data: $e');
    }
  }
}

class StudentResponse {
  final int statusCode;
  final String message;
  final String? details;
  final Map<String, dynamic>? student;
  final List<Map<String, dynamic>>? studentList;

  StudentResponse({
    required this.statusCode,
    required this.message,
    this.details,
    this.student,
    this.studentList,
  });
  factory StudentResponse.fromJson(Map<String, dynamic> json, int statusCode) {
    return StudentResponse(
      statusCode: statusCode,
      message: json['message'],
      details: json['details'],
      student: json['student'],
      studentList: json['studentList'],
    );
  }
}

class StudentSnackBar {
  final bool success;
  final String message;

  StudentSnackBar({required this.success, required this.message});
}
