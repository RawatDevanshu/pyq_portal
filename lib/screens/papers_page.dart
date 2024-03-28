import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pyq_portal/api/api_services.dart';
import 'package:pyq_portal/models/paper_model.dart';
import 'package:pyq_portal/widgets/paper_card.dart';

class PapersPage extends StatefulWidget {
  const PapersPage(
      {super.key,
      this.searchString,
      this.sortBy,
      this.owner,
      required this.callingPage});
  final String? searchString;
  final String? sortBy;
  final String? owner;
  final String callingPage;
  @override
  State<PapersPage> createState() => _PapersPageState();
}

class _PapersPageState extends State<PapersPage> {
  Future<dynamic>? paperList;
  int page = 0;
  Future<dynamic> fetchPapers(int val) async {
    // print(widget.searchString);
    // print(page);
    var result = await ApiServices().getPapers(
        val.toString(), widget.searchString, widget.sortBy, widget.owner);
    return result;
  }

  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // paperList = fetchPapers(page);
    _pagingController.addPageRequestListener((pageKey) {
      fetchNewPage();
    });
  }

  Future<void> fetchNewPage() async {
    try {
      final newItems = await fetchPapers(page++);
      final isLastPage = newItems.length < 5; // 5 is page size in backend
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        _pagingController.appendPage(newItems, page);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  Future deletePaper(String paperID, String paperKey) async {
    var result = ApiServices().deletePaper(paperID, paperKey);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // print("built child");
    // print("child val:" + widget.searchString);
    page = 0;
    _pagingController.refresh();

    return Scaffold(
        body: PagedListView<int, dynamic>(
      pagingController: _pagingController,
      physics: BouncingScrollPhysics(),
      builderDelegate:
          PagedChildBuilderDelegate(itemBuilder: (context, item, index) {
        return PaperCard(
          model: item,
          callingPage: widget.callingPage,
          onTap: () {
            if (widget.callingPage == "Admin") {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Are you sure you want to delete?"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("No")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              deletePaper(item.paperId, item.filePath);
                            },
                            child: Text("Yes"))
                      ],
                    );
                  }).then((value) {
                setState(() {});
              });
            }
          },
        );
      }),
    ));
  }
}
