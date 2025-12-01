import 'package:flutter/material.dart';

class ExpenseListSection extends StatelessWidget {
  const ExpenseListSection({super.key});

  final List<Map<String, dynamic>> sampleExpenses = const [
    {
      'name': 'Grocery Shopping',
      'category': 'Food',
      'date': 'Nov 28, 2024',
      'amount': 3500.00,
      'icon': Icons.shopping_cart,
      'color': Colors.blue,
    },
    {
      'name': 'Uber Ride',
      'category': 'Transport',
      'date': 'Nov 27, 2024',
      'amount': 850.00,
      'icon': Icons.directions_car,
      'color': Colors.green,
    },
    {
      'name': 'Electricity Bill',
      'category': 'Bills',
      'date': 'Nov 25, 2024',
      'amount': 2400.00,
      'icon': Icons.flash_on,
      'color': Colors.orange,
    },
    {
      'name': 'Restaurant Dinner',
      'category': 'Food',
      'date': 'Nov 24, 2024',
      'amount': 1800.00,
      'icon': Icons.restaurant,
      'color': Colors.blue,
    },
    {
      'name': 'Online Shopping',
      'category': 'Shopping',
      'date': 'Nov 23, 2024',
      'amount': 5200.00,
      'icon': Icons.shopping_bag,
      'color': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("All Expenses",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sampleExpenses.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final expense = sampleExpenses[index];
            return ExpenseListItem(
              name: expense['name'] as String,
              category: expense['category'] as String,
              date: expense['date'] as String,
              amount: expense['amount'] as double,
              icon: expense['icon'] as IconData,
              color: expense['color'] as Color,
            );
          },
        ),
      ],
    );
  }
}

class ExpenseListItem extends StatelessWidget {
  final String name;
  final String category;
  final String date;
  final double amount;
  final IconData icon;
  final Color color;

  const ExpenseListItem({
    super.key,
    required this.name,
    required this.category,
    required this.date,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        "$category • $date",
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade600,
        ),
      ),
      trailing: Text(
        "KES ${amount.toStringAsFixed(2)}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Viewing details for $name'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
    );
  }
}