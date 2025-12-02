import 'package:carcare/features/expenses/dormain/entities/expense_entity.dart';
import 'package:carcare/features/expenses/dormain/repository/expense_repo.dart';

class FetchExpenses {
  final ExpenseRepository repository;
  FetchExpenses(this.repository);

  Future<List<Expense>> call() {
    return repository.fetchExpenses();
  }
}
