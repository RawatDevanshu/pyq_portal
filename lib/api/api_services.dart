import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pyq_portal/api/api_constants.dart';
import '../models/paper_model.dart';

class ApiServices {
  Future getPapers(String page) async {
    List<PaperModel> list;
    try {
      var url = Uri.parse(ApiConstants.baseurl + ApiConstants.getPapers)
          .replace(queryParameters: {
        "p": page,
      });
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        list = data.map<PaperModel>((json) {
          return PaperModel.fromJson(json);
        }).toList();
        return list;
      }
    } catch (e) {
      print(e);
    }
  }

  Future downloadPaper(String paperPath) async {
    var url = Uri.parse(ApiConstants.baseurl + ApiConstants.downloadPaper)
        .replace(queryParameters: {"path": paperPath});
    var response = await http.get(url);
    String fileName = response.headers.entries.last.value;
    final dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/$fileName.pdf');
    if (!await file.exists()) {
      await file.create();
    }
    await file.writeAsBytes(response.bodyBytes);

    return file.path;
  }
}
