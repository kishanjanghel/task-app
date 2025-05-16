import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/custom_widgets/custom_tile.dart';
import 'package:task_app/custom_widgets/customtext.dart';
import 'package:task_app/local_db/teacher_db.dart';
import 'package:task_app/provider/teacher_notifier.dart';
import 'package:task_app/repeat_fucntion/constant.dart';
import 'package:task_app/repeat_fucntion/repeat_function.dart';
import 'package:task_app/screens/admin_panel/add_student_page.dart';
import 'package:task_app/screens/admin_panel/comman_search_page.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TeacherNotifier>(context, listen: false).initStudent();
  }

  @override
  Widget build(BuildContext context) {
    TeacherNotifier teacherNotifier = Provider.of<TeacherNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: CustomAppBar(
        title: "Students",
        action: [
          IconButton(
            onPressed: () {
              RepeatFunction.navigatorPush(
                  context: context,
                  pageWidget: CommonSearchPage(
                    dataList: teacherNotifier.students,
                  ));
            },
            icon: const Padding(
              padding: EdgeInsets.only(
                right: 10,
              ),
              child: Icon(
                Icons.search_outlined,
                color: Colors.deepPurple,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: teacherNotifier.students.isEmpty
            ? const EmptyTextWidget(msg: "Empty Student List")
            : Column(
                children:
                    List.generate(teacherNotifier.students.length, (index) {
                  var data = teacherNotifier.students[index];
                  return CustomTile(
                    teacher: TeacherHiveModel(
                        name: data.name, subject: data.className),
                    onDelete: () {
                      teacherNotifier.deleteStudent(index);
                    },
                    onEdit: () {
                      RepeatFunction.navigatorPush(
                          context: context,
                          pageWidget: AddStudentPage(
                            index: index,
                            student: data,
                          ));
                    },
                    onTap: () {
                      RepeatFunction.navigatorPush(
                          context: context,
                          pageWidget: AddStudentPage(
                            index: index,
                            student: data,
                          ));
                    },
                  );
                }),
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            RepeatFunction.navigatorPush(
                context: context, pageWidget: const AddStudentPage());
          },
          child: Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: primarycolor),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              color: primarycolor,
              borderRadius: BorderRadius.circular(11.0),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                CustomText(
                  text: "Add",
                  fontSize: 18,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
