import 'package:flutter/material.dart';

class ServiceCategory extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ServiceCategory({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
              radius: 30,
              backgroundColor:theme.colorScheme.secondary.withOpacity(0.1),
              child: Icon(icon, size: 26,color: theme.colorScheme.secondary)),
          const SizedBox(
            height: 10,
          ),
          Text(title, style: TextStyle(color: theme.colorScheme.secondary),),
        ],
      ),
    );
  }
}
