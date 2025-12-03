import 'package:carcare/features/expenses/dormain/entities/expense_entity.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_bloc.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_event.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_state.dart';
import 'package:carcare/pages/chat/presentation/widgets/empty_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ExpenseChartsSection extends StatefulWidget {
  const ExpenseChartsSection({super.key});

  @override
  State<ExpenseChartsSection> createState() => _ExpenseChartsSectionState();
}

class _ExpenseChartsSectionState extends State<ExpenseChartsSection> {
  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(LoadExpenses());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if (state is ExpenseLoading) {
          return const Column(
            children: [
              ChartShimmer(),
              SizedBox(height: 16),
              ChartShimmer(),
            ],
          );
        }

        if (state is ExpenseError) {
          return SizedBox(
            height: 200,
            child:
                Center(child: Text('Error loading charts: ${state.message}')),
          );
        }

        if (state is ExpenseLoaded) {
          final List<Expense> expenses = state.expenses;
          if (expenses.isEmpty) {
            return const Center(child: EmptyState(imagePath: 'lib/assets/bot.png', title: "Ooops", description: "No expense data available to display charts."));
          }

          return Column(
            children: [
              MonthlySpendingChart(expenses: expenses),
              const SizedBox(height: 16),
              CategoryDistributionChart(expenses: expenses),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class MonthlySpendingChart extends StatelessWidget {
  final List<Expense> expenses;
  const MonthlySpendingChart({super.key, required this.expenses});

  Map<int, double> aggregateMonthlySpending() {
    final Map<int, double> monthlyTotals = {};
    for (var expense in expenses) {
      final month = expense.date.month;
      monthlyTotals.update(
        month,
        (existingTotal) => existingTotal + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }
    return monthlyTotals;
  }

  @override
  Widget build(BuildContext context) {
    final monthlyData = aggregateMonthlySpending();
    final List<FlSpot> spots = [];

    final now = DateTime.now();
    final monthKeys = monthlyData.keys.toList()..sort();

    for (int i = 0; i < monthKeys.length; i++) {
      final month = monthKeys[i];
      spots.add(FlSpot(i.toDouble(), monthlyData[month]!));
    }

    final maxY = monthlyData.values.isEmpty
        ? 1000.0
        : monthlyData.values.reduce((a, b) => a > b ? a : b) * 1.2;

    final List<String> displayedMonths = monthKeys
        .map((m) => DateFormat.MMM().format(DateTime(now.year, m)))
        .toList();

    return Card(
      child: Container(
        height: 220,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Monthly Spending",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < displayedMonths.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                displayedMonths[index],
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.1),
                      ),
                    ),
                  ],
                  minY: 0,
                  maxY: maxY,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryDistributionChart extends StatelessWidget {
  final List<Expense> expenses;
  const CategoryDistributionChart({super.key, required this.expenses});

  Map<String, double> aggregateCategorySpending() {
    final Map<String, double> categoryTotals = {};
    for (var expense in expenses) {
      categoryTotals.update(
        expense.category,
        (existingTotal) => existingTotal + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }
    return categoryTotals;
  }

  final Map<String, Color> categoryColors = const {
    'Fuel': Colors.blue,
    'Maintenance & Repairs': Colors.red,
    'Car Insurance': Colors.orange,
    'Parking Fees': Colors.purple,
    'Car Wash': Colors.teal,
    'Tolls & Highway Fees': Colors.cyan,
    'Car Loan Payment': Colors.pink,
    'Registration & Licensing': Colors.brown,
  };

  @override
  Widget build(BuildContext context) {
    final categoryTotals = aggregateCategorySpending();
    final totalSpending =
        categoryTotals.values.fold(0.0, (sum, item) => sum + item);

    final List<PieChartSectionData> sections = [];
    final List<Widget> legendItems = [];

    categoryTotals.forEach((category, amount) {
      final percentage = (amount / totalSpending) * 100;
      final color = categoryColors[category] ?? Colors.grey;

      sections.add(
        PieChartSectionData(
          value: amount,
          title: '${percentage.toStringAsFixed(0)}%',
          color: color,
          radius: 50,
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );

      legendItems.add(_buildLegendItem(color, category, amount));
      legendItems.add(const SizedBox(height: 8));
    });

    return Card(
      child: Container(
        height: 220,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: PieChart(
                      PieChartData(
                        sections: sections,
                        sectionsSpace: 2,
                        centerSpaceRadius: 35,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: legendItems,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, double amount) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            '$label (${amount.toStringAsFixed(0)})',
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}


class ChartShimmer extends StatelessWidget {
  const ChartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final baseColor = isDark 
        ? theme.colorScheme.surfaceContainerHighest 
        : Colors.grey.shade300;
    final highlightColor = isDark 
        ? theme.colorScheme.surface 
        : Colors.grey.shade100;

    return Card(
      child: Container(
        height: 220,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                width: 120,
                height: 16,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Shimmer.fromColors(
                baseColor: baseColor,
                highlightColor: highlightColor,
                child: Container(
                  decoration: BoxDecoration(
                    color: baseColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}