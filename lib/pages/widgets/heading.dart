import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String heading;
  const Heading({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      heading,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
