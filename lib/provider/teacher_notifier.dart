import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_app/local_db/class_db.dart';
import 'package:task_app/local_db/student_db.dart';
import 'package:task_app/local_db/teacher_db.dart';
import 'package:task_app/repeat_fucntion/flutter_toast.dart';
// import 'teacher_db.dart';

class TeacherNotifier with ChangeNotifier {
  final String _boxteacher = 'teacherBox';
  List<TeacherHiveModel> _teachers = [];

  List<TeacherHiveModel> get teachers => _teachers;
  final String _studentBox = 'studentBox';
  List<StudentHiveModel> _students = [];

  List<StudentHiveModel> get students => _students;
  Future<void> initAll() async {
    init();
    initStudent();
    initClasses();
    // notifyListeners();
  }

  Future<void> init() async {
    final box = await Hive.openBox<TeacherHiveModel>(_boxteacher);
    _teachers = box.values.toList();
    notifyListeners();
  }

  Future<void> addTeacher({required TeacherHiveModel teacher}) async {
    // await Hive.box<TeacherHiveModel>(_boxteacher).clear();

    final box = await Hive.openBox<TeacherHiveModel>(_boxteacher);
    await box.add(teacher);
    _teachers = box.values.toList();
    print("total ${box.values.toList()}");
    ToastClass.showToast(
        msg: "Teacher Added Successfully",
        bgColor: Colors.green,
        color: Colors.white);
    notifyListeners();
  }

  Future<void> updateTeacher(
      {required int index, required TeacherHiveModel updatedTeacher}) async {
    final box = await Hive.openBox<TeacherHiveModel>(_boxteacher);
    await box.putAt(index, updatedTeacher);
    _teachers = box.values.toList();
    ToastClass.showToast(
        msg: "Teacher Updated Successfully",
        bgColor: Colors.green,
        color: Colors.white);
    notifyListeners();
  }

  Future<void> deleteTeacher(int index) async {
    final box = await Hive.openBox<TeacherHiveModel>(_boxteacher);
    await box.deleteAt(index);
    _teachers = box.values.toList();
    ToastClass.showToast(
        msg: "Teacher Deleted Successfully",
        bgColor: Colors.green,
        color: Colors.white);
    notifyListeners();
  }

  Future<void> clearAll() async {
    final box = await Hive.openBox<TeacherHiveModel>(_boxteacher);
    await box.clear();
    _teachers = [];
    notifyListeners();
  }

  // student-
  Future<void> initStudent() async {
    final box = await Hive.openBox<StudentHiveModel>(_studentBox);
    _students = box.values.toList();
    notifyListeners();
  }

  Future<void> addStudent({required StudentHiveModel student}) async {
    final box = await Hive.openBox<StudentHiveModel>(_studentBox);
    await box.add(student);
    _students = box.values.toList();
    ToastClass.showToast(
        msg: "Student Added Successfully",
        bgColor: Colors.green,
        color: Colors.white);
    notifyListeners();
  }

  Future<void> updateStudent(
      {required int index, required StudentHiveModel updateStudent}) async {
    final box = await Hive.openBox<StudentHiveModel>(_studentBox);
    await box.putAt(index, updateStudent);
    _students = box.values.toList();
    ToastClass.showToast(
        msg: "Student Updated Successfully",
        bgColor: Colors.green,
        color: Colors.white);
    notifyListeners();
  }

  Future<void> deleteStudent(int index) async {
    final box = await Hive.openBox<StudentHiveModel>(_studentBox);
    await box.deleteAt(index);
    _students = box.values.toList();
    ToastClass.showToast(
        msg: "Student Deleted Successfully",
        bgColor: Colors.green,
        color: Colors.white);
    notifyListeners();
  }

  Future<void> clearAllStudent() async {
    final box = await Hive.openBox<StudentHiveModel>(_studentBox);
    await box.clear();
    _students = [];
    notifyListeners();
  }

  // Classes
  final String _classBox = 'classsBox';
  List<ClassHiveModel> _classes = [];

  List<ClassHiveModel> get classes => _classes;

  Future<void> initClasses() async {
    final box = await Hive.openBox<ClassHiveModel>(_classBox);
    _classes = box.values.toList();
    notifyListeners();
  }

  Future<void> addClassed({required ClassHiveModel classes}) async {
    final box = await Hive.openBox<ClassHiveModel>(_classBox);
    await box.add(classes);
    _classes = box.values.toList();
    ToastClass.showToast(
        msg: "Class Added Successfully",
        bgColor: Colors.green,
        color: Colors.white);
    notifyListeners();
  }

  Future<void> updateClassed(
      {required int index, required ClassHiveModel updateclasses}) async {
    final box = await Hive.openBox<ClassHiveModel>(_classBox);
    await box.putAt(index, updateclasses);
    _classes = box.values.toList();
    ToastClass.showToast(
        msg: "Class Updated Successfully",
        bgColor: Colors.green,
        color: Colors.white);
    notifyListeners();
  }

  Future<void> deleteClasse(int index) async {
    final box = await Hive.openBox<ClassHiveModel>(_classBox);
    await box.deleteAt(index);
    _classes = box.values.toList();
    ToastClass.showToast(
        msg: "Class Deleted Successfully",
        bgColor: Colors.green,
        color: Colors.white);
    notifyListeners();
  }

  Future<void> clearClasses() async {
    final box = await Hive.openBox<ClassHiveModel>(_classBox);
    await box.clear();
    _classes = [];
    notifyListeners();
  }
}
