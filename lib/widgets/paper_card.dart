import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:open_file/open_file.dart';
import 'package:pyq_portal/models/boxes.dart';
import 'package:pyq_portal/models/local_paper_model.dart';
import 'package:pyq_portal/models/paper_model.dart';

import '../api/api_services.dart';

class PaperCard extends StatefulWidget {
  PaperCard({super.key, required this.model, required this.isDownloaded});
  var model;
  bool isDownloaded;

  @override
  State<PaperCard> createState() => _PaperCardState();
}

class _PaperCardState extends State<PaperCard> {
  Future<dynamic> getDownloadPaper(String paperPath) async {
    var result = await ApiServices().downloadPaper(paperPath);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var _paperModel = widget.model;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.18,
        child: ListTile(
          tileColor: Colors.blueGrey[100],
          onTap: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: Icon(Icons.image),
          title: Row(
            children: [
              Text(_paperModel.subject),
              SizedBox(
                width: 10,
              ),
              Text(_paperModel.course),
            ],
          ),
          subtitle: Row(
            children: [
              Text(_paperModel.year.toString()),
              SizedBox(width: 10),
              Text(_paperModel.semester.toString()),
            ],
          ),
          trailing: widget.isDownloaded
              ? IconButton(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.delete_outline))
              : IconButton(
                  onPressed: () {
                    getDownloadPaper(_paperModel.filePath).then((filePath) {
                      boxPapers.put(
                          _paperModel.paperId,
                          LocalPaper(
                              year: _paperModel.year,
                              course: _paperModel.course,
                              semester: _paperModel.semester,
                              subject: _paperModel.subject,
                              term: _paperModel.term,
                              filePath: filePath));
                      OpenFile.open(filePath, type: "application/pdf");
                    });
                  },
                  icon: const Icon(Icons.file_download_outlined)),
        ),
      ),
    );
  }
}
