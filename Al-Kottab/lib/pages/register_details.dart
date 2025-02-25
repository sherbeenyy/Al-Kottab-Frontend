import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/services/student/student.dart';
import 'package:frontend/services/student/studentServices.dart';
import 'package:frontend/widgets/snack_bar.dart';

class RegisterDetails extends StatefulWidget {
  const RegisterDetails({super.key});

  @override
  State<RegisterDetails> createState() => _RegisterDetailsState();
}

class _RegisterDetailsState extends State<RegisterDetails> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  bool isArabic = true; // Toggle language

  AgeRange selectedAge = AgeRange.age13_17;
  Nationality selectedNationality = Nationality.A;
  Level selectedLevel = Level.beginner;
  Gender selectedGender = Gender.male;

  final StudentServices studentServices = StudentServices();
  bool isLoading = false;

  void handleStudentEdit() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      showSnackBar(context, 'لم يتم العثور على مستخدم مسجل', false);
      return;
    }

    Student student = Student(
      email: user.email ?? '',
      uid: user.uid,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      ageRange: selectedAge,
      gender: selectedGender,
      nationality: selectedNationality,
      phoneNumber: phoneController.text,
      level: selectedLevel,
    );

    StudentSnackBar response = await studentServices.editStudent(student);
    if (response.success) {
      setState(() {
        isLoading = true;
      });
      showSnackBar(context, response.message, response.success);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, response.message, response.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isArabic ? 'تسجيل حساب طالب جديد' : 'Register New Student'),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              setState(() {
                isArabic = !isArabic;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    selectedGender == Gender.female
                        ? 'assets/img/fstudent.png'
                        : 'assets/img/student.png',
                    height: 150,
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),
                buildTextField(isArabic ? 'الاسم الأول' : 'First Name',
                    firstNameController, Icons.person),
                const SizedBox(height: 16),
                buildTextField(isArabic ? 'الاسم الأخير' : 'Last Name',
                    lastNameController, Icons.person),
                const SizedBox(height: 16),
                buildDropdown<AgeRange>(
                    isArabic ? 'العمر' : 'Age',
                    selectedAge,
                    AgeRange.values,
                    Student.ageRangeToArabic,
                    Student.ageRangeToEnglish),
                const SizedBox(height: 16),
                buildDropdown<Gender>(
                    isArabic ? 'الجنس' : 'Gender',
                    selectedGender,
                    Gender.values,
                    Student.genderToArabic,
                    Student.genderToEnglish),
                const SizedBox(height: 16),
                buildDropdown<Nationality>(
                    isArabic ? 'الجنسية' : 'Nationality',
                    selectedNationality,
                    Nationality.values,
                    Student.nationalityToArabic,
                    Student.nationalityToEnglish),
                const SizedBox(height: 16),
                buildTextField(isArabic ? 'رقم الهاتف' : 'Phone Number',
                    phoneController, Icons.phone,
                    isPhone: true),
                const SizedBox(height: 16),
                buildDropdown<Level>(
                    isArabic ? 'المستوى' : 'Level',
                    selectedLevel,
                    Level.values,
                    Student.levelToArabic,
                    Student.levelToEnglish),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        handleStudentEdit();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF16226F),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(isArabic ? 'تسجيل' : 'Register',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown<T>(String label, T value, List<T> items,
      Map<T, String> arabicMap, Map<T, String> englishMap) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownButtonFormField<T>(
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(isArabic ? arabicMap[item]! : englishMap[item]!),
          );
        }).toList(),
        onChanged: (val) {
          setState(() {
            value = val as T;
          });
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: const Icon(Icons.list),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, TextEditingController controller, IconData icon,
      {bool isPhone = false}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.right,
        keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(icon),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الرجاء إدخال $label';
          }
          return null;
        },
      ),
    );
  }
}
