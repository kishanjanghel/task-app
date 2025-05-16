import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/custom_widgets/custom_button.dart';
import 'package:task_app/custom_widgets/custom_textfeild.dart';
import 'package:task_app/local_db/login_db.dart';
import 'package:task_app/provider/userdetails_notifier.dart';
import 'package:task_app/repeat_fucntion/constant.dart';
import 'package:task_app/screens/user_panel/student_deshboard_page.dart';

class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({super.key});

  @override
  State<StudentLoginPage> createState() => _StudentLoginPageState();
}

class _StudentLoginPageState extends State<StudentLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  Widget svgImage({required String? name, double? height, double? width}) {
    return SvgPicture.asset(
      "assets/$name.svg",
      height: height ?? 200,
      width: width ?? double.infinity,
      fit: BoxFit.cover,
    );
  }

  validate(GlobalKey<FormState> formKey) {
    formKey.currentState?.validate();
    setState(() {});
  }

  @override
  void initState() {
    getStudentDetails();
    super.initState();
  }

  getStudentDetails() async {
    _emailController.text = LoginDb.studentEmail;
    _passwordController.text = LoginDb.studentPassword;
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserdetailsNotifier userdetailsNotifier = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: CustomAppBar(title: 'Student Login'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              svgImage(
                  name: "student", height: size.height / 2, width: size.width),
              CustomTextFieldValidator(
                formKey: _emailKey,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter student's name ";
                  }
                  return null;
                },
                textEditingController: _emailController,
                onchange: (p0) {
                  validate(_emailKey);
                },
                hintText: "Enter Student's Name",
              ),
              SizedBox(height: defaultgap),
              CustomTextFieldValidator(
                formKey: _passwordKey,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter student's name ";
                  }
                  return null;
                },
                textEditingController: _passwordController,
                onchange: (p0) {
                  validate(_emailKey);
                },
                hintText: "Enter Student's Name",
              ),
              const SizedBox(height: 35),
              CustomButton(
                  label: "Login",
                  onPressed: () {
                    if (_emailKey.currentState?.validate() == true &&
                        _passwordKey.currentState?.validate() == true) {
                      userdetailsNotifier
                          .userLogin(
                              context: context,
                              email: _emailController.text,
                              password: _passwordController.text,
                              userEnum: UserEnum.student)
                          .whenComplete(() {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const StudentDeshboardPage()));
                      });
                    }
                  }),
              // TextButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (_) => const StudentSingupPage()),
              //     );
              //   },
              //   child: const Text("Don't have an account? Sign up"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
