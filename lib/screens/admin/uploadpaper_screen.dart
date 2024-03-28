import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:pyq_portal/api/api_services.dart';
import 'package:pyq_portal/models/paper_model.dart';

class UploadPaperScreen extends StatefulWidget {
  const UploadPaperScreen({super.key, required this.currAdminId});
  final String currAdminId;

  @override
  State<UploadPaperScreen> createState() => _UploadPaperScreenState();
}

class _UploadPaperScreenState extends State<UploadPaperScreen> {
  late GlobalKey<FormBuilderState> _formKey;

  Future upload(PaperModel uploadModel) async {
    var res = await ApiServices().uploadPaper(uploadModel);
    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormBuilderState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Paper"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormBuilderTextField(
                  name: "Subject",
                  decoration: InputDecoration(hintText: "Subject"),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: FormBuilderTextField(
                          name: "Course",
                          decoration: InputDecoration(hintText: "Course"),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: FormBuilderTextField(
                          name: "Semester",
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Semester", counterText: ""),
                        )),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: FormBuilderTextField(
                                  name: "Term",
                                  maxLength: 4,
                                  decoration: InputDecoration(
                                      hintText: "Term", counterText: ""),
                                )),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.05),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: FormBuilderTextField(
                                  name: "Year",
                                  maxLength: 4,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "Year", counterText: ""),
                                )),
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: FormBuilderFilePicker(
                                name: "selectedPaper",
                                maxFiles: 1,
                                typeSelectors: [
                                  TypeSelector(
                                    type: FileType.custom,
                                    selector: Row(
                                      children: <Widget>[
                                        Icon(Icons.add_circle),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text("Add Document"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                customFileViewerBuilder: (files, filesSetter) {
                                  return files!.length != 0
                                      ? Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(files.first.name),
                                              SizedBox(width: 10),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                                child: IconButton(
                                                    iconSize: 15,
                                                    splashRadius: 20,
                                                    onPressed: () {
                                                      files.clear();
                                                      setState(() {});
                                                    },
                                                    icon: Icon(Icons.close)),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container();
                                },
                                allowedExtensions: ['pdf'],
                                decoration: InputDecoration(
                                    label: Text("Select Paper")))),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.22,
                        child: ElevatedButton(
                            onPressed: () {
                              var formfields = _formKey.currentState!.fields;
                              PaperModel uploadModel = PaperModel(
                                  course: formfields['Course']!.value,
                                  subject: formfields['Subject']!.value,
                                  semester:
                                      int.parse(formfields['Semester']!.value),
                                  year: int.parse(formfields['Year']!.value),
                                  term: formfields['Term']!.value,
                                  filePath: formfields['selectedPaper']!
                                      .value[0]
                                      .path,
                                  paperId: "noId",
                                  owner: widget.currAdminId);
                              upload(uploadModel).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(value
                                            ? "Success"
                                            : "Error occured")));
                                if (value) {
                                  _formKey.currentState!.reset();
                                }
                              });
                            },
                            child: Text(
                              "UPLOAD",
                            ))),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
