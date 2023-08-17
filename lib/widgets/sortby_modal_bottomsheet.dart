import 'package:flutter/material.dart';

class SortbyModalBottomSheet extends StatefulWidget {
  const SortbyModalBottomSheet({super.key});

  @override
  State<SortbyModalBottomSheet> createState() => _SortbyModalBottomSheetState();
}

class _SortbyModalBottomSheetState extends State<SortbyModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
    );
  }
}
