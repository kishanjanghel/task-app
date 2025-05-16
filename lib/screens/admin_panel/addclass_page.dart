import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/custom_widgets/custom_appbar.dart';
import 'package:task_app/custom_widgets/custom_button.dart';
import 'package:task_app/custom_widgets/custom_textfeild.dart';
import 'package:task_app/local_db/class_db.dart';
import 'package:task_app/provider/teacher_notifier.dart';
import 'package:task_app/repeat_fucntion/constant.dart';
import 'package:task_app/repeat_fucntion/flutter_toast.dart';

class AddClassPage extends StatefulWidget {
  int? index;
  ClassHiveModel? classHiveModel;
  AddClassPage({super.key, this.index, this.classHiveModel});

  @override
  State<AddClassPage> createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _subjectKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchClasses();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  validate(GlobalKey<FormState> formKey) {
    formKey.currentState?.validate();
    setState(() {});
  }

  fetchClasses() {
    if (widget.classHiveModel != null && widget.index != null) {
      _nameController.text = widget.classHiveModel!.className!;
      _subjects.addAll(widget.classHiveModel!.subjects!);
    }
  }

  void _addSubject() {
    final text = _subjectController.text.trim();
    if (text.isNotEmpty && !_subjects.contains(text)) {
      setState(() {
        _subjects.add(text);
        _subjectController.clear();
      });
    }
  }

  late final List<String> _subjects = [];

  void _removeSubject(int index) {
    setState(() {
      _subjects.removeAt(index);
    });
  }

  void _submitSubjects() {
    // You can pass this to another page or provider
    Navigator.pop(context, _subjects);
  }

  @override
  Widget build(BuildContext context) {
    TeacherNotifier teacherNotifier = Provider.of<TeacherNotifier>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Class",
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            CustomTextFieldValidator(
              formKey: _nameKey,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter class's name ";
                }
                return null;
              },
              textEditingController: _nameController,
              onchange: (p0) {
                validate(_nameKey);
              },
              hintText: "Enter Class's Name",
            ),
            SizedBox(
              height: defaultgap,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _subjectController,
                    decoration: const InputDecoration(
                      hintText: 'Enter subject',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addSubject(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addSubject,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _subjects.isEmpty
                  ? const Center(child: Text('No subjects added yet.'))
                  : ListView.builder(
                      itemCount: _subjects.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(color: Colors.grey[100]!),
                              borderRadius: BorderRadius.circular(11.0),
                            ),
                            child: ListTile(
                              title: Text(_subjects[index]),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removeSubject(index),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(
              height: defaultgap,
            ),
            CustomButton(
              label: widget.classHiveModel == null && widget.index == null
                  ? "ADD"
                  : "Update",
              onPressed: () async {
                if (_nameKey.currentState?.validate() == true &&
                    _subjects.isNotEmpty) {
                  if (widget.classHiveModel == null && widget.index == null) {
                    await teacherNotifier.addClassed(
                      classes: ClassHiveModel(
                        className: _nameController.text.trim(),
                        subjects: _subjects,
                      ),
                    );
                  } else {
                    await teacherNotifier.updateClassed(
                      updateclasses: ClassHiveModel(
                        className: _nameController.text.trim(),
                        subjects: _subjects,
                      ),
                      index: widget.index ?? 0,
                    );
                  }
                  Navigator.pop(context);
                }
                if (_subjects.isEmpty) {
                  ToastClass.showToast(
                      msg: "Please add at least one subject",
                      color: Colors.red);
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
