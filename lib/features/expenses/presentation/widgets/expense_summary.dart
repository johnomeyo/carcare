import 'package:carcare/features/expenses/dormain/entities/expense_entity.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_bloc.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_event.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_state.dart';
import 'package:carcare/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
class ExpenseSummarySection extends StatefulWidget {
  const ExpenseSummarySection({super.key});

  @override
  State<ExpenseSummarySection> createState() => _ExpenseSummarySectionState();
}

class _ExpenseSummarySectionState extends State<ExpenseSummarySection> {
  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(LoadExpenses());
    
  }

  Map<String, double> _calculateSummary(List<Expense> expenses) {
    double totalSpent = 0.0;
    double thisMonthSpent = 0.0;
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    for (var expense in expenses) {
      totalSpent += expense.amount;

      if (expense.date.month == currentMonth && expense.date.year == currentYear) {
        thisMonthSpent += expense.amount;
      }
    }

    return {
      'totalSpent': totalSpent,
      'thisMonthSpent': thisMonthSpent,
    };
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        double totalSpent = 0.0;
        double thisMonthSpent = 0.0;
        bool isLoading = true;

        if (state is ExpenseLoaded) {
          final summaryData = _calculateSummary(state.expenses);
          totalSpent = summaryData['totalSpent']!;
          thisMonthSpent = summaryData['thisMonthSpent']!;
          isLoading = false;
        } else if (state is ExpenseLoading) {
          isLoading = true;
        } else if (state is ExpenseError) {
          totalSpent = 0.0;
          thisMonthSpent = 0.0;
          isLoading = false;
        }

        if (isLoading) {
          return const Row(
            children: [
              Expanded(
                child: SummaryCard.loading(title: "Total Spent"),
              ),
              SizedBox(width: 12),
              Expanded(
                child: SummaryCard.loading(title: "This Month"),
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: SummaryCard(
                title: "Total Spent",
                value: formatCurrency(totalSpent), 
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SummaryCard(
                title: "This Month",
                value: formatCurrency(thisMonthSpent),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isLoading;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    this.isLoading = false,
  });

  const SummaryCard.loading({
    super.key,
    required this.title,
  })  : value = '...',
        isLoading = true;

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
            isLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 80,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  )
                : Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
            const SizedBox(height: 12),
            isLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 120,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  )
                : Text(
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