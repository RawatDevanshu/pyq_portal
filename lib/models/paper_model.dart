class PaperModel {
  int year;
  String course;
  int semester;
  String subject;
  String term;
  String filePath;
  String paperId;

  PaperModel({
    required this.year,
    required this.course,
    required this.semester,
    required this.subject,
    required this.term,
    required this.filePath,
    required this.paperId,
  });

  factory PaperModel.fromJson(Map<String, dynamic> json) {
    return PaperModel(
        year: json['year'],
        course: json['course'],
        semester: json['semester'],
        term: json['term'],
        subject: json['subject'],
        filePath: json['file'],
        paperId: json["_id"]);
  }
}
