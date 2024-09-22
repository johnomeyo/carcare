import 'package:flutter/material.dart';
import 'service_category.dart';

class ServiceCategoryRow extends StatelessWidget {
  const ServiceCategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ServiceCategory(
          title: 'Oil Change',
          icon: Icons.oil_barrel,
          onTap: () {
            // Handle oil change tap
          },
        ),
        ServiceCategory(
          title: 'AC Service',
          icon: Icons.ac_unit,
          onTap: () {
            // Handle AC service tap
          },
        ),
        ServiceCategory(
          title: 'Inspection',
          icon: Icons.settings,
          onTap: () {
            // Handle inspection tap
          },
        ),
        // ServiceCategory(
        //   title: 'Repair',
        //   icon: Icons.car_repair,
        //   onTap: () {
        //     // Handle repair tap
        //   },
        // ),
        ServiceCategory(
          title: 'Car Care',
          icon: Icons.local_car_wash,
          onTap: () {
            // Handle car care tap
          },
        ),
      ],
    );
  }
}
