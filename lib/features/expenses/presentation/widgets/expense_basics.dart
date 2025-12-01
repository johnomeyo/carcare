import 'package:flutter/material.dart';

class ExpenseBasicsSheet extends StatelessWidget {
  const ExpenseBasicsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      builder: (context, controller) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: controller,
            children: [
              Text("Basics", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                  prefixIcon: Icon(Icons.money),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Date & Time",
                  prefixIcon: Icon(Icons.calendar_month),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Vehicle",
                  prefixIcon: Icon(Icons.directions_car),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
