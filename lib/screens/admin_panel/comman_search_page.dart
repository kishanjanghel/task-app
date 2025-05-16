import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/custom_widgets/custom_tile.dart';
import 'package:task_app/custom_widgets/customtext.dart';
import 'package:task_app/local_db/student_db.dart';
import 'package:task_app/local_db/teacher_db.dart';
import 'package:task_app/provider/teacher_notifier.dart';
import 'package:task_app/repeat_fucntion/constant.dart';
import 'package:task_app/repeat_fucntion/repeat_function.dart';
import 'package:task_app/screens/admin_panel/add_student_page.dart';
import 'package:task_app/screens/admin_panel/addteacher_page.dart';

class CommonSearchPage extends StatefulWidget {
  final List<dynamic>
      dataList; // Contains both StudentHiveModel and TeacherHiveModel

  const CommonSearchPage({super.key, required this.dataList});

  @override
  State<CommonSearchPage> createState() => _CommonSearchPageState();
}

class _CommonSearchPageState extends State<CommonSearchPage> {
  String query = '';
  late List<dynamic> filteredList;

  @override
  void initState() {
    super.initState();
    filteredList = widget.dataList;
  }

  void _search(String value) {
    setState(() {
      query = value.toLowerCase();
      filteredList = widget.dataList.where((item) {
        final name = item.name?.toLowerCase() ?? '';
        return name.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    TeacherNotifier teacherNotifier = Provider.of<TeacherNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Search'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search by name...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _search,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: filteredList.isEmpty
            ? const EmptyTextWidget(msg: "Data Not Found")
            : ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (_, index) {
                  final item = filteredList[index];
                  if (item is TeacherHiveModel) {
                    return CustomTile(
                      teacher: item,
                      onDelete: () {
                        teacherNotifier.deleteTeacher(index);
                      },
                      onTap: () {
                        RepeatFunction.navigatorPush(
                            context: context,
                            pageWidget: AddTeacherPage(
                              teacherHiveModel: item,
                              index: index,
                            ));
                      },
                      onEdit: () {
                        RepeatFunction.navigatorPush(
                            context: context,
                            pageWidget: AddTeacherPage(
                              teacherHiveModel: item,
                              index: index,
                            ));
                      },
                    );
                  } else if (item is StudentHiveModel) {
                    return CustomTile(
                      teacher: TeacherHiveModel(
                          subject: item.className, name: item.name),
                      onDelete: () {
                        teacherNotifier.deleteStudent(index);
                      },
                      onTap: () {
                        RepeatFunction.navigatorPush(
                            context: context,
                            pageWidget: AddStudentPage(
                              student: item,
                              index: index,
                            ));
                      },
                      onEdit: () {
                        RepeatFunction.navigatorPush(
                            context: context,
                            pageWidget: AddStudentPage(
                              student: item,
                              index: index,
                            ));
                      },
                    );
                  } else {
                    return const SizedBox.shrink(); // fallback for unknown type
                  }
                },
              ),
      ),
    );
  }
}
