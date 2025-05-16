import 'package:flutter/material.dart';
import 'package:task_app/local_db/login_db.dart';
import 'package:task_app/model/user_details_model.dart';

class UserdetailsNotifier extends ChangeNotifier {
  UserDetailsModel _adminDetails = UserDetailsModel();

  UserDetailsModel get admindetails => _adminDetails;

  //student
  UserDetailsModel _studentdetails = UserDetailsModel();

  UserDetailsModel get studentdetails => _studentdetails;
  // teacher
  UserDetailsModel _teacherdetails = UserDetailsModel();

  UserDetailsModel get teacherdetails => _teacherdetails;

  Future<void> userLogin(
      {required BuildContext context,
      required String email,
      required String password,
      required UserEnum userEnum}) async {
    try {
      UserDetailsModel data = await LoginDb.login(
          context: context,
          email: email,
          password: password,
          userType: userEnum);
      if (userEnum == UserEnum.admin) {
        _adminDetails = data;
      } else if (userEnum == UserEnum.student) {
        _studentdetails = data;
      } else if (userEnum == UserEnum.teacher) {
        _teacherdetails = data;
      }

      notifyListeners();
    } catch (e) {}
  }

  Future<void> userLogout({required UserEnum userEnum}) async {
    try {
      await LoginDb.logout(userType: userEnum);
      if (userEnum == UserEnum.admin) {
        _adminDetails = UserDetailsModel();
      } else if (userEnum == UserEnum.student) {
        _studentdetails = UserDetailsModel();
      } else if (userEnum == UserEnum.teacher) {
        _teacherdetails = UserDetailsModel();
      }

      _adminDetails = UserDetailsModel();
      notifyListeners();
    } catch (e) {}
  }

  Future<void> getUserDetails({required UserEnum userEnum}) async {
    try {
      UserDetailsModel data = await LoginDb.getUserDetails(userType: userEnum);
      if (userEnum == UserEnum.admin) {
        _adminDetails = data;
      } else if (userEnum == UserEnum.student) {
        _studentdetails = data;
      } else if (userEnum == UserEnum.teacher) {
        _teacherdetails = data;
      }

      notifyListeners();
    } catch (e) {
      print("this is error $e");
    }
  }
}
