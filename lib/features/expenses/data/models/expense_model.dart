class ExpenseModel {
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

  ExpenseModel({
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

  ExpenseModel copyWith({
    String? id,
    String? name,
    String? category,
    double? amount,
    DateTime? date,
    String? location,
    String? paymentMethod,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      location: location ?? this.location,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
      'location': location,
      'paymentMethod': paymentMethod,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      location: json['location'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  factory ExpenseModel.create({
    required String name,
    required String category,
    required double amount,
    required DateTime date,
    String? location,
    String? paymentMethod,
    String? notes,
  }) {
    final now = DateTime.now();
    return ExpenseModel(
      id: _generateId(),
      name: name,
      category: category,
      amount: amount,
      date: date,
      location: location,
      paymentMethod: paymentMethod,
      notes: notes,
      createdAt: now,
      updatedAt: null,
    );
  }

  static String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  @override
  String toString() {
    return 'ExpenseModel(id: $id, name: $name, category: $category, amount: $amount, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseModel &&
        other.id == id &&
        other.name == name &&
        other.category == category &&
        other.amount == amount &&
        other.date == date &&
        other.location == location &&
        other.paymentMethod == paymentMethod &&
        other.notes == notes &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      category,
      amount,
      date,
      location,
      paymentMethod,
      notes,
      createdAt,
      updatedAt,
    );
  }
}

extension ExpenseModelFormatting on ExpenseModel {
  String get formattedAmount => 'KES ${amount.toStringAsFixed(2)}';

  String get formattedDate {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  String get shortDate {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return "${date.day} ${months[date.month - 1]}";
  }
}
