import 'package:frontend/services/student/student.dart';

class EditStudentRequest {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final AgeRange ageRange;
  final Gender gender;
  final Nationality nationality;
  final Level level;
  EditStudentRequest({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.ageRange,
    required this.gender,
    required this.nationality,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'ageRange': ageRange.index,
      'gender': gender.index,
      'nationality': nationality.index,
      'level': level.index,
    };
  }
}
