class Expense {
  final String id;
  final String name;
  final String category;
  final double amount;
  final DateTime date;
  final String? location;
  final String? paymentMethod;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Expense({
    required this.id,
    required this.name,
    required this.category,
    required this.amount,
    required this.date,
    this.location,
    this.paymentMethod,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });
}
