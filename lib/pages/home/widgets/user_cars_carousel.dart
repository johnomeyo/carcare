import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
// Import Bloc-related packages and necessary files
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carcare/pages/home/presentation/features/add_car/data/bloc/vehicle_bloc.dart'; 
import 'package:carcare/pages/home/presentation/features/add_car/domain/entities/vehicle_entity.dart'; // Using the Entity
// Assuming Car and CarDetailsCard are local imports
import 'car_details_card.dart';

class UserCarsCarousel extends StatefulWidget {
  final VoidCallback onAddCarPressed;

  const UserCarsCarousel({
    super.key,
    required this.onAddCarPressed,
  });
  
  @override
  State<UserCarsCarousel> createState() => _UserCarsCarouselState();
}

class _UserCarsCarouselState extends State<UserCarsCarousel> {
  
  @override
  void initState() {
    super.initState();
    context.read<VehicleBloc>().add(FetchVehiclesEvent());
  }

  @override
  Widget build(BuildContext context) {
    // We only need the VoidCallback from the stateful widget now
    final onAddCarPressed = widget.onAddCarPressed; 
    
    // ⭐ 2. Use BlocBuilder to react to state changes in the VehicleBloc
    return BlocBuilder<VehicleBloc, VehicleState>(
      builder: (context, state) {
        
        // --- A. Loading State ---
        if (state is VehicleLoading) {
          // You might only want a small indicator if the loading is for the carousel
          return const Center(child: CircularProgressIndicator()); 
        }

        // --- B. Error State ---
        if (state is VehicleFailure) {
          return Center(
            child: Text(
              'Error loading vehicles: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // --- C. Loaded State ---
        if (state is VehiclesLoaded) {
          // Note: You might need a helper function to convert VehicleEntity to Car
          final List<Car> cars = state.vehicles.map((entity) => 
            // ⚠️ Assuming you have a way to convert VehicleEntity to your Car model
            _mapEntityToCar(entity) 
          ).toList();

          if (cars.isEmpty) {
            // Display the 'No Cars Added' screen
            return _buildEmptyState(context, onAddCarPressed); 
          }
          
          // Display the Carousel
          return _buildCarousel(context, cars);
        }

        return _buildEmptyState(context, onAddCarPressed); 
      },
    );
  }

  // Helper method for the empty state UI
  Widget _buildEmptyState(BuildContext context, VoidCallback onAddCarPressed) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.primary;
    
    return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accentColor.withOpacity(0.1), width: 1), 
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
                child: const Text("Add Your First Car"),
              ),
            ),
          ],
        ),
      );
  }

  // Helper method for the carousel UI
  Widget _buildCarousel(BuildContext context, List<Car> cars) {
    return CarouselSlider.builder(
      itemCount: cars.length,
      itemBuilder: (context, index, realIndex) {
        final car = cars[index];
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tapped on ${car.carName}!'))
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0), 
                child: CarDetailsCard(
                  carName: car.carName,
                  plateNumber: car.plateNumber,
                  nextService: car.nextService,
                  imageUrl: car.imageUrl,
                ),
              ),
            );
          },
        );
      },

      options: CarouselOptions(
        height: 200, 
        viewportFraction: 1, 
        enlargeCenterPage: true, 
        enableInfiniteScroll: true,
        initialPage: 0,
        scrollDirection: Axis.horizontal,
        autoPlay: true,
      ),
    );
  }
  
  // ⚠️ TEMPORARY MAPPING FUNCTION: 
  // You need to ensure your Car model can accept data from VehicleEntity.
  Car _mapEntityToCar(VehicleEntity entity) {
    // This mapping is necessary because CarDetailsCard expects a Car object, 
    // but the Bloc returns a VehicleEntity. Adjust this based on your actual Car model fields.
    return Car(
      carName: '${entity.make} (${entity.registrationNumber})',
      plateNumber: entity.registrationNumber,
      // You'll need to calculate or fetch nextService date/mileage
      nextService: 'N/A', 
      imageUrl: "", 
    );
  }
}

// NOTE: You'll also need to update the definition of the Car model 
// if you haven't already included the fields from VehicleEntity.
class Car {
  final String carName;
  final String plateNumber;
  final String nextService;
  final String imageUrl;

  Car({
    required this.carName,
    required this.plateNumber,
    required this.nextService,
    required this.imageUrl,
  });
}