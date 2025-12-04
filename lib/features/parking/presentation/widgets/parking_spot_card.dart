import 'package:carcare/features/parking/dormain/entities/parking_spot_entity.dart';
import 'package:carcare/features/parking/presentation/pages/parking_details_page.dart';
import 'package:flutter/material.dart';

class ParkingSpotCard extends StatelessWidget {
  final ParkingSpotEntity spot;

  const ParkingSpotCard({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAvailable = spot.availability == "Available";

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
          color: theme.cardColor,
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
            Container(
              height: 70,
              width: 70,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: spot.imageUrl.isNotEmpty
                  ? Image.network(
                      spot.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.image_not_supported, size: 32, color: Colors.grey),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Icon(Icons.local_parking, size: 32, color: Colors.black54),
                    ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spot.name,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${spot.distance} • ${spot.isOpen24hrs ? "Open 24hrs" : "Timed"}",
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Ksh ${spot.hourlyRate.toStringAsFixed(0)}/hr",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  spot.availability,
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: isAvailable ? Colors.green : Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}