import 'package:flutter/material.dart';

class FilterModalBottomSheet extends StatefulWidget {
  const FilterModalBottomSheet({super.key});

  @override
  State<FilterModalBottomSheet> createState() => _FilterModalBottomSheetState();
}

class _FilterModalBottomSheetState extends State<FilterModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.8,
    );
  }
}