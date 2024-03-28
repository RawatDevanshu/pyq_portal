import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

DateTime _selectedYear = DateTime.now();

class FilterModalBottomSheet extends StatefulWidget {
  const FilterModalBottomSheet({super.key});

  @override
  State<FilterModalBottomSheet> createState() => _FilterModalBottomSheetState();
}

class _FilterModalBottomSheetState extends State<FilterModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text("Filters"),
            ),
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Row(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                    child: CupertinoPicker(
                      itemExtent: 50,
                      diameterRatio: 500,
                      onSelectedItemChanged: (value) {},
                      children: [Text("2022"), Text("2022"), Text("2022")],
                    ),
                  ),
                )
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {}, child: Text("Cancel")),
                  ElevatedButton(onPressed: () {}, child: Text("Done")),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
