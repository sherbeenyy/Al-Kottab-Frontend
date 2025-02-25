import 'package:flutter/material.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/teachers_page.dart';
import 'package:frontend/services/authServices.dart';
import 'package:frontend/services/student/student.dart';
import 'package:frontend/services/student/studentServices.dart';
import 'package:frontend/widgets/home_widget.dart';
import 'edit_profile.dart';
import 'reservation_page.dart';
import 'recorded_sessions_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Student? _currentStudent;
  bool _loading = true; 

  @override
  void initState() {
    super.initState();
    _fetchCurrentStudent();
  }
  static List<Widget> _widgetOptions(Student? student) => <Widget>[
        HomeWidget(student: student),
        TeachersPage(),
        ReservationsPage(),
        RecordedSessionsPage(),
        Text('Chat Page'),
      ];

  Future<void> _fetchCurrentStudent() async {
    StudentServices studentServices = StudentServices();
    Student? student = await studentServices.getCurrentStudent();

    if (!mounted) return; // Ensure the widget is still in the tree

    if (student?.firstName == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => EditProfile(student: student)),
      );
    } else {
      setState(() {
        _currentStudent = student;
        _loading = false; // Stop loading when data is fetched
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()), // Show loading indicator
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentStudent != null
            ? "مرحبا ${_currentStudent!.firstName}"
            : "not found"),
        
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF16226F)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: _currentStudent?.gender == Gender.male
                          ? AssetImage('assets/img/student.png')
                          : AssetImage('assets/img/fstudent.png'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditProfile(student: _currentStudent)),
                        );
                      },
                      child: Text(
                        'تعديل الحساب',
                        style: TextStyle(color: Colors.white),
                      
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Text('الرصيد'),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Text('الإعدادات'),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Text('عن التطبيق'),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Text('تسجيل الخروج'),
                ),
                onTap: () async {
                  await AuthServices().signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions(_currentStudent).elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'المعلمون'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'الحجوزات'),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'الجلسات'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'الدردشة'),
        ],
        currentIndex: _selectedIndex,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold), 
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        selectedItemColor: Color(0xFF162379),
        unselectedItemColor: Color.fromARGB(255, 91, 93, 107),
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

