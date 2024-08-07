import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pyq_portal/api/api_constants.dart';
import '../models/paper_model.dart';

class ApiServices {
  final storage = new FlutterSecureStorage();

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
      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        // print(response.body);
        var data = responseJson['data'];
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
    String fileName = paperPath;
    final dir = await getExternalStorageDirectory();
    final file = File('${dir!.path}/$fileName');
    if (!await file.exists()) {
      await file.create();
    }
    await file.writeAsBytes(response.bodyBytes);

    return file.path;
  }

  Future uploadPaper(PaperModel uploadModel) async {
    var accessToken = await storage.read(key: "accessToken");
    var url = Uri.parse(ApiConstants.baseurl + ApiConstants.uploadPaper);
    var request = await http.MultipartRequest('POST', url);
    request.headers.addAll({"Authorization": "Bearer $accessToken"});
    request.fields.addAll({
      'year': uploadModel.year.toString(),
      'course': uploadModel.course,
      'subject': uploadModel.subject,
      'term': uploadModel.term,
      'semester': uploadModel.semester.toString(),
      'owner': uploadModel.owner,
    });
    request.files
        .add(await http.MultipartFile.fromPath('file', uploadModel.filePath));
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var responseJson = json.decode(response.body);
    print(responseJson);

    if (response.statusCode == 200) {
      return responseJson['success'];
    } else {
      return responseJson;
    }
  }

  Future login(String adminId, String password) async {
    var url = Uri.parse(ApiConstants.baseurl + ApiConstants.loginAdmin);
    print(url);
    Map data = {
      "name": adminId,
      "password": password,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    var responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      await storage.write(
          key: "refreshToken", value: responseJson['data']['refreshToken']);
      await storage.write(
          key: "accessToken", value: responseJson['data']['accessToken']);

      return responseJson['success'];
    } else {
      return responseJson;
    }
  }

  Future deletePaper(String paperID, String paperKey) async {
    var accessToken = await storage.read(key: "accessToken");
    var url = Uri.parse(ApiConstants.baseurl + ApiConstants.deletePaper)
        .replace(queryParameters: {"id": paperID, "key": paperKey});
    var authHeader = {HttpHeaders.authorizationHeader: "Bearer $accessToken"};
    var response = await http.delete(url, headers: authHeader);
    var responseJson = json.decode(response.body);
    print(responseJson);

    if (response.statusCode == 200) {
      return responseJson['success'];
    } else {
      return responseJson['data'];
    }
  }
}
