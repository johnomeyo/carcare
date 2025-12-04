import 'package:carcare/features/expenses/data/data_source/expense_datasource.dart';
import 'package:carcare/features/expenses/data/repositories/expense_repo_impl.dart';
import 'package:carcare/features/expenses/dormain/repository/expense_repo.dart';
import 'package:carcare/features/expenses/dormain/usecases/create_expense_usecase.dart';
import 'package:carcare/features/expenses/dormain/usecases/fetch_expenses.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_bloc.dart';
import 'package:carcare/features/parking/data/parking_data_source.dart';
import 'package:carcare/features/parking/data/repo/parking_repo_impl.dart';
import 'package:carcare/features/parking/dormain/repositories/parking_repo.dart';
import 'package:carcare/features/parking/dormain/usecases/fetch_spots_usecase.dart';
import 'package:carcare/features/parking/presentation/bloc/parking_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
// ----EXPENSES

  // Datasources
  sl.registerLazySingleton<ExpenseDatasource>(() => ExpenseDatasource());

  // Repositories
  sl.registerLazySingleton<ExpenseRepository>(
      () => ExpenseRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton<CreateExpense>(() => CreateExpense(sl()));
  sl.registerLazySingleton<FetchExpenses>(() => FetchExpenses(sl()));

  // Blocs
  sl.registerFactory<ExpenseBloc>(() => ExpenseBloc(
        createExpense: sl(),
        fetchExpenses: sl(),
      ));

        // -------------------------------
  // PARKING MODULE
  // -------------------------------

  // Firebase Firestore
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Datasource
  sl.registerLazySingleton<ParkingRemoteDataSource>(
      () => ParkingRemoteDataSourceImpl(sl()));

  // Repository
  sl.registerLazySingleton<ParkingRepository>(
      () => ParkingRepositoryImpl(sl()));

  // Usecase (Stream)
  sl.registerLazySingleton<GetParkingSpotsStream>(
      () => GetParkingSpotsStream(sl()));

  // Bloc
  sl.registerFactory<ParkingBloc>(
      () => ParkingBloc(sl()));
}