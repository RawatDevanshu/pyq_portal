import 'package:hive/hive.dart';

part 'local_paper_model.g.dart';

@HiveType(typeId: 1)
class LocalPaper {
  LocalPaper({
    required this.uniqueId,
    required this.year,
    required this.course,
    required this.semester,
    required this.subject,
    required this.term,
    required this.filePath,
  });
  @HiveField(0)
  String uniqueId;

  @HiveField(1)
  int year;

  @HiveField(2)
  String course;

  @HiveField(3)
  int semester;

  @HiveField(4)
  String subject;

  @HiveField(5)
  String term;

  @HiveField(6)
  String filePath;
}
