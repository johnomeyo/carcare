import 'package:carcare/features/expenses/data/data_source/expense_datasource.dart';
import 'package:carcare/features/expenses/data/repositories/expense_repo_impl.dart';
import 'package:carcare/features/expenses/dormain/usecases/create_expense_usecase.dart';
import 'package:carcare/features/expenses/dormain/usecases/fetch_expenses.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
// ----EXPENSES

  // Datasources
  sl.registerLazySingleton<ExpenseDatasource>(() => ExpenseDatasource());

  // Repositories
  sl.registerLazySingleton<ExpenseRepositoryImpl>(
      () => ExpenseRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton<CreateExpense>(() => CreateExpense(sl()));
  sl.registerLazySingleton<FetchExpenses>(() => FetchExpenses(sl()));

  // Blocs
  sl.registerFactory<ExpenseBloc>(() => ExpenseBloc(
        createExpense: sl(),
        fetchExpenses: sl(),
      ));
}