class Student {
  final String email;
  final String uid;
  String? password;
  String? firstName;
  String? lastName;
  AgeRange? ageRange;
  Gender? gender;
  Nationality? nationality;
  String? phoneNumber;
  Level? level;

  Student({
    required this.email,
    required this.uid,
    this.password,
    this.firstName,
    this.lastName,
    this.ageRange,
    this.gender,
    this.nationality,
    this.phoneNumber,
    this.level,
  });

  // Convert Student object to a Map<String, dynamic>
  Map<String, dynamic> toFirebaseMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'ageRange': ageRange?.index,
      'gender': gender?.index,
      'nationality': nationality?.index,
      'phoneNumber': phoneNumber,
      'level': level?.index,
    };
  }

  // Convert a Map<String, dynamic> to a Student object in Arabic
  static Student fromFirebaseMap(Map<String, dynamic> map,
      {required String uid}) {
    return Student(
      email: map['email'],
      uid: uid,
      password: map['password'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      ageRange: _getAgeRangeFromIndex(map['ageRange']),
      gender: _getGenderFromIndex(map['gender']),
      nationality: _getNationalityFromIndex(map['nationality']),
      phoneNumber: map['phoneNumber'],
      level: _getLevelFromIndex(map['level']),
    );
  }

  // Helper methods to get enum values from index
  static AgeRange? _getAgeRangeFromIndex(int? index) {
    if (index == null) return null;
    return AgeRange.values[index];
  }

  static Gender? _getGenderFromIndex(int? index) {
    if (index == null) return null;
    return Gender.values[index];
  }

  static Nationality? _getNationalityFromIndex(int? index) {
    if (index == null) return null;
    return Nationality.values[index];
  }

  static Level? _getLevelFromIndex(int? index) {
    if (index == null) return null;
    return Level.values[index];
  }

  // Maps for translating enum values to Arabic and English
  static const Map<AgeRange, String> ageRangeToArabic = {
    AgeRange.age13_17: '13-17',
    AgeRange.age18_25: '18-25',
    AgeRange.age26_35: '26-35',
    AgeRange.age36_45: '36-45',
    AgeRange.age46_55: '46-55',
    AgeRange.age56_65: '56-65',
    AgeRange.age66Plus: '66+',
  };

  static const Map<AgeRange, String> ageRangeToEnglish = {
    AgeRange.age13_17: '13-17',
    AgeRange.age18_25: '18-25',
    AgeRange.age26_35: '26-35',
    AgeRange.age36_45: '36-45',
    AgeRange.age46_55: '46-55',
    AgeRange.age56_65: '56-65',
    AgeRange.age66Plus: '66+',
  };

  static const Map<Gender, String> genderToArabic = {
    Gender.male: 'ذكر',
    Gender.female: 'أنثى',
  };

  static const Map<Gender, String> genderToEnglish = {
    Gender.male: 'Male',
    Gender.female: 'Female',
  };

  static const Map<Nationality, String> nationalityToArabic = {
    Nationality.A: 'الجنسية أ',
    Nationality.B: 'الجنسية ب',
    Nationality.C: 'الجنسية ج',
    Nationality.D: 'الجنسية د',
  };

  static const Map<Nationality, String> nationalityToEnglish = {
    Nationality.A: 'Nationality A',
    Nationality.B: 'Nationality B',
    Nationality.C: 'Nationality C',
    Nationality.D: 'Nationality D',
  };

  static const Map<Level, String> levelToArabic = {
    Level.beginner: 'مبتدئ',
    Level.intermediate: 'متوسط',
    Level.advanced: 'متقدم',
  };

  static const Map<Level, String> levelToEnglish = {
    Level.beginner: 'Beginner',
    Level.intermediate: 'Intermediate',
    Level.advanced: 'Advanced',
  };
}

// Enums
enum Level { beginner, intermediate, advanced }

enum AgeRange {
  age13_17,
  age18_25,
  age26_35,
  age36_45,
  age46_55,
  age56_65,
  age66Plus
}

enum Nationality { A, B, C, D }

enum Gender { male, female }
