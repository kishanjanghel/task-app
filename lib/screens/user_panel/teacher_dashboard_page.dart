import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/local_db/login_db.dart';
import 'package:task_app/provider/teacher_notifier.dart';
import 'package:task_app/provider/userdetails_notifier.dart';
import 'package:task_app/repeat_fucntion/constant.dart';
import 'package:task_app/repeat_fucntion/flutter_toast.dart';
import 'package:task_app/repeat_fucntion/repeat_function.dart';
import 'package:task_app/screens/school_management_system/school_home_page.dart';
import 'package:task_app/screens/user_panel/notification_page.dart';

class TeacherDashboardPage extends StatefulWidget {
  const TeacherDashboardPage({super.key});

  @override
  State<TeacherDashboardPage> createState() => _TeacherDashboardPageState();
}

class _TeacherDashboardPageState extends State<TeacherDashboardPage> {
  final List<Map<String, String>> timetable = [
    {'day': 'Monday', 'class': '10-A', 'subject': 'Math', 'time': '9:00 AM'},
    {'day': 'Monday', 'class': '9-B', 'subject': 'Science', 'time': '10:00 AM'},
    {'day': 'Tuesday', 'class': '8-C', 'subject': 'English', 'time': '9:00 AM'},
    {'day': 'Tuesday', 'class': '10-A', 'subject': 'Math', 'time': '10:00 AM'},
  ];

  @override
  Widget build(BuildContext context) {
    UserdetailsNotifier userdetailsNotifier = Provider.of(context);
    TeacherNotifier teacherNotifier = Provider.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Teacher Dashboard",
        action: [
          IconButton(
              onPressed: () {
                RepeatFunction.navigatorPush(
                    context: context, pageWidget: const NotificationPage());
              },
              icon: const Icon(
                Icons.notifications_active,
                color: primarycolor,
              )),
          InkWell(
            onTap: () {
              RepeatFunction().showLogoutDialog(
                ontap: () {
                  userdetailsNotifier
                      .userLogout(userEnum: UserEnum.teacher)
                      .whenComplete(() {
                    ToastClass.showToast(
                        msg: "Logout Successfully",
                        bgColor: Colors.green,
                        color: Colors.white);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SchoolHomePage(),
                      ),
                      (route) => false,
                    );
                  });
                },
                context: context,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 5),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: primarycolor,
                child: Text(
                  userdetailsNotifier.teacherdetails.email?[0].toUpperCase() ??
                      "",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAssignedClassesSection(teacherNotifier),
                  const SizedBox(height: 16),
                  _buildTimetableSection(),
                  const SizedBox(height: 16),
                  _buildStudentListSection(teacherNotifier),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignedClassesSection(TeacherNotifier teacherNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Assigned Classes',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...teacherNotifier.classes.map((classes) => Card(
              child: ListTile(
                title: Text(classes.className ?? ''),
                subtitle: Text(
                  classes.subjects!.join(', '),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildTimetableSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Timetable',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...timetable.map((entry) => Card(
              child: ListTile(
                title: Text(
                    '${entry['day']} - ${entry['class']} - ${entry['subject']}'),
                subtitle: Text('Time: ${entry['time']}'),
              ),
            )),
      ],
    );
  }

  Widget _buildStudentListSection(TeacherNotifier teacherNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Student List',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...teacherNotifier.students.map((student) => Card(
              child: ListTile(
                title: Text(student.name ?? ''),
                subtitle: Text('Class: ${student.className}'),
              ),
            )),
      ],
    );
  }
}
