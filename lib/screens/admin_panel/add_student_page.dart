import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/custom_widgets/custom_button.dart';
import 'package:task_app/custom_widgets/custom_textfeild.dart';
import 'package:task_app/local_db/student_db.dart';
import 'package:task_app/provider/teacher_notifier.dart';
import 'package:task_app/repeat_fucntion/constant.dart';

class AddStudentPage extends StatefulWidget {
  final StudentHiveModel? student;
  final int? index;
  const AddStudentPage({super.key, this.student, this.index});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classnameController = TextEditingController();
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _classKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getStudentDetails();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _classnameController.dispose();
    super.dispose();
  }

  getStudentDetails() {
    if (widget.student != null) {
      _nameController.text = widget.student!.name!;
      _classnameController.text = widget.student!.className!;
    }
  }

  validate(GlobalKey<FormState> formKey) {
    formKey.currentState?.validate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TeacherNotifier teacherNotifier = Provider.of<TeacherNotifier>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Student",
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            CustomTextFieldValidator(
              formKey: _nameKey,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter student's name ";
                }
                return null;
              },
              textEditingController: _nameController,
              onchange: (p0) {
                validate(_nameKey);
              },
              hintText: "Enter Student's Name",
            ),
            SizedBox(
              height: defaultgap,
            ),
            CustomTextFieldValidator(
              formKey: _classKey,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter class's name ";
                }
                return null;
              },
              textEditingController: _classnameController,
              onchange: (p0) {
                validate(_classKey);
              },
              hintText: "Enter Class's Name",
            ),
            SizedBox(
              height: defaultgap,
            ),
            CustomButton(
              label: widget.student == null ? "ADD" : "Update",
              onPressed: () async {
                if (_classKey.currentState!.validate() &&
                    _nameKey.currentState!.validate()) {
                  if (widget.student == null) {
                    await teacherNotifier.addStudent(
                        student: StudentHiveModel(
                            name: _nameController.text,
                            className: _classnameController.text));
                    print("is valid ${_nameKey.currentState?.validate()}");
                  } else {
                    await teacherNotifier.updateStudent(
                      index: widget.index ?? 0,
                      updateStudent: StudentHiveModel(
                          name: _nameController.text,
                          className: _classnameController.text),
                    );
                  }
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
