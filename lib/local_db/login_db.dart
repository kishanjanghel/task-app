import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_app/model/user_details_model.dart';
import 'package:task_app/repeat_fucntion/flutter_toast.dart';

enum UserEnum { student, teacher, none, admin }

class LoginDb {
  static String studentEmail = "kishan@gmail.com";
  static String studentPassword = "student@2025";

  static String teacherEmail = "kishan.teacher@gmail.com";
  static String teacherPassword = "teacher@2025";

  static String adminEmail = "kishan.admin@gmail.com";
  static String adminPassword = "admin@2025";
  static UserEnum passwrodChecker(String email, String password) {
    if (email == studentEmail && password == studentPassword) {
      ToastClass.showToast(
          msg: "Student Loggedin Successful",
          bgColor: Colors.green,
          color: Colors.white);
      return UserEnum.student;
    } else if (email == teacherEmail && password == teacherPassword) {
      ToastClass.showToast(
          msg: "Teacher Logged Successful",
          bgColor: Colors.green,
          color: Colors.white);
      return UserEnum.teacher;
    } else if (email == adminEmail && password == adminPassword) {
      ToastClass.showToast(
          msg: "Admin Logged Successful",
          bgColor: Colors.green,
          color: Colors.white);
      return UserEnum.teacher;
    } else {
      ToastClass.showToast(msg: "Invalid Email or Password");
      return UserEnum.none;
    }
  }

  static String studentKey = "studentKey";
  static String teacherKey = "teacherKey";
  static String adminKey = "adminKey";

  static Future<UserDetailsModel> login({
    required BuildContext context,
    required String email,
    required String password,
    required UserEnum userType,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      UserEnum loginResponse = passwrodChecker(email, password);
      if (loginResponse != UserEnum.none) {
        Map<String, dynamic> response = {
          "email": email,
          "password": password,
          "userType": loginResponse.name
        };
        String json = jsonEncode(response);
        String? loginKey;
        if (userType == UserEnum.admin) {
          loginKey = adminKey;
        } else if (userType == UserEnum.student) {
          loginKey = studentKey;
        } else {
          loginKey = teacherKey;
        }

        await prefs.setString(loginKey, json);
        String? login = prefs.getString(loginKey);
        // ignore: avoid_print
        print("this is login ${login!}");
        return UserDetailsModel.fromJson(jsonDecode(login));
      } else {
        return UserDetailsModel();
      }
    } catch (e) {
      print("this is error $e");
      return UserDetailsModel();
    }
  }

  static Future<UserDetailsModel> getUserDetails(
      {required UserEnum userType}) async {
    final prefs = await SharedPreferences.getInstance();
    String? loginKey;
    if (userType == UserEnum.admin) {
      loginKey = adminKey;
    } else if (userType == UserEnum.student) {
      loginKey = studentKey;
    } else {
      loginKey = teacherKey;
    }
    String? login = prefs.getString(loginKey);
    return UserDetailsModel.fromJson(jsonDecode(login!));
  }

  static Future<void> logout({required UserEnum userType}) async {
    String? loginKey;
    if (userType == UserEnum.admin) {
      loginKey = adminKey;
    } else if (userType == UserEnum.student) {
      loginKey = studentKey;
    } else {
      loginKey = teacherKey;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(loginKey);
  }

  // static Future<void> signup({
  //   required BuildContext context,
  //   required String email,
  //   required String password,
  //   required UserType userType,
  // }) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('${userType.name}_email', email);
  //   await prefs.setString('${userType.name}_password', password);

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text("Signup successful!")),
  //   );

  //   Navigator.pop(context);
  // }
}
