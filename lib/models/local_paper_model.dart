import 'package:hive/hive.dart';

part 'local_paper_model.g.dart';



@HiveType(typeId: 1)
class LocalPaper {
  LocalPaper({
    required this.year,
    required this.course,
    required this.semester,
    required this.subject,
    required this.term,
    required this.filePath,
  });

  @HiveField(0)
  int year;

  @HiveField(1)
  String course;

  @HiveField(2)
  int semester;

  @HiveField(3)
  String subject;

  @HiveField(4)
  String term;

  @HiveField(5)
  String filePath;
}
