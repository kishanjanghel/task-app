import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/local_db/login_db.dart';
import 'package:task_app/provider/userdetails_notifier.dart';
import 'package:task_app/screens/admin_panel/admin_dashboard_page.dart';
import 'package:task_app/screens/admin_panel/admin_login_page.dart';
import 'package:task_app/screens/school_management_system/student/student_login_page.dart';
import 'package:task_app/screens/school_management_system/teacher/teacher_login_page.dart';
import 'package:task_app/screens/user_panel/student_deshboard_page.dart';
import 'package:task_app/screens/user_panel/teacher_dashboard_page.dart';

class SchoolHomePage extends StatefulWidget {
  const SchoolHomePage({super.key});

  @override
  State<SchoolHomePage> createState() => _SchoolHomePageState();
}

class _SchoolHomePageState extends State<SchoolHomePage> {
  Widget svgImage({required String? name, double? height, double? width}) {
    return SvgPicture.asset(
      "assets/$name.svg",
      height: height ?? 200,
      width: width ?? double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget loginContainer({
    required String title,
    required Color color,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    UserdetailsNotifier userdetailsNotifier = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: CustomAppBar(
        title: "Welcome to School",
      ),
      body: Column(
        children: [
          svgImage(name: "school", height: size.height / 2, width: size.width),
          // const SizedBox(height: 30),
          loginContainer(
              title: "Student",
              color: Colors.deepPurple,
              icon: Icons.school,
              onTap: () async {
                await userdetailsNotifier
                    .getUserDetails(userEnum: UserEnum.student)
                    .whenComplete(() {
                  if (userdetailsNotifier.studentdetails.email == null &&
                      userdetailsNotifier.studentdetails.password == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const StudentLoginPage()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const StudentDeshboardPage()),
                    );
                  }
                });
              }),

          loginContainer(
            title: "Teacher",
            color: Colors.deepPurple,
            icon: Icons.person,
            onTap: () async {
              await userdetailsNotifier
                  .getUserDetails(userEnum: UserEnum.teacher)
                  .whenComplete(() {
                if (userdetailsNotifier.teacherdetails.email == null &&
                    userdetailsNotifier.teacherdetails.password == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TeacherLoginPage()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const TeacherDashboardPage()),
                  );
                }
              });
            },
          ),
          loginContainer(
            title: "Admin Panel ",
            color: Colors.deepPurple,
            icon: Icons.person,
            onTap: () async {
              await userdetailsNotifier
                  .getUserDetails(userEnum: UserEnum.admin)
                  .whenComplete(() {
                if (userdetailsNotifier.admindetails.email == null &&
                    userdetailsNotifier.admindetails.password == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AdminLoginPage()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AdminDashboardPage()),
                  );
                }
              });
            },
          ),
          // loginContainer(
          //   title: "User Panel ",
          //   color: Colors.deepPurple,
          //   icon: Icons.person,
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (_) => const AdminDashboardPage()),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
