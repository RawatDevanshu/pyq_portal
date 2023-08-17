import 'package:flutter/material.dart';
import 'package:pyq_portal/api/api_services.dart';
import 'package:pyq_portal/widgets/paper_card.dart';

class PapersPage extends StatefulWidget {
  const PapersPage({super.key});

  @override
  State<PapersPage> createState() => _PapersPageState();
}

class _PapersPageState extends State<PapersPage> {
  Future<dynamic>? paperList;

  Future<dynamic> fetchPapers(int val) async {
    var result = await ApiServices().getPapers(val.toString());
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paperList = fetchPapers(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: paperList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data as List;
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return PaperCard(
                    model: data[index],
                    isDownloaded: false,
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
