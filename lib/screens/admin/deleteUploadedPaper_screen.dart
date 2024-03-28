import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pyq_portal/screens/papers_page.dart';
import 'package:pyq_portal/widgets/paper_card.dart';

class DeleteUploadedPaperScreen extends StatefulWidget {
  const DeleteUploadedPaperScreen({super.key, required this.currAdminId});
  final String currAdminId;

  @override
  State<DeleteUploadedPaperScreen> createState() =>
      _DeleteUploadedPaperScreenState();
}

class _DeleteUploadedPaperScreenState extends State<DeleteUploadedPaperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Papers"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: PapersPage( owner: widget.currAdminId,callingPage: "Admin",),
    );
  }
}
