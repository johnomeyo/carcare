import 'package:carcare/features/car_wash/presentation/pages/car_wash_locator_page.dart';
import 'package:carcare/features/inspection/presentation/inspection_page.dart';
import 'package:carcare/pages/home/presentation/pages/add_car_page.dart';
import 'package:carcare/pages/home/service_category.dart';
import 'package:carcare/utils/dialogs_utils.dart';
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
            onTap: () {
              DialogUtils.showConfirmDialog(
                context: context,
                title: "Unavailable",
                message: "This feature is coming soon!",
              );
            },
          ),
          const SizedBox(width: 16),

          /// PARKING
          ServiceCategory(
            title: 'Parking',
            icon: Icons.ac_unit,
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 500),
                  reverseDuration: const Duration(milliseconds: 500),
                  type: PageTransitionType.scale,
                  alignment: Alignment.centerRight,
                  child: const ParkingHomePage(),
                ),
              );
            },
          ),
          const SizedBox(width: 16),

          /// INSPECTION
          ServiceCategory(
            title: 'Inspection',
            icon: Icons.settings,
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 500),
                  reverseDuration: const Duration(milliseconds: 500),
                  type: PageTransitionType.scale,
                  alignment: Alignment.centerRight,
                  child: const InspectionPage(),
                ),
              );
            },
          ),
          const SizedBox(width: 16),

          /// ADD CAR
          ServiceCategory(
            title: 'Add Car',
            icon: Icons.car_rental,
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 500),
                  reverseDuration: const Duration(milliseconds: 500),
                  type: PageTransitionType.scale,
                  alignment: Alignment.centerRight,
                  child: const VehicleOnboardingPage(),
                ),
              );
            },
          ),
          const SizedBox(width: 16),

          /// CAR WASH
          ServiceCategory(
            title: 'Car Wash',
            icon: Icons.local_car_wash,
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 500),
                  reverseDuration: const Duration(milliseconds: 500),
                  type: PageTransitionType.scale,
                  alignment: Alignment.centerRight,
                  child: const CarwashLocatorPage(),
                ),
              );
            },
          ),
          const SizedBox(width: 16),

          /// TIRE CHECK
          ServiceCategory(
            title: 'Tire Check',
            icon: Icons.tire_repair,
            onTap: () {
              DialogUtils.showConfirmDialog(
                context: context,
                title: "Unavailable",
                message: "This feature is coming soon!",
              );
            },
          ),
          const SizedBox(width: 16),

          /// BATTERY
          ServiceCategory(
            title: 'Battery',
            icon: Icons.battery_charging_full,
            onTap: () {
              DialogUtils.showConfirmDialog(
                context: context,
                title: "Unavailable",
                message: "This feature is coming soon!",
              );
            },
          ),
        ],
      ),
    );
  }
}
