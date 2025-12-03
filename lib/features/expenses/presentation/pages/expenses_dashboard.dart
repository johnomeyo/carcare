import 'package:carcare/features/expenses/presentation/widgets/expense_chart.dart';
import 'package:carcare/features/expenses/presentation/widgets/expense_list.dart';
import 'package:carcare/features/expenses/presentation/widgets/expense_search.dart';
import 'package:carcare/features/expenses/presentation/widgets/expense_summary.dart';
import 'package:flutter/material.dart';

class ExpenseDashboardPage extends StatelessWidget {
  const ExpenseDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Dashboard"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              ExpenseSummarySection(),
              SizedBox(height: 16),
              ExpenseSearchBar(),
              SizedBox(height: 16),
              SizedBox(height: 16),
              ExpenseChartsSection(),
              SizedBox(height: 16),
              ExpenseListSection(),
            ],
          ),
        ),
      ),
    );
  }
}
