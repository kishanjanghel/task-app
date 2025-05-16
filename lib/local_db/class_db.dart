import 'package:hive/hive.dart';

part 'class_db.g.dart';

@HiveType(typeId: 3)
class ClassHiveModel extends HiveObject {
  @HiveField(0)
  String? className;

  @HiveField(1)
  List<String>? subjects;

  ClassHiveModel({this.className, this.subjects});
}
