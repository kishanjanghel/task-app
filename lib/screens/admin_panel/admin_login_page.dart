import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/custom_widgets/custom_button.dart';
import 'package:task_app/custom_widgets/custom_textfeild.dart';
import 'package:task_app/local_db/login_db.dart';
import 'package:task_app/provider/userdetails_notifier.dart';
import 'package:task_app/repeat_fucntion/constant.dart';
import 'package:task_app/screens/admin_panel/admin_dashboard_page.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
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
    _emailController.text = LoginDb.adminEmail;
    _passwordController.text = LoginDb.adminPassword;
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
      appBar: CustomAppBar(title: 'Admin Login'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              svgImage(
                  name: "deshboard",
                  height: size.height / 3,
                  width: size.width),
              CustomTextFieldValidator(
                formKey: _emailKey,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter admin's email ";
                  }
                  return null;
                },
                textEditingController: _emailController,
                onchange: (p0) {
                  validate(_emailKey);
                },
                hintText: "Enter Admin's Email",
              ),
              SizedBox(height: defaultgap),
              CustomTextFieldValidator(
                formKey: _passwordKey,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter admin's password ";
                  }
                  return null;
                },
                textEditingController: _passwordController,
                onchange: (p0) {
                  validate(_emailKey);
                },
                hintText: "Enter Admin's Password",
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
                              userEnum: UserEnum.admin)
                          .whenComplete(() {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AdminDashboardPage()));
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
