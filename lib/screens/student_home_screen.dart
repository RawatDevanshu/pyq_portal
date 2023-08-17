import 'package:flutter/material.dart';
import 'package:pyq_portal/screens/downloads_page.dart';
import 'package:pyq_portal/screens/papers_page.dart';

import '../widgets/filter_modal_bottomsheet.dart';
import '../widgets/sortby_modal_bottomsheet.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Image.asset(
          'assets/notebook.png',
          scale: 14,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                builder: (context) => SortbyModalBottomSheet(),
              );
            },
            icon: Icon(Icons.compare_arrows_sharp),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                builder: (context) => FilterModalBottomSheet(),
              );
            },
            icon: Icon(Icons.filter_alt_outlined),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.dark_mode_outlined),
            color: Colors.black,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            TextField(
              showCursor: false,
              decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
            TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              tabs: [Tab(text: "Papers"), Tab(text: "Downloads")],
              controller: _tabController,
            ),
            Flexible(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                controller: _tabController,
                children: [
                  PapersPage(),
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
