import 'package:flutter/material.dart';
import 'package:pyq_portal/api/api_services.dart';
import 'package:pyq_portal/screens/admin/admin_dashboard.dart';

import 'uploadpaper_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  late TextEditingController _adminIdController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _adminIdController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future login(String adminId, String password) async {
    var res = await ApiServices().login(adminId, password);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              showCursor: false,
              controller: _adminIdController,
              decoration: InputDecoration(
                hintText: "Admin ID",
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              showCursor: false,
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.07,
              child: ElevatedButton(
                  onPressed: () async {
                    var response = await login(
                        _adminIdController.text, _passwordController.text);
                    print(response);
                    if (response == "Success") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminDashBoard(currAdminId: _adminIdController.text)));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(response)));
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ))),
        ],
      )),
    );
  }
}
