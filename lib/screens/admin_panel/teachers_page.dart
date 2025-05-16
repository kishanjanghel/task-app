import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/custom_widgets/custom_tile.dart';
import 'package:task_app/custom_widgets/customtext.dart';
import 'package:task_app/provider/teacher_notifier.dart';
import 'package:task_app/repeat_fucntion/constant.dart';
import 'package:task_app/repeat_fucntion/repeat_function.dart';
import 'package:task_app/screens/admin_panel/addteacher_page.dart';
import 'package:task_app/screens/admin_panel/comman_search_page.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TeacherNotifier teacherNotifier = Provider.of<TeacherNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: CustomAppBar(
        title: "Teachers",
        action: [
          IconButton(
            onPressed: () {
              RepeatFunction.navigatorPush(
                  context: context,
                  pageWidget: CommonSearchPage(
                    dataList: teacherNotifier.teachers,
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
        child: teacherNotifier.teachers.isEmpty
            ? const EmptyTextWidget(msg: "Empty Teachers List")
            : Column(
                children:
                    List.generate(teacherNotifier.teachers.length, (index) {
                  var data = teacherNotifier.teachers[index];
                  return CustomTile(
                    teacher: data,
                    onEdit: () {
                      RepeatFunction.navigatorPush(
                          context: context,
                          pageWidget: AddTeacherPage(
                            index: index,
                            teacherHiveModel: data,
                          ));
                    },
                    onDelete: () {
                      teacherNotifier.deleteTeacher(index);
                    },
                    onTap: () {
                      RepeatFunction.navigatorPush(
                          context: context,
                          pageWidget: AddTeacherPage(
                            index: index,
                            teacherHiveModel: data,
                          ));
                    },
                  );
                }),
              ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          RepeatFunction.navigatorPush(
              context: context, pageWidget: AddTeacherPage());
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
