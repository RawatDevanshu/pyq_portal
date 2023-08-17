import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pyq_portal/models/boxes.dart';
import 'package:pyq_portal/models/local_paper_model.dart';

import '../widgets/paper_card.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  late List keyList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keyList = boxPapers.keys.toList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.box<LocalPaper>('paperBox').compact();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: boxPapers.length,
        itemBuilder: (context, index) {
          
          return PaperCard(
            model: boxPapers.get(keyList[index]),
            isDownloaded: true,
          );
        },
      ),
    );
  }
}
