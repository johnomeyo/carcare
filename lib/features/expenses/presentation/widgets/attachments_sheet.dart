import 'package:flutter/material.dart';

class AttachmentsSheet extends StatelessWidget {
  const AttachmentsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      builder: (context, controller) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            controller: controller,
            children: [
              Text("Attachments",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text("Add Receipt / Photo"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
