import 'package:flutter/material.dart';

class CategorySpecificSheet extends StatelessWidget {
  const CategorySpecificSheet({super.key});

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
              Text("Category Details",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Detail 1",
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Detail 2",
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
