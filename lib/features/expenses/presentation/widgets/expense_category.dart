import 'package:flutter/material.dart';

class ExpenseCategorySheet extends StatelessWidget {
  const ExpenseCategorySheet({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      "Fuel",
      "Service",
      "Repair",
      "Car Wash",
      "Parking",
      "Insurance",
      "Toll",
      "Other",
    ];

    return DraggableScrollableSheet(
      expand: false,
      builder: (context, controller) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            controller: controller,
            itemCount: categories.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(categories[index]),
                onTap: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}
