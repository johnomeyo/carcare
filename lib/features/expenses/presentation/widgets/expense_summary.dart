import 'package:flutter/material.dart';

class ExpenseSummarySection extends StatelessWidget {
  const ExpenseSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: SummaryCard(
            title: "Total Spent",
            value: "KES 13,750",
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: SummaryCard(
            title: "This Month",
            value: "KES 8,600",
          ),
        ),
      ],
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
