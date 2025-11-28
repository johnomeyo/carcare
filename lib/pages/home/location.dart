import 'package:flutter/material.dart';

class LocationIndicator extends StatelessWidget {
  final String? currentLocation;
  const LocationIndicator({super.key, this.currentLocation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Location",
          style: TextStyle(color: Colors.grey),
        ),
        Row(
          children: [
            const Icon(Icons.location_pin, size: 15,),
            const SizedBox(
              width: 10,
            ),
            Text(currentLocation ?? "Loading..."),
          ],
        ),
      ],
    );
  }
}
