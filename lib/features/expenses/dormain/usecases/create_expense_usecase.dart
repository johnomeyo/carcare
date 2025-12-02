import 'package:carcare/features/expenses/dormain/entities/expense_entity.dart';
import 'package:carcare/features/expenses/dormain/repository/expense_repo.dart';

class CreateExpense {
  final ExpenseRepository repository;
  CreateExpense(this.repository);

  Future<void> call(Expense expense) {
    return repository.createExpense(expense);
  }
}
