import 'package:flutter/material.dart';

class PopularServicesSection extends StatelessWidget {
  const PopularServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Popular Services",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildServiceCard(context, "Engine Check",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxjg7yRu10oXeSc9RKhdXjbmbGOAw0I3YAFA&s"),
              _buildServiceCard(context, "Oil Change",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThJAjNCxev-7icPJ5fKfkPgV-JIW2_V0ZNmw&s"),
              _buildServiceCard(context, "Brake Inspection",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGAix9IyMmxtzR9_myR1FVq0vOCIWh0FQYjQ&s"),
              _buildServiceCard(context, "Tire Replacement",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHvglFqKhsovzoqCRNsl04PUCIiUjSc0I0jA&s"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(
      BuildContext context, String serviceName, String imagePath) {
    final theme = Theme.of(context);
    // final size = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imagePath, height: 70, fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            Text(
              serviceName,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
