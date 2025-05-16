import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/custom_widgets/custom_button.dart';
import 'package:task_app/custom_widgets/custom_textfeild.dart';
import 'package:task_app/local_db/teacher_db.dart';
import 'package:task_app/provider/teacher_notifier.dart';
import 'package:task_app/repeat_fucntion/constant.dart';

class AddTeacherPage extends StatefulWidget {
  TeacherHiveModel? teacherHiveModel;
  int? index;
  AddTeacherPage({super.key, this.teacherHiveModel, this.index});

  @override
  State<AddTeacherPage> createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjenameController = TextEditingController();
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _subjectKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameController.dispose();
    _subjenameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fetchTeacherData();
    super.initState();
  }

  fetchTeacherData() {
    if (widget.teacherHiveModel != null && widget.index != null) {
      _nameController.text = widget.teacherHiveModel!.name!;
      _subjenameController.text = widget.teacherHiveModel!.subject!;
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
        title: "Add Teacher",
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            CustomTextFieldValidator(
              formKey: _nameKey,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter teacher's name ";
                }
                return null;
              },
              textEditingController: _nameController,
              onchange: (p0) {
                validate(_nameKey);
              },
              hintText: "Enter Teacher's Name",
            ),
            SizedBox(
              height: defaultgap,
            ),
            CustomTextFieldValidator(
              formKey: _subjectKey,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter subject's name ";
                }
                return null;
              },
              textEditingController: _subjenameController,
              onchange: (p0) {
                validate(_subjectKey);
              },
              hintText: "Enter Subject's Name",
            ),
            SizedBox(
              height: defaultgap,
            ),
            CustomButton(
              label: widget.teacherHiveModel != null ? "Update" : "ADD",
              onPressed: () async {
                if (_nameKey.currentState?.validate() == true &&
                    _subjectKey.currentState?.validate() == true) {
                  print("calling teacher");

                  if (widget.index != null && widget.teacherHiveModel != null) {
                    await teacherNotifier.updateTeacher(
                      index: widget.index!,
                      updatedTeacher: TeacherHiveModel(
                          name: _nameController.text,
                          subject: _subjenameController.text),
                    );
                  } else {
                    await teacherNotifier
                        .addTeacher(
                            teacher: TeacherHiveModel(
                                name: _nameController.text,
                                subject: _subjenameController.text))
                        .whenComplete(() {
                      // Navigator.pop(context);
                    });
                  }
                  Navigator.pop(context);
                }

                print("is valid ${_nameKey.currentState?.validate()}");
              },
            )
          ],
        ),
      ),
    );
  }
}
