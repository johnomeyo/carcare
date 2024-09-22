import 'package:flutter/material.dart';

class WorkShopExplore extends StatelessWidget {
  const WorkShopExplore({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.secondary.withOpacity(0.1),
            theme.colorScheme.secondary.withOpacity(0.2),
            theme.colorScheme.secondary.withOpacity(0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://xmonkeys360.com/wp-content/uploads/2020/02/Googlemap-600x551-1.jpg"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                "Find your ideal car workshop",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: theme.colorScheme.secondary.withOpacity(0.1),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward,
                        color: theme.colorScheme.secondary)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
