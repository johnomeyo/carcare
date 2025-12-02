import 'package:carcare/features/expenses/dormain/entities/expense_entity.dart';

abstract class ExpenseRepository {
  Future<void> createExpense(Expense expense);
  Future<List<Expense>> fetchExpenses();
}
