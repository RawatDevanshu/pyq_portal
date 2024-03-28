import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:open_file/open_file.dart';
import 'package:pyq_portal/models/boxes.dart';
import 'package:pyq_portal/models/local_paper_model.dart';
import 'package:pyq_portal/models/paper_model.dart';

import '../api/api_services.dart';

class PaperCard extends StatefulWidget {
  PaperCard(
      {super.key, required this.model, required this.callingPage, this.onTap});
  var model;
  String callingPage;
  VoidCallback? onTap;

  @override
  State<PaperCard> createState() => _PaperCardState();
}

class _PaperCardState extends State<PaperCard> {
  bool _downloadComplete = false;
  String _filePath = "";

  Future<dynamic> getDownloadPaper(String paperPath) async {
    var result = await ApiServices().downloadPaper(paperPath);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var _paperModel = widget.model;
    if (widget.callingPage == "Student") {
      var _alreadyDownloaded = boxPapers.get(_paperModel.paperId);
      if (_alreadyDownloaded != null) {
        _filePath = _alreadyDownloaded.filePath;
        _downloadComplete = true;
        setState(() {});
      }
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.18,
        child: ListTile(
          onTap: () {
            if (_downloadComplete) {
              OpenFile.open(_filePath, type: "application/pdf");
            }
            print(widget.model.filePath);
          },
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
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text("year: ${_paperModel.year}"),
              SizedBox(height: 5),
              Text("semester: ${_paperModel.semester}"),
              SizedBox(height: 5),
              Text(_paperModel.term + " term"),
            ],
          ),
          trailing: (widget.callingPage == "Downloads" ||
                  widget.callingPage == "Admin")
              ? IconButton(
                  onPressed: widget.onTap,
                  icon: const Icon(Icons.delete_outline))
              : IconButton(
                  onPressed: () {
                    if (_downloadComplete) {
                      OpenFile.open(_filePath, type: "application/pdf");
                    } else {
                      getDownloadPaper(_paperModel.filePath).then((filePath) {
                        setState(() {
                          _downloadComplete = true;
                          _filePath = filePath;
                        });
                        boxPapers.put(
                            _paperModel.paperId,
                            LocalPaper(
                                uniqueId: _paperModel.paperId,
                                year: _paperModel.year,
                                course: _paperModel.course,
                                semester: _paperModel.semester,
                                subject: _paperModel.subject,
                                term: _paperModel.term,
                                filePath: filePath));
                      });
                    }
                  },
                  icon: Icon(_downloadComplete
                      ? Icons.download_done
                      : Icons.file_download)),
        ),
      ),
    );
  }
}
