import 'package:flutter/material.dart';

import '../../../../../models/vehicle_data_model.dart';

// --- Theme Extensions for consistency ---
// Move these extensions to a separate file (e.g., 'app_theme.dart')
// to be used application-wide.
extension ThemeSpacing on ThemeData {
  _Spacing get spacing => const _Spacing();
}

class _Spacing {
  const _Spacing();

  double get extraSmall => 4.0;
  double get small => 8.0;
  double get medium => 16.0;
  double get large => 24.0;
  double get extraLarge => 32.0;
}

extension ThemeShape on ThemeData {
  _Shape get shape => const _Shape();
}

class _Shape {
  const _Shape();

  double get small => 8.0;
  double get medium => 12.0;
  double get large => 16.0;
}

// --- Custom Form Widgets ---
// These are stateless and highly reusable, so we use const constructors.
class CustomTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(theme.shape.medium),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.12),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 20,
                )
              : null,
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(theme.shape.medium),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(theme.shape.medium),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(theme.shape.medium),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(theme.shape.medium),
            borderSide: BorderSide(
              color: theme.colorScheme.error,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(theme.shape.medium),
            borderSide: BorderSide(
              color: theme.colorScheme.error,
              width: 2,
            ),
          ),
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          floatingLabelStyle: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
          errorStyle: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.error,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: theme.spacing.medium,
            vertical: theme.spacing.medium,
          ),
        ),
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String?>? validator;

  const CustomDropdownField({
    super.key,
    required this.label,
    this.icon,
    required this.items,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(theme.shape.medium),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.12),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 20,
                )
              : null,
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(theme.shape.medium),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(theme.shape.medium),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(theme.shape.medium),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(theme.shape.medium),
            borderSide: BorderSide(
              color: theme.colorScheme.error,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(theme.shape.medium),
            borderSide: BorderSide(
              color: theme.colorScheme.error,
              width: 2,
            ),
          ),
          labelStyle: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          floatingLabelStyle: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
          errorStyle: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.error,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: theme.spacing.medium,
            vertical: theme.spacing.medium,
          ),
        ),
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        dropdownColor: theme.colorScheme.surface,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

class VehicleSpecificationsPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final VehicleData data;
  const VehicleSpecificationsPage(
      {super.key, required this.formKey, required this.data});

  @override
  State<VehicleSpecificationsPage> createState() =>
      _VehicleSpecificationsPageState();
}

class _VehicleSpecificationsPageState extends State<VehicleSpecificationsPage> {
  final List<String> vehicleMakes = ['Toyota', 'Honda', 'Ford', 'BMW'];
  final List<String> transmissions = ['Automatic', 'Manual'];
  final List<String> steering = ['Left Hand Drive', 'Right Hand Drive'];
  final List<String> colors = ['Red', 'Blue', 'Black', 'White'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.large),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            _buildHeader(context, theme),

            SizedBox(height: theme.spacing.large),

            // Vehicle Information Section
            _buildSectionHeader(context, 'Vehicle Information'),
            SizedBox(height: theme.spacing.medium),

            CustomTextField(
                label: 'Vehicle Registration Number',
                icon: Icons.confirmation_number_outlined,
                validator: (value) {
                  if (value!.isEmpty) return 'Registration is required';
                  widget.data.registrationNumber = value;
                  return null;
                }),
            SizedBox(height: theme.spacing.medium),

            CustomDropdownField(
              label: 'Vehicle Make',
              icon: Icons.directions_car_outlined,
              items: vehicleMakes,
              validator: (value) =>
                  value == null ? 'Vehicle make is required' : null,
              onChanged: (value) {
                widget.data.make = value;
              },
            ),
            SizedBox(height: theme.spacing.medium),

            CustomTextField(
              label: 'Year of Manufacture',
              icon: Icons.calendar_today_outlined,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) return 'Year of manufacture is required';
                final year = int.tryParse(value);
                widget.data.yearOfManufacture = year.toString();

                if (year == null || year < 1900 || year > DateTime.now().year) {
                  return 'Please enter a valid year';
                }
                return null;
              },
            ),

            SizedBox(height: theme.spacing.large),

            _buildSectionHeader(context, 'Engine & Performance'),
            SizedBox(height: theme.spacing.medium),

            CustomTextField(
                label: 'Power/Fuel',
                icon: Icons.local_gas_station_outlined,
                validator: (value) {
                  if (value!.isEmpty) {
                    widget.data.powerFuel = value;
                    return 'Power/Fuel information is required';
                  }

                  return null;
                }),
            SizedBox(height: theme.spacing.medium),

            CustomTextField(
              label: 'Engine Size (cc)',
              icon: Icons.speed_outlined,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) return 'Engine size is required';
                final size = int.tryParse(value);
                widget.data.engineSize = size.toString();
                if (size == null || size <= 0) {
                  return 'Please enter a valid engine size';
                }
                return null;
              },
            ),
            SizedBox(height: theme.spacing.medium),

            CustomTextField(
                label: 'Chassis Number',
                icon: Icons.label_outlined,
                validator: (value) {
                  if (value!.isEmpty) return 'Chasis number is required';
                  widget.data.chassisNumber = value;
                  return null;
                }),

            SizedBox(height: theme.spacing.large),

            // Vehicle Features Section
            _buildSectionHeader(context, 'Vehicle Features'),
            SizedBox(height: theme.spacing.medium),

            CustomDropdownField(
                label: 'Transmission',
                icon: Icons.settings_outlined,
                items: transmissions,
                validator: (value) {
                  if (value!.isEmpty) return 'Transmission type is required';
                  widget.data.transmission = value;
                  return null;
                },
                onChanged: (value) => widget.data.transmission = value),
            SizedBox(height: theme.spacing.medium),

            CustomDropdownField(
              label: 'Steering',
              icon: Icons.my_location_outlined,
              items: steering,
              validator: (value) {
                if (value!.isEmpty) return 'Steering type is required';
                widget.data.steering = value;
                return null;
              },
              onChanged: (value) => widget.data.steering = value,
            ),
            SizedBox(height: theme.spacing.medium),

            CustomTextField(
              label: 'Mileage (km)',
              icon: Icons.straighten_outlined,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) return 'Mileage is required';
                final mileage = double.tryParse(value);
                widget.data.mileage = mileage.toString();
                if (mileage == null || mileage < 0) {
                  return 'Please enter a valid mileage';
                }
                return null;
              },
            ),
            SizedBox(height: theme.spacing.medium),

            CustomDropdownField(
                label: 'Color',
                icon: Icons.palette_outlined,
                items: colors,
                validator: (value) {
                  if (value!.isEmpty) return 'Vehicle color is required';
                  widget.data.color = value;
                  return null;
                },
                onChanged: (value) => widget.data.color = value),

            SizedBox(height: theme.spacing.extraLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(bottom: theme.spacing.small),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Container(
      padding: EdgeInsets.only(bottom: theme.spacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vehicle Specifications',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: theme.spacing.small),
          Text(
            'Enter detailed information about your vehicle',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
