import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/custom_widgets/customtext.dart';
import 'package:task_app/provider/teacher_notifier.dart';
import 'package:task_app/repeat_fucntion/constant.dart';
import 'package:task_app/repeat_fucntion/repeat_function.dart';
import 'package:task_app/screens/admin_panel/addclass_page.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TeacherNotifier>(context, listen: false).initClasses();
  }

  @override
  Widget build(BuildContext context) {
    TeacherNotifier teacherNotifier = Provider.of<TeacherNotifier>(context);
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: CustomAppBar(
        title: "Classes",
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: teacherNotifier.classes.isEmpty
            ? const EmptyTextWidget(msg: "Empty Classes")
            : Column(
                children:
                    List.generate(teacherNotifier.classes.length, (index) {
                  var data = teacherNotifier.classes[index];
                  return ClassTile(
                    className: data.className ?? "",
                    subjects: data.subjects ?? [],
                    onDelete: () {
                      teacherNotifier.deleteClasse(index);
                    },
                    onEdit: () {
                      RepeatFunction.navigatorPush(
                          context: context,
                          pageWidget: AddClassPage(
                            index: index,
                            classHiveModel: data,
                          ));
                    },
                    onTap: () {
                      RepeatFunction.navigatorPush(
                          context: context,
                          pageWidget: AddClassPage(
                            index: index,
                            classHiveModel: data,
                          ));
                    },
                  );
                }),
              ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            RepeatFunction.navigatorPush(
                context: context, pageWidget: AddClassPage());
          },
          child: Container(
            width: 150,
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
                  text: "Add Class",
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

class ClassTile extends StatelessWidget {
  final String className;
  final List<String> subjects;
  final VoidCallback? onTap;

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ClassTile({
    super.key,
    required this.className,
    required this.subjects,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final subjectText =
        subjects.isNotEmpty ? subjects.join(', ') : 'No Subjects';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(
          className,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subjectText),
        onTap: onTap,
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showOptionsSheet(context),
        ),
      ),
    );
  }

  void _showOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  if (onEdit != null) onEdit!();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  if (onDelete != null) onDelete!();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
