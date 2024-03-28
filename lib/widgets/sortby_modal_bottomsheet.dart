import 'package:flutter/material.dart';

enum sortOptions { year, semester }

sortOptions sortView = sortOptions.year;


class SortbyModalBottomSheet extends StatefulWidget {
  const SortbyModalBottomSheet({super.key});

  @override
  State<SortbyModalBottomSheet> createState() => _SortbyModalBottomSheetState();
}

class _SortbyModalBottomSheetState extends State<SortbyModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Sort by"),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: SegmentedButton(
                segments: [
                  ButtonSegment(
                      value: sortOptions.year,
                      label: Text("Year"),
                      icon: Icon(null)),
                  ButtonSegment(
                      value: sortOptions.semester,
                      label: Text("Semester"),
                      icon: Icon(null))
                ],
                selected: <sortOptions>{sortView},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    sortView = newSelection.first as sortOptions;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 15),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")),
                  SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(sortView.name);
                      },
                      style:
                          ButtonStyle(elevation: MaterialStatePropertyAll(1)),
                      child: Text("Done")),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
