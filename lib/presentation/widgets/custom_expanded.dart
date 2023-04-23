import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomExpanded extends StatelessWidget {
  int flex;
  Widget expandedChild;
  CustomExpanded({
    super.key,
    required this.flex,
    required this.expandedChild,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: expandedChild,
    );
  }
}
