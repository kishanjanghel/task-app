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

class StudentDeshboardPage extends StatefulWidget {
  const StudentDeshboardPage({super.key});

  @override
  State<StudentDeshboardPage> createState() => _StudentDeshboardPageState();
}

class _StudentDeshboardPageState extends State<StudentDeshboardPage> {
  final List<Map<String, String>> timetable = [
    {'day': 'Monday', 'subject': 'Mathematics', 'time': '9:00 AM - 10:00 AM'},
    {'day': 'Monday', 'subject': 'Science', 'time': '10:15 AM - 11:15 AM'},
    {'day': 'Tuesday', 'subject': 'English', 'time': '9:00 AM - 10:00 AM'},
    {'day': 'Tuesday', 'subject': 'History', 'time': '10:15 AM - 11:15 AM'},
  ];

  @override
  Widget build(BuildContext context) {
    UserdetailsNotifier userdetailsNotifier = Provider.of(context);
    TeacherNotifier teacherNotifier = Provider.of(context);
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Student Dashboard",
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
                          .userLogout(userEnum: UserEnum.student)
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
                      userdetailsNotifier.studentdetails.email?[0]
                              .toUpperCase() ??
                          "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildClassInfoSection(teacherNotifier),
                  const SizedBox(height: 16),
                  _buildSubjectsSection(teacherNotifier),
                  const SizedBox(height: 16),
                  _buildTimetableSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassInfoSection(TeacherNotifier teacherNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Class Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...teacherNotifier.classes.map((classHiveModel) => Card(
              child: ListTile(
                title: Text(classHiveModel.className ?? ''),
                subtitle: Text(
                  classHiveModel.subjects!.join(', '),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ))
      ],
    );
  }

  Widget _buildSubjectsSection(TeacherNotifier teacherNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Teacher Subjects',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...teacherNotifier.teachers.map((teacherData) => Card(
              child: ListTile(
                title: Text(teacherData.name ?? ''),
                subtitle: Text('Teacher: ${teacherData.subject}'),
              ),
            ))
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
                title: Text('${entry['day']} - ${entry['subject']}'),
                subtitle: Text(entry['time'] ?? ''),
              ),
            )),
      ],
    );
  }
}
