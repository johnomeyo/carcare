import 'package:flutter/material.dart';
import '../models/car_model.dart';
import 'car_details_card.dart';

class UserCarsCarousel extends StatelessWidget {
  final List<Car> cars;
  final VoidCallback onAddCarPressed;

  const UserCarsCarousel({
    super.key,
    required this.cars,
    required this.onAddCarPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.primary;

    if (cars.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accentColor.withValues(alpha: 0.1), width: 1),
        ),
        child: Column(
          children: [
            Icon(Icons.directions_car_filled_outlined, size: 48, color: accentColor),
            const SizedBox(height: 16),
            Text(
              "No Cars Added",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Please add your vehicle details to get personalized car care services.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200, 
              child: FilledButton(
                onPressed: onAddCarPressed,
                child:const Text("Add Your First Car"),
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 200, 
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9), 
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped on ${car.carName}!'))
              );
            },
            child: CarDetailsCard(
              carName: car.carName,
              plateNumber: car.plateNumber,
              nextService: car.nextService,
              imageUrl: car.imageUrl,
            ),
          );
        },
      ),
    );
  }
}