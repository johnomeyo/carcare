
import 'package:carcare/features/expenses/data/data_source/expense_datasource.dart';
import 'package:carcare/features/expenses/dormain/entities/expense_entity.dart';
import 'package:carcare/features/expenses/dormain/repository/expense_repo.dart';

import '../models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseDatasource datasource;

  ExpenseRepositoryImpl(this.datasource);

  @override
  Future<void> createExpense(Expense expense) {
    final model = ExpenseModel(
      id: expense.id,
      name: expense.name,
      category: expense.category,
      amount: expense.amount,
      date: expense.date,
      location: expense.location,
      paymentMethod: expense.paymentMethod,
      notes: expense.notes,
      createdAt: expense.createdAt,
      updatedAt: expense.updatedAt,
    );

    return datasource.createExpense(model);
  }

  @override
  Future<List<Expense>> fetchExpenses() async {
    return await datasource.fetchExpenses();
  }
}
