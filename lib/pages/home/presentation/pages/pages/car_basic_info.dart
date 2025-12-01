import 'package:flutter/material.dart';

class AddCarBasicInfo extends StatefulWidget {
  final VoidCallback onNext;
  final Function(Map<String, String>) onDataReceived;

  const AddCarBasicInfo({
    super.key,
    required this.onNext,
    required this.onDataReceived,
  });

  @override
  State<AddCarBasicInfo> createState() => AddCarBasicInfoState();
}

class AddCarBasicInfoState extends State<AddCarBasicInfo> {
  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final makeCtrl = TextEditingController();
  final modelCtrl = TextEditingController();
  final yearCtrl = TextEditingController();
  final plateCtrl = TextEditingController();
  final colorCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Car Name"),
              validator: (v) => v!.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: makeCtrl,
              decoration: const InputDecoration(labelText: "Make (Toyota)"),
              validator: (v) => v!.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: modelCtrl,
              decoration: const InputDecoration(labelText: "Model (Axio)"),
              validator: (v) => v!.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: yearCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Year"),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: plateCtrl,
              decoration: const InputDecoration(labelText: "Plate Number"),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: colorCtrl,
              decoration: const InputDecoration(labelText: "Color"),
            ),
            const SizedBox(height: 24),
            FilledButton(
              child: const Text("Next"),
              onPressed: () {
                if (!formKey.currentState!.validate()) return;

                widget.onDataReceived({
                  "name": nameCtrl.text.trim(),
                  "make": makeCtrl.text.trim(),
                  "model": modelCtrl.text.trim(),
                  "year": yearCtrl.text.trim(),
                  "plate": plateCtrl.text.trim(),
                  "color": colorCtrl.text.trim(),
                });

                widget.onNext();
              },
            )
          ],
        ),
      ),
    );
  }
}
