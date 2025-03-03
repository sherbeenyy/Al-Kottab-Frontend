import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/services/student/studentApiSchema.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../api_environment.dart';

class StudentApi {
  Future<String?> getIdToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? token = await user.getIdToken();
      return token;
    }
    return null;
  }

  Future<http.Response> getCurrentStudent(String uid) async {
    String? token = await getIdToken(); // Await the future
    return http.get(
      Uri.parse(
          environment['baseUrl'].toString() + '/student/getCurrentStudent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> editStudent(EditStudentRequest request) async {
    String? token = await getIdToken(); // Await the future

    return http.put(
      Uri.parse(environment['baseUrl'].toString() + '/student/editStudent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request.toMap()),
    );
  }

  Future<http.Response> registerStudent(String email, String password) async {
    return http.post(
      Uri.parse(environment['baseUrl'].toString() + '/student/registerStudent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
  }
}
