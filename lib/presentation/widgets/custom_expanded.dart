import 'package:flutter/material.dart';

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
