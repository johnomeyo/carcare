import 'package:flutter/material.dart';

class CarComponentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final double percentage;
  final String description;

  const CarComponentCard({
    super.key,
    required this.title,
    required this.icon,
    required this.percentage,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(color: theme.colorScheme.secondary),
                ),
                const SizedBox(width: 5,),
                Icon(
                  icon,
                  size: 12,
                  color: theme.colorScheme.secondary
                ),
              ],
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: percentage / 100,
                  color: Colors.grey,
                  strokeWidth: 10,
                ),
                CircularProgressIndicator(
                  value: percentage / 100,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary),
                  strokeWidth: 10,
                ),
                Text(
                  '${percentage.toStringAsFixed(0)}%',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style:  TextStyle(color: theme.colorScheme.secondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
