// onboarding_pages/vehicle_photos_page.dart
import 'dart:io';
import 'package:carcare/pages/home/models/vehicle_data_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VehiclePhotosPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
    final VehicleData data; 
  const VehiclePhotosPage({super.key, required this.formKey,required this.data});

  @override
  State<VehiclePhotosPage> createState() => _VehiclePhotosPageState();
}

class _VehiclePhotosPageState extends State<VehiclePhotosPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _imageFile = image;
        });
      }
    } catch (e) {
      print('Image picking error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showImageSourceDialog() {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(theme.shape.large),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(theme.spacing.large),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.4,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: theme.spacing.medium),
              Text(
                'Select Image Source',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: theme.spacing.large),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSourceOption(
                    context,
                    icon: Icons.camera_alt_outlined,
                    label: 'Camera',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  _buildSourceOption(
                    context,
                    icon: Icons.photo_library_outlined,
                    label: 'Gallery',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
              SizedBox(height: theme.spacing.large),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSourceOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(theme.shape.medium),
      child: Container(
        padding: EdgeInsets.all(theme.spacing.large),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(theme.shape.medium),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: theme.colorScheme.primary),
            SizedBox(height: theme.spacing.small),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            Container(
              padding: EdgeInsets.only(bottom: theme.spacing.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vehicle Photos',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: theme.spacing.small),
                  Text(
                    'Upload a clear photo of your vehicle to complete registration',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: theme.spacing.large),

            // Photo upload section
            FormField<XFile>(
              validator:
                  (value) =>
                      _imageFile == null ? 'Vehicle photo is required' : null,
              builder: (FormFieldState<XFile> state) {
                return Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(theme.shape.medium),
                    border: Border.all(
                      color:
                          state.hasError
                              ? theme.colorScheme.error
                              : theme.colorScheme.outline.withValues(
                                alpha: 0.12,
                              ),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(theme.spacing.medium),
                    child: Column(
                      children: [
                        // Upload area
                        if (_imageFile == null)
                          _buildUploadArea(context, theme, state)
                        else
                          _buildImagePreview(context, theme, state),

                        // Error message
                        if (state.hasError) ...[
                          SizedBox(height: theme.spacing.medium),
                          Container(
                            padding: EdgeInsets.all(theme.spacing.small),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.errorContainer
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(
                                theme.shape.small,
                              ),
                              border: Border.all(
                                color: theme.colorScheme.error.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: theme.colorScheme.error,
                                  size: 16,
                                ),
                                SizedBox(width: theme.spacing.small),
                                Text(
                                  state.errorText!,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: theme.spacing.large),

            // Guidelines section
            Container(
              padding: EdgeInsets.all(theme.spacing.medium),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.1,
                ),
                borderRadius: BorderRadius.circular(theme.shape.medium),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      SizedBox(width: theme.spacing.small),
                      Text(
                        'Photo Guidelines',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: theme.spacing.small),
                  ...[
                    'Take a clear photo from the side view',
                    'Ensure good lighting conditions',
                    'Include the entire vehicle in frame',
                    'Avoid blurry or dark images',
                  ].map(
                    (tip) => Padding(
                      padding: EdgeInsets.only(top: theme.spacing.extraSmall),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 6,
                              right: theme.spacing.small,
                            ),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onSurfaceVariant,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              tip,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadArea(
    BuildContext context,
    ThemeData theme,
    FormFieldState<XFile> state,
  ) {
    return InkWell(
      onTap: _isLoading ? null : _showImageSourceDialog,
      borderRadius: BorderRadius.circular(theme.shape.medium),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 200),
        padding: EdgeInsets.all(theme.spacing.large),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(theme.shape.medium),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              CircularProgressIndicator(color: theme.colorScheme.primary)
            else ...[
              Icon(
                Icons.add_a_photo_outlined,
                size: 48,
                color: theme.colorScheme.primary,
              ),
              SizedBox(height: theme.spacing.medium),
              Text(
                'Upload Vehicle Photo',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: theme.spacing.small),
              Text(
                'Tap to select from camera or gallery',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: theme.spacing.small),
              Text(
                'JPG, PNG up to 10MB',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(
    BuildContext context,
    ThemeData theme,
    FormFieldState<XFile> state,
  ) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(theme.shape.medium),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(theme.shape.medium),
            child: Image.file(File(_imageFile!.path), fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: theme.spacing.medium),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: theme.spacing.small,
                vertical: theme.spacing.extraSmall,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(theme.shape.small),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: theme.colorScheme.onPrimaryContainer,
                    size: 16,
                  ),
                  SizedBox(width: theme.spacing.extraSmall),
                  Text(
                    'Photo uploaded successfully',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.small),
        TextButton.icon(
          onPressed: () {
            _showImageSourceDialog();
            state.didChange(_imageFile);
          },
          icon: Icon(
            Icons.edit_outlined,
            size: 18,
            color: theme.colorScheme.primary,
          ),
          label: Text(
            'Change Photo',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

// Extension for consistent spacing
extension ThemeSpacing on ThemeData {
  // ignore: library_private_types_in_public_api
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

// Extension for consistent shapes
extension ThemeShape on ThemeData {
  // ignore: library_private_types_in_public_api
  _Shape get shape => const _Shape();
}

class _Shape {
  const _Shape();

  double get small => 8.0;
  double get medium => 12.0;
  double get large => 16.0;
}