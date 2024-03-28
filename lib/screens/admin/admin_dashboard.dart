import 'package:flutter/material.dart';
import 'package:pyq_portal/screens/admin/adminlogin_screen.dart';
import 'package:pyq_portal/screens/admin/uploadpaper_screen.dart';

import 'deleteUploadedPaper_screen.dart';

class AdminDashBoard extends StatelessWidget {
  const AdminDashBoard({super.key, required this.currAdminId});
  final String currAdminId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(onSelected: (value) {
            if (value == "Logout") {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AdminLoginScreen()));
            }
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text("LogOut"),
                value: "Logout",
              )
            ];
          })
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.1,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UploadPaperScreen(currAdminId: currAdminId)));
                    },
                    child: Row(children: [
                      Icon(Icons.file_upload_sharp),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                      Text("Upload Papers")
                    ])),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.1,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DeleteUploadedPaperScreen(
                              currAdminId: currAdminId)));
                    },
                    child: Row(children: [
                      Icon(Icons.delete),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                      Text("Delete Papers")
                    ])),
              ),
            ]),
      ),
    );
  }
}
