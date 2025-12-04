import 'package:carcare/features/parking/dormain/entities/parking_spot_entity.dart';
import 'package:carcare/features/parking/presentation/bloc/parking_bloc.dart';
import 'package:carcare/features/parking/presentation/bloc/parking_state.dart';
import 'package:carcare/features/parking/presentation/bloc/parking_event.dart'; // <--- Import the event
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'parking_details_page.dart';

class ParkingHomePage extends StatefulWidget { 
  const ParkingHomePage({super.key});

  @override
  State<ParkingHomePage> createState() => _ParkingHomePageState();
}

class _ParkingHomePageState extends State<ParkingHomePage> { // <--- 2. Create State class

  @override
  void initState() {
    super.initState();
    // 🚀 Dispatch the event to load the parking spots when the widget is created
    context.read<ParkingBloc>().add(LoadParkingSpots());
  }
  
  // Note: The _parkingCard method can remain in the State class or be a separate function/widget
  Widget _parkingCard(BuildContext context, ParkingSpotEntity spot) {
    // ... (Your existing _parkingCard implementation)
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ParkingDetailsPage(spot: spot),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            // IMAGE OR ICON
            Container(
              height: 70,
              width: 70,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: spot.imageUrl.isNotEmpty
                  ? Image.network(spot.imageUrl, fit: BoxFit.cover)
                  : const Icon(Icons.local_parking, size: 32),
            ),
            const SizedBox(width: 16),

            // DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spot.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${spot.distance} • ${spot.isOpen24hrs ? "Open 24hrs" : "Timed"}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),

            // PRICE
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Ksh ${spot.hourlyRate.toStringAsFixed(0)}/hr",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  spot.availability,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: spot.availability == "Available"
                          ? Colors.green
                          : Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Parking"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Where do you want to park?",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: "Search location",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Nearby Parking",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<ParkingBloc, ParkingState>(
                builder: (context, state) {
                  if (state is ParkingLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ParkingError) {
                    return Center(child: Text("Error: ${state.message}"));
                  }

                  if (state is ParkingLoaded) {
                    final spots = state.spots; 

                    if (spots.isEmpty) {
                      return const Center(child: Text("No parking spots available"));
                    }

                    return ListView.separated(
                      itemCount: spots.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, index) {
                        final spot = spots[index];
                        return _parkingCard(context, spot);
                      },
                    );
                  }

                  return const Center(child: Text("Please search or wait..."));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}