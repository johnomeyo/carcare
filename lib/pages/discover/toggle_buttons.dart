import 'package:flutter/material.dart';

class ServiceToggleButton extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const ServiceToggleButton({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  ServiceToggleButtonState createState() => ServiceToggleButtonState();
}

class ServiceToggleButtonState extends State<ServiceToggleButton> {
  final List<String> services = [
    "All",
    "Oil Change",
    "Engine Check",
    "Tire Replacement",
    "Brake Inspection",
    "Battery Service",
    "Car Wash",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(services.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(services[index]),
                selected: widget.selectedIndex == index,
                onSelected: (bool selected) {
                  widget.onSelected(index);
                },
                selectedColor: theme.colorScheme.primary,
                backgroundColor: theme.colorScheme.surface,
                labelStyle: TextStyle(
                  color: widget.selectedIndex == index
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurface,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
