import 'package:hive/hive.dart';

part 'teacher_db.g.dart';

@HiveType(typeId: 1)
class TeacherHiveModel extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? subject;

  TeacherHiveModel({this.name, this.subject});
}
