import 'package:carcare/pages/home/car_component_card.dart';
import 'package:flutter/material.dart';

class SpecialisationsRow extends StatelessWidget {
  const SpecialisationsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CarComponentCard(
          title: 'Engine',
          icon: Icons.build,
          percentage: 25,
          description: 'Engine needs check-up',
        ),
        CarComponentCard(
          title: 'Accumulator',
          icon: Icons.battery_charging_full,
          percentage: 85,
          description: 'Check the battery regularly',
        ),
      ],
    );
  }
}
