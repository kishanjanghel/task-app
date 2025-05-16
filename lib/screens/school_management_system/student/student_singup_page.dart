import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/custom_widgets/custom_button.dart';
import 'package:task_app/custom_widgets/custom_textfeild.dart';
import 'package:task_app/screens/school_management_system/student/student_login_page.dart';

class StudentSingupPage extends StatefulWidget {
  const StudentSingupPage({super.key});

  @override
  State<StudentSingupPage> createState() => _StudentSingupPageState();
}

class _StudentSingupPageState extends State<StudentSingupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();

    String? savedName = prefs.getString('student_name');
    String? savedClass = prefs.getString('student_class');
    String? savedPassword = prefs.getString('student_password');

    if (nameController.text == savedName &&
        classController.text == savedClass &&
        passwordController.text == savedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful!")),
      );
      // Navigate to student dashboard or home
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid credentials")),
      );
    }
  }

  void _goToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const StudentLoginPage()),
    );
  }

  Widget svgImage({required String? name, double? height, double? width}) {
    return SvgPicture.asset(
      "assets/$name.svg",
      height: height ?? 200,
      width: width ?? double.infinity,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: CustomAppBar(title: 'Student Signup'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              svgImage(
                  name: "student", height: size.height / 3, width: size.width),
              CustomTextField(controller: nameController, label: "Name"),
              CustomTextField(controller: classController, label: "Class"),
              CustomTextField(
                  controller: passwordController,
                  label: "Password",
                  obscureText: true),
              const SizedBox(height: 20),
              CustomButton(label: "Signup", onPressed: () {}),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const StudentLoginPage()),
                  );
                },
                child: const Text("Don't have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
