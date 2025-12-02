import 'package:carcare/features/expenses/dormain/entities/expense_entity.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_bloc.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_event.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_state.dart';
import 'package:carcare/utils/dialogs_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedCategory;
  String? _selectedPaymentMethod;

  final List<String> _categories = [
    'Fuel',
    'Maintenance & Repairs',
    'Car Insurance',
    'Parking Fees',
    'Car Wash',
    'Tolls & Highway Fees',
    'Car Loan Payment',
    'Registration & Licensing',
  ];
  final List<String> _paymentMethods = [
    'Cash',
    'Credit Card',
    'Debit Card',
    'Mobile Money',
    'Bank Transfer',
  ];

  @override
  void initState() {
    super.initState();
    _dateController.text = _formatDate(DateTime.now());
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  Future<void> _selectDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null) {
      setState(() {
        _dateController.text = _formatDate(selected);
      });
    }
  }

  void saveExpense() {
    if (_formKey.currentState!.validate()) {
      final expense = Expense(
        id: '',
        name: _nameController.text.trim(),
        category: _selectedCategory!,
        amount: double.parse(_amountController.text.trim()),
        date: DateTime.now(),
        location: _locationController.text.trim().isEmpty
            ? null
            : _locationController.text.trim(),
        paymentMethod: _selectedPaymentMethod,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        createdAt: DateTime.now(),
        updatedAt: null,
      );

      context.read<ExpenseBloc>().add(AddExpenseEvent(expense));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        if (state is ExpenseLoading) {
          DialogUtils.showLoadingDialog(context: context);
        }

        if (state is ExpenseLoaded) {
          Navigator.pop(context);
          DialogUtils.showSuccessDialog(
            context: context,
            title: 'Success',
            message: 'Expense added successfully!',
          );
          Navigator.pop(context);
        }

        if (state is ExpenseError) {
          Navigator.pop(context);
          DialogUtils.showErrorDialog(
            context: context,
            title: 'Error',
            message: state.message,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Expense')),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(25),
            children: [
              ExpenseTextField(
                label: 'Expense Name',
                controller: _nameController,
                hint: 'e.g., Lunch at restaurant',
                icon: Icons.receipt_long_outlined,
                isRequired: true,
              ),
              const SizedBox(height: 16),
              ExpenseDropdownField(
                label: 'Category',
                value: _selectedCategory,
                items: _categories,
                icon: Icons.category_outlined,
                hint: 'Select category',
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              ExpenseTextField(
                label: 'Amount',
                controller: _amountController,
                hint: '0.00',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                isRequired: true,
                prefix: 'KES ',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
              ),
              const SizedBox(height: 16),
              ExpenseDateField(
                label: 'Date',
                controller: _dateController,
                onTap: _selectDate,
              ),
              const SizedBox(height: 16),
              ExpenseTextField(
                label: 'Location',
                controller: _locationController,
                hint: 'e.g., Nairobi CBD',
                icon: Icons.location_on_outlined,
                isRequired: false,
              ),
              const SizedBox(height: 16),
              ExpenseDropdownField(
                label: 'Payment Method',
                value: _selectedPaymentMethod,
                items: _paymentMethods,
                icon: Icons.payment_outlined,
                hint: 'Select payment method',
                isRequired: false,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              ExpenseTextField(
                label: 'Notes',
                controller: _notesController,
                hint: 'Add any additional notes...',
                maxLines: 4,
                isRequired: false,
              ),
              const SizedBox(height: 32),
              SaveButton(onPressed: saveExpense),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpenseTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final IconData? icon;
  final TextInputType keyboardType;
  final bool isRequired;
  final int maxLines;
  final String? prefix;
  final List<TextInputFormatter>? inputFormatters;

  const ExpenseTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.isRequired = true,
    this.maxLines = 1,
    this.prefix,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          validator: (value) {
            if (isRequired && (value == null || value.trim().isEmpty)) {
              return '$label is required';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant.withValues(alpha: .6),
            ),
            prefixIcon: Icon(
              icon,
              color: colorScheme.onSurfaceVariant,
              size: 22,
            ),
            prefixText: prefix,
            prefixStyle: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: colorScheme.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: colorScheme.outline.withValues(alpha: 0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class ExpenseDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onTap;

  const ExpenseDateField({
    super.key,
    required this.label,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Date is required';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Select date',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant.withValues(alpha: .6),
            ),
            prefixIcon: Icon(
              Icons.calendar_today_outlined,
              color: colorScheme.onSurfaceVariant,
              size: 22,
            ),
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: colorScheme.onSurfaceVariant,
            ),
            filled: true,
            fillColor: colorScheme.surface,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: colorScheme.outline.withValues(alpha: 0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class ExpenseDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final IconData icon;
  final String hint;
  final bool isRequired;
  final ValueChanged<String?> onChanged;

  const ExpenseDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.icon,
    required this.hint,
    required this.onChanged,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          validator: (value) {
            if (isRequired && value == null) {
              return '$label is required';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant.withValues(alpha: .6),
            ),
            prefixIcon: Icon(
              icon,
              color: colorScheme.onSurfaceVariant,
              size: 22,
            ),
            filled: true,
            fillColor: colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: colorScheme.outline.withValues(alpha: 0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FilledButton(
      onPressed: onPressed,
      child: Text(
        'Add Expense',
        style: theme.textTheme.titleMedium?.copyWith(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
