import 'package:carcare/features/expenses/dormain/usecases/create_expense_usecase.dart';
import 'package:carcare/features/expenses/dormain/usecases/fetch_expenses.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'expense_event.dart';
import 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final CreateExpense createExpense;
  final FetchExpenses fetchExpenses;

  ExpenseBloc({
    required this.createExpense,
    required this.fetchExpenses,
  }) : super(ExpenseInitial()) {
    on<LoadExpenses>(_onLoadExpenses);
    on<AddExpenseEvent>(_onAddExpense);
  }

  Future<void> _onLoadExpenses(
      LoadExpenses event, Emitter<ExpenseState> emit) async {
    emit(ExpenseLoading());

    try {
      final data = await fetchExpenses();
      emit(ExpenseLoaded(data));
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }

  Future<void> _onAddExpense(
      AddExpenseEvent event, Emitter<ExpenseState> emit) async {
    try {
      await createExpense(event.expense);
      emit(ExpenseAdded());
    } catch (e) {
      emit(ExpenseError(e.toString()));
    }
  }
}
