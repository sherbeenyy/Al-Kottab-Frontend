import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/services/student/student.dart';
import 'package:frontend/services/student/studentServices.dart';
import 'package:frontend/widgets/snack_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.student});

  final Student? student;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  bool isArabic = true;
  AgeRange selectedAge = AgeRange.age13_17;
  Nationality selectedNationality = Nationality.A;
  Level selectedLevel = Level.beginner;
  Gender selectedGender = Gender.male;

  final StudentServices studentServices = StudentServices();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      firstNameController.text = widget.student!.firstName ?? '';
      lastNameController.text = widget.student!.lastName ?? '';
      phoneController.text = widget.student!.phoneNumber ?? '';
      selectedAge = widget.student!.ageRange ?? AgeRange.age13_17;
      selectedNationality = widget.student!.nationality ?? Nationality.A;
      selectedLevel = widget.student!.level ?? Level.beginner;
      selectedGender = widget.student!.gender ?? Gender.male;
    }
  }

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
        title: Text(isArabic ? 'تعديل الملف الشخصي' : 'Edit Profile'),
        centerTitle: true,

        elevation: 0,
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
                  Student.ageRangeToEnglish,
                  (val) {
                    setState(() {
                      selectedAge = val!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                buildDropdown<Gender>(
                  isArabic ? 'الجنس' : 'Gender',
                  selectedGender,
                  Gender.values,
                  Student.genderToArabic,
                  Student.genderToEnglish,
                  (val) {
                    setState(() {
                      selectedGender = val!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                buildDropdown<Nationality>(
                  isArabic ? 'الجنسية' : 'Nationality',
                  selectedNationality,
                  Nationality.values,
                  Student.nationalityToArabic,
                  Student.nationalityToEnglish,
                  (val) {
                    setState(() {
                      selectedNationality = val!;
                    });
                  },
                ),
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
                  Student.levelToEnglish,
                  (val) {
                    setState(() {
                      selectedLevel = val!;
                    });
                  },
                ),
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
                    child: Text(isArabic ? 'حفظ' : 'Save',
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

  Widget buildDropdown<T>(
    String label,
    T value,
    List<T> items,
    Map<T, String> arabicMap,
    Map<T, String> englishMap,
    Function(T?) onChanged,
  ) {
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
        onChanged: onChanged,
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
    String label,
    TextEditingController controller,
    IconData icon, {
    bool isPhone = false,
  }) {
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
