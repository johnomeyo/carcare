import 'package:carcare/features/expenses/data/models/expense_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseDatasource {
  Future<void> createExpense(ExpenseModel model) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .add(model.toJson());
  }

  Future<List<ExpenseModel>> fetchExpenses() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('expenses')
        .get();

    return snapshot.docs
        .map((doc) => ExpenseModel.fromJson(doc.data(), doc.id))
        .toList();
  }
}
