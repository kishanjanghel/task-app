import 'package:hive/hive.dart';

part 'student_db.g.dart';

@HiveType(typeId: 2)
class StudentHiveModel extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? className;

  StudentHiveModel({this.name, this.className});
}
