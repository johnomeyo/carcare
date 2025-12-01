import 'dart:io';
import 'package:carcare/pages/home/models/vehicle_data_model.dart';
import 'package:flutter/material.dart';

class VehicleVerifyPage extends StatelessWidget {
  final VehicleData data;
  final VoidCallback onEditPressed;

  const VehicleVerifyPage({
    super.key,
    required this.data,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Review Application',
            subtitle: 'Please verify the information below before submitting.',
          ),
          const SizedBox(height: 32),
          
          const SectionHeader(
            title: 'Vehicle Specifications',
            icon: Icons.directions_car_outlined,
          ),
          const SizedBox(height: 12),
          VehicleSpecsCard(data: data),
          
          const SizedBox(height: 32),
          
          const SectionHeader(
            title: 'Documents',
            icon: Icons.description_outlined,
          ),
          const SizedBox(height: 12),
          DocumentsCard(data: data),
          
          const SizedBox(height: 32),
          
          const SectionHeader(
            title: 'Vehicle Photos',
            icon: Icons.photo_library_outlined,
          ),
          const SizedBox(height: 12),
          VehiclePhotosGrid(photoPaths: data.photoPaths),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const PageHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionHeader({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 18,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}

class VehicleSpecsCard extends StatelessWidget {
  final VehicleData data;

  const VehicleSpecsCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: .5),
        ),
      ),
      child: Column(
        children: [
          InfoRow(label: 'Registration', value: data.registrationNumber ?? '-'),
          const InfoDivider(),
          InfoRow(label: 'Make', value: data.make ?? '-'),
          const InfoDivider(),
          InfoRow(label: 'Year', value: data.yearOfManufacture ?? '-'),
          const InfoDivider(),
          InfoRow(label: 'Color', value: data.color ?? '-'),
          const InfoDivider(),
          InfoRow(label: 'Transmission', value: data.transmission ?? '-'),
          const InfoDivider(),
          InfoRow(label: 'Steering', value: data.steering ?? '-'),
          const InfoDivider(),
          InfoRow(label: 'Engine Size', value: '${data.engineSize ?? '-'} cc'),
          const InfoDivider(),
          InfoRow(label: 'Fuel Type', value: data.powerFuel ?? '-'),
          const InfoDivider(),
          InfoRow(label: 'Mileage', value: '${data.mileage ?? '-'} km'),
          const InfoDivider(),
          InfoRow(label: 'Chassis No.', value: data.chassisNumber ?? '-'),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoDivider extends StatelessWidget {
  const InfoDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 1,
        thickness: 1,
        color: theme.colorScheme.outlineVariant.withValues(alpha: .3),
      ),
    );
  }
}

class DocumentsCard extends StatelessWidget {
  final VehicleData data;

  const DocumentsCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: .5),
        ),
      ),
      child: Column(
        children: [
          DocumentTile(
            title: 'Logbook',
            path: data.logbookPath,
          ),
          const InfoDivider(),
          DocumentTile(
            title: 'Insurance',
            path: data.insurancePath,
          ),
          const InfoDivider(),
          DocumentTile(
            title: 'NTSA Certificate',
            path: data.ntsaPath,
          ),
        ],
      ),
    );
  }
}

class DocumentTile extends StatelessWidget {
  final String title;
  final String? path;

  const DocumentTile({
    super.key,
    required this.title,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasFile = path != null && path!.isNotEmpty;
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: hasFile
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.insert_drive_file_outlined,
              color: hasFile
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hasFile ? path!.split('/').last : 'Not uploaded',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: hasFile
                        ? theme.colorScheme.onSurfaceVariant
                        : theme.colorScheme.error,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (hasFile)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}

class VehiclePhotosGrid extends StatelessWidget {
  final List<String> photoPaths;

  const VehiclePhotosGrid({
    super.key,
    required this.photoPaths,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (photoPaths.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: .5),
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.photo_library_outlined,
                size: 48,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(height: 12),
              Text(
                'No photos added',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: photoPaths.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: .5),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              File(photoPaths[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}