import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pyq_portal/api/api_constants.dart';
import '../models/paper_model.dart';

class ApiServices {
  Future getPapers(
      String page, String? searchString, String? sortBy, String? owner) async {
    List<PaperModel> list;
    try {
      var url = Uri.parse(ApiConstants.baseurl + ApiConstants.getPapers)
          .replace(queryParameters: {
        "page": page,
        "search": searchString,
        "sort": sortBy,
        "owner": owner,
      });
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // print(response.body);
        var data = json.decode(response.body);
        list = data.map<PaperModel>((json) {
          return PaperModel.fromJson(json);
        }).toList();
        return list;
      }
    } catch (e) {
      print("inside get paper api call");
      print(e);
    }
  }

  Future downloadPaper(String paperPath) async {
    var url = Uri.parse(ApiConstants.baseurl + ApiConstants.downloadPaper)
        .replace(queryParameters: {"name": paperPath});
    print(paperPath);
    var response = await http.get(url);
    String fileName = response.headers.entries.last.value;
    final dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/$fileName');
    if (!await file.exists()) {
      await file.create();
    }
    await file.writeAsBytes(response.bodyBytes);

    return file.path;
  }

  Future uploadPaper(PaperModel uploadModel) async {
    var url = Uri.parse(ApiConstants.baseurl + ApiConstants.uploadPaper);
    var request = await http.MultipartRequest('POST', url);
    request.fields.addAll({
      'year': uploadModel.year.toString(),
      'course': uploadModel.course,
      'subject': uploadModel.subject,
      'term': uploadModel.term,
      'semester': uploadModel.semester.toString(),
      'owner': uploadModel.owner,
    });
    request.files
        .add(await http.MultipartFile.fromPath('paper', uploadModel.filePath));
    print(request.headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future login(String adminId, String password) async {
    var url = Uri.parse(ApiConstants.baseurl + ApiConstants.loginAdmin);
    Map data = {
      "adminId": adminId,
      "password": password,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    } else {
      return "error occured";
    }
  }

  Future deletePaper(String paperID, String paperKey) async {
    var url = Uri.parse(ApiConstants.baseurl + ApiConstants.deletePaper)
        .replace(queryParameters: {"id": paperID, "key": paperKey});
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "error occured";
    }
  }
}
