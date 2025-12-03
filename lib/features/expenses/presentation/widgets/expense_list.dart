import 'package:carcare/features/expenses/dormain/entities/expense_entity.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_bloc.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_event.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_state.dart';
import 'package:carcare/pages/chat/presentation/widgets/empty_state.dart';
import 'package:carcare/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseListSection extends StatefulWidget {
  const ExpenseListSection({super.key});

  @override
  State<ExpenseListSection> createState() => _ExpenseListSectionState();
}

class _ExpenseListSectionState extends State<ExpenseListSection> {
  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(LoadExpenses());
  }

  Map<String, dynamic> _getCategoryVisuals(String category) {
    switch (category) {
      case 'Fuel':
      case 'Transport':
        return {'icon': Icons.directions_car, 'color': Colors.green};
      case 'Maintenance & Repairs':
        return {'icon': Icons.build, 'color': Colors.red};
      case 'Car Insurance':
      case 'Registration & Licensing':
        return {'icon': Icons.policy, 'color': Colors.orange};
      default:
        return {'icon': Icons.attach_money, 'color': Colors.grey};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "All Expenses",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            if (state is ExpenseLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ExpenseError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Failed to load expenses: ${state.message}'),
                ),
              );
            }

            if (state is ExpenseLoaded) {
              final List<Expense> expenses = state.expenses;

              if (expenses.isEmpty) {
            return const Center(child: EmptyState(imagePath: 'lib/assets/bot.png', title: "Empty ", description: "No expense data available to display charts."));

              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  final visuals = _getCategoryVisuals(expense.category);

                  return ExpenseListItem(
                    name: expense.name,
                    category: expense.category,
                    date: _formatDate(expense.date),
                    amount: expense.amount,
                    icon: visuals['icon'] as IconData,
                    color: visuals['color'] as Color,
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

String _formatDate(DateTime date) {
  return "${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}";
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
        backgroundColor: color.withValues(alpha: .1),
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
        formatCurrency(amount),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
