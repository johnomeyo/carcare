import 'package:flutter/material.dart';


class InspectionHeaderCard extends StatelessWidget {
  const InspectionHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.verified, color: colorScheme.primary, size: 30),
              const SizedBox(width: 10),
              Text(
                "Inspection Status",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "NTSA Inspection expires in:",
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 6),
          Text(
            "44 Days",
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary, 
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.update),
            label: const Text("Update Inspection Date"),
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ReminderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const ReminderCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor, 
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor, 
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HistoryTile extends StatelessWidget {
  final String date;
  final String status;
  final Color color;

  const HistoryTile({
    super.key,
    required this.date,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, size: 20, color: theme.colorScheme.secondary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              date,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Text(
            status,
            style: theme.textTheme.titleSmall?.copyWith(
              color: color, 
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}


class InspectionPage extends StatelessWidget {
  const InspectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Vehicle Inspection",
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InspectionHeaderCard(),

            const SizedBox(height: 25),

            Text(
              "Upcoming Reminders",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),

            const ReminderCard(
              title: "Insurance Expiry",
              subtitle: "Expires in 14 days",
              icon: Icons.shield,
              color: Colors.redAccent,
            ),

            const SizedBox(height: 12),

            const ReminderCard(
              title: "Service Mileage",
              subtitle: "Service due in 1,200 km",
              icon: Icons.build,
              color: Colors.orange,
            ),

            const SizedBox(height: 25),

            Text(
              "Inspection History",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            const HistoryTile(
              date: "12 Jan 2024",
              status: "Passed",
              color: Colors.green,
            ),
            const HistoryTile(
              date: "10 Jan 2023",
              status: "Failed",
              color: Colors.red,
            ),
            const HistoryTile(
              date: "05 Jan 2022",
              status: "Passed",
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}