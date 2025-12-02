import 'package:carcare/features/expenses/data/models/expense_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseDatasource {
  Future<void> createExpense(ExpenseModel expenseModel) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .add(expenseModel.toJson());
  }
}

Future<List<ExpenseModel>> fetchExpenses() async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('expenses')
      .get();

  return querySnapshot.docs.map((doc) {
    final data = doc.data();
    return ExpenseModel(
      id: doc.id,
      name: data['name'],
      category: data['category'],
      amount: data['amount'],
      date: DateTime.parse(data['date']),
      location: data['location'],
      paymentMethod: data['paymentMethod'],
      notes: data['notes'],
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt:
          data['updatedAt'] != null ? DateTime.parse(data['updatedAt']) : null,
    );
  }).toList();
}
