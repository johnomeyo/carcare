import 'package:carcare/features/car_wash/presentation/pages/car_wash_locator_page.dart';
import 'package:carcare/features/inspection/presentation/inspection_page.dart';
import 'package:carcare/pages/home/service_category.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../features/parking/presentation/pages/parking_homepage.dart';

class ServiceCategoryRow extends StatelessWidget {
  const ServiceCategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ServiceCategory(
            title: 'Add Expense',
            icon: Icons.receipt_long,
            onTap: () {},
          ),
          const SizedBox(width: 16),
          ServiceCategory(
            title: 'Parking',
            icon: Icons.ac_unit,
            onTap: () {
              context.pushTransition(
                type: PageTransitionType.rightToLeft,
                child: const ParkingHomePage(),
              );
            }
            ,
          ),
          const SizedBox(width: 16),
          ServiceCategory(
            title: 'Inspection',
            icon: Icons.settings,
            onTap: () {
              context.pushTransition(
                type: PageTransitionType.rightToLeft,
                child: const InspectionPage(),
              );
            },
          ),
          const SizedBox(width: 16),
          ServiceCategory(
            title: 'Repair',
            icon: Icons.car_repair,
            onTap: () {},
          ),
          const SizedBox(width: 16),
          ServiceCategory(
            title: 'Car Wash',
            icon: Icons.local_car_wash,
            onTap: () {
                            context.pushTransition(
                type: PageTransitionType.rightToLeft,
                child: const CarwashLocatorPage(),
              );
            },
          ),
          const SizedBox(width: 16),
          ServiceCategory(
            title: 'Tire Check',
            icon: Icons.tire_repair,
            onTap: () {},
          ),
          const SizedBox(width: 16),
          ServiceCategory(
            title: 'Battery',
            icon: Icons.battery_charging_full,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
