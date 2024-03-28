import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:pyq_portal/screens/downloads_page.dart';
import 'package:pyq_portal/screens/papers_page.dart';

import '../widgets/filter_modal_bottomsheet.dart';
import '../widgets/sortby_modal_bottomsheet.dart';
import 'admin/adminlogin_screen.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchController;
  String searchString = "";
  String sortBy = "year";

  void updateString() {
    setState(() {
      searchString = _searchController.text;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _searchController = TextEditingController();
    _searchController.addListener(updateString);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.removeListener(updateString);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AdaptiveThemeManager currentTheme = AdaptiveTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Image.asset(
          'assets/notebook.png',
          scale: 14,
          color: currentTheme.mode.modeName == "Dark"
              ? Colors.white
              : Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final res = await showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                builder: (context) => SortbyModalBottomSheet(),
              );
              if (res != null) {
                setState(() {
                  sortBy = res;
                });
              }
            },
            icon: Icon(Icons.compare_arrows_sharp),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                builder: (context) => FilterModalBottomSheet(),
              );
            },
            icon: Icon(Icons.filter_alt_outlined),
          ),
          IconButton(
            onPressed: () {
              if (currentTheme.mode.modeName == "Dark") {
                currentTheme.setLight();
              } else {
                currentTheme.setDark();
              }
            },
            icon: Icon(currentTheme.mode.modeName == "Dark"
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined),
          ),
          PopupMenuButton(onSelected: (value) {
            if (value == "admin") {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => AdminLoginScreen()))
                  .then((value) {
                setState(() {});
              });
            }
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem(
                child: Text("admin"),
                value: "admin",
              )
            ];
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            TextField(
              showCursor: false,
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search",
                suffixIcon: Icon(
                  Icons.search,
                ),
              ),
            ),
            TabBar(
              tabs: [Tab(text: "Papers"), Tab(text: "Downloads")],
              controller: _tabController,
            ),
            Flexible(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                controller: _tabController,
                children: [
                  PapersPage(
                    searchString: searchString,
                    sortBy: sortBy,
                    callingPage: "Student",
                  ),
                  DownloadsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
