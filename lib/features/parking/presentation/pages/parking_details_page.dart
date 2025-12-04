import 'dart:async';
import 'package:carcare/features/parking/dormain/entities/parking_spot_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingDetailsPage extends StatefulWidget {
  final ParkingSpotEntity spot;

  const ParkingDetailsPage({super.key, required this.spot});

  @override
  State<ParkingDetailsPage> createState() => _ParkingDetailsPageState();
}

class _ParkingDetailsPageState extends State<ParkingDetailsPage> {
  bool isNavigating = false;
  bool isParkingStarted = false;
  Duration parkingDuration = Duration.zero;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startParking() {
    setState(() {
      isParkingStarted = true;
      parkingDuration = Duration.zero;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        parkingDuration = Duration(seconds: parkingDuration.inSeconds + 1);
      });
    });
  }

  void stopParking() {
    timer?.cancel();
    setState(() {
      isParkingStarted = false;
      parkingDuration = Duration.zero;
    });
  }

  double calculateCurrentPrice() {
    final hours = parkingDuration.inSeconds / 3600;
    return hours * widget.spot.hourlyRate;
  }

  @override
  Widget build(BuildContext context) {
    final spot = widget.spot;

    return Scaffold(
      appBar: AppBar(
        title: Text(spot.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ParkingHeader(
            name: spot.name,
            address: spot.address,
            distance: spot.distance,
          ),

          const SizedBox(height: 16),

          // STATIC MAP IMAGE (Placeholder)
          Container(
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(spot.imageUrl.isNotEmpty
                    ? spot.imageUrl
                    : "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/World_map_blank_without_borders.svg/2560px-World_map_blank_without_borders.svg.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
          ),

          const SizedBox(height: 16),

          ParkingPriceCard(
            hourlyRate: spot.hourlyRate,
            currentPrice: calculateCurrentPrice(),
            isParkingStarted: isParkingStarted,
            parkingDuration: parkingDuration,
          ),

          const SizedBox(height: 24),

          ParkingActionButtons(
            isNavigating: isNavigating,
            isParkingStarted: isParkingStarted,
            onNavigate: () {
              setState(() => isNavigating = true);
              // TODO: Add Google Maps navigation
            },
            onStartParking: startParking,
            onStopParking: stopParking,
          ),
        ],
      ),
    );
  }
}

class ParkingHeader extends StatelessWidget {
  final String name;
  final String address;
  final String distance;

  const ParkingHeader({
    super.key,
    required this.name,
    required this.address,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "$address • $distance",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class ParkingMapView extends StatefulWidget {
  final LatLng parkingLocation;
  final bool isNavigating;

  const ParkingMapView({
    super.key,
    required this.parkingLocation,
    required this.isNavigating,
  });

  @override
  State<ParkingMapView> createState() => _ParkingMapViewState();
}

class _ParkingMapViewState extends State<ParkingMapView> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    markers.add(
      Marker(
        markerId: const MarkerId('parking_spot'),
        position: widget.parkingLocation,
        infoWindow: const InfoWindow(title: 'Central Mall Parking'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      clipBehavior: Clip.antiAlias,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.parkingLocation,
          zoom: 15,
        ),
        markers: markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
    );
  }
}

class ParkingPriceCard extends StatelessWidget {
  final double hourlyRate;
  final double currentPrice;
  final bool isParkingStarted;
  final Duration parkingDuration;

  const ParkingPriceCard({
    super.key,
    required this.hourlyRate,
    required this.currentPrice,
    required this.isParkingStarted,
    required this.parkingDuration,
  });

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hourly Rate",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Ksh ${hourlyRate.toStringAsFixed(0)}/hr",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Availability",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Available",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (isParkingStarted) ...[
                const Divider(height: 32),
                ParkingTimer(
                  duration: parkingDuration,
                  currentPrice: currentPrice,
                ),
              ],
            ],
          ),
        ));
  }
}

class ParkingTimer extends StatelessWidget {
  final Duration duration;
  final double currentPrice;

  const ParkingTimer({
    super.key,
    required this.duration,
    required this.currentPrice,
  });

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Parking Duration",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            Text(
              formatDuration(duration),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Current Cost",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            Text(
              "Ksh ${currentPrice.toStringAsFixed(2)}",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ParkingActionButtons extends StatelessWidget {
  final bool isNavigating;
  final bool isParkingStarted;
  final VoidCallback onNavigate;
  final VoidCallback onStartParking;
  final VoidCallback onStopParking;

  const ParkingActionButtons({
    super.key,
    required this.isNavigating,
    required this.isParkingStarted,
    required this.onNavigate,
    required this.onStartParking,
    required this.onStopParking,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isNavigating)
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onNavigate,
              icon: const Icon(Icons.navigation),
              label: const Text("Navigate to Parking"),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        if (isNavigating && !isParkingStarted) ...[
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onStartParking,
              icon: const Icon(Icons.play_arrow),
              label: const Text("Start Parking Timer"),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ],
        if (isParkingStarted) ...[
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onStopParking,
              icon: const Icon(Icons.stop),
              label: const Text("End Parking Session"),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.red,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
