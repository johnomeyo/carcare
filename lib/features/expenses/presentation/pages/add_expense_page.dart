import 'package:carcare/features/expenses/presentation/widgets/expense_basics.dart';
import 'package:carcare/features/expenses/presentation/widgets/attachments_sheet.dart';
import 'package:carcare/features/expenses/presentation/widgets/categories_sheet.dart';
import 'package:carcare/features/expenses/presentation/widgets/expense_category.dart';
import 'package:carcare/features/expenses/presentation/widgets/vehicle_status.dart';
import 'package:flutter/material.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ExpenseTile(
            title: "Category",
            subtitle: "Select expense category",
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const ExpenseCategorySheet(),
              );
            },
          ),
          ExpenseTile(
            title: "Basics",
            subtitle: "Amount, date, time, vehicle",
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const ExpenseBasicsSheet(),
              );
            },
          ),
          ExpenseTile(
            title: "Vehicle Status",
            subtitle: "Odometer, fuel level, vendor, location",
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const VehicleStatusSheet(),
              );
            },
          ),
          ExpenseTile(
            title: "Category Details",
            subtitle: "Fuel, maintenance, repair etc.",
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const CategorySpecificSheet(),
              );
            },
          ),
          ExpenseTile(
            title: "Attachments",
            subtitle: "Receipts, photos",
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const AttachmentsSheet(),
              );
            },
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {},
            child: const Text("Save Expense"),
          ),
        ],
      ),
    );
  }
}

class ExpenseTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ExpenseTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle:
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
