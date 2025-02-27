import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/services/student/studentApiSchema.dart';
import 'package:http/http.dart' as http;

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
      Uri.parse('http://10.0.2.2:8080/api/student/getCurrentStudent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> editStudent(EditStudentRequest request) async {
    String? token = await getIdToken(); // Await the future

    return http.put(
      Uri.parse('http://10.0.2.2:8080/api/student/editStudent'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request.toMap()),
    );
  }
}
