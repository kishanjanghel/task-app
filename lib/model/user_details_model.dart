import 'package:task_app/local_db/login_db.dart';

class UserDetailsModel {
  String? email;
  String? password;
  UserEnum? userType;

  UserDetailsModel({this.email, this.password, this.userType});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    userType = userTypeFromString(json['userType']);
  }
}

UserEnum userTypeFromString(String value) {
  return UserEnum.values
      .firstWhere((e) => e.name == value, orElse: () => UserEnum.none);
}
