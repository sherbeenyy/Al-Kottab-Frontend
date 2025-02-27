import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/services/authServices.dart';
import 'package:frontend/widgets/snack_bar.dart';
import 'registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void handleLogin() async {
    AuthResponse response = await AuthServices().loginStudent(
      email: emailController.text,
      password: passwordController.text,
    );

    if (response.success) {
      setState(() {
        isLoading = true;
      });
      print('wadyyyyyy');
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
        title: Text('تسجيل دخول للطالب'),
        // backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'تسجيل دخول',
              textAlign: TextAlign.center, // Keep text centered
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      labelText: 'الحساب الإلكتروني',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    textAlign: TextAlign.right,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'كلمة السر',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Forget password logic make it in an external function w call it bs
              },
              child: Text(
                'نسيت كلمة السر؟',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationPage(),
                  ),
                );
              },
              child: Text(
                'ليس لديك حساب؟ سجل الآن',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                handleLogin();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF16226F),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'تسجيل الدخول',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
