import 'dart:io';
import 'package:carcare/pages/home/models/vehicle_data_model.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AppDimensions {
  static const double extraSmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;

  static const double shapeSmall = 8.0;
  static const double shapeMedium = 12.0;
}

class VehicleDocumentsPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
    final VehicleData data; 

  const VehicleDocumentsPage({super.key, required this.formKey,required this.data});

  @override
  State<VehicleDocumentsPage> createState() => _VehicleDocumentsPageState();
}

class _VehicleDocumentsPageState extends State<VehicleDocumentsPage> {
  String? _logbookPath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.large),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vehicle Documents',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.small),
                  Text(
                    'Upload your vehicle documentation to complete registration',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.large),

            // Vehicle Logbook (Required)
            DocumentUploadField(
              title: 'Vehicle Logbook',
              description: 'Upload your vehicle logbook (required)',
              onFilePicked: (path) {
                setState(() {
                  _logbookPath = path;
                });
              },
              // Validator checks if the file path is set.
              validator:
                  (value) =>
                      _logbookPath == null
                          ? 'Vehicle logbook is required'
                          : null,
              allowedExtensions: const ['pdf', 'jpg', 'png'],
              filePath: _logbookPath,
            ),

            const SizedBox(height: AppDimensions.large),

            // Insurance Cover (Optional)
            const DocumentUploadField(
              title: 'Insurance Cover',
              description: 'Upload your insurance certificate (optional)',
              isOptional: true,
              allowedExtensions: ['pdf', 'jpg', 'png'],
            ),

            const SizedBox(height: AppDimensions.large),

            // NTSA Inspection Certificate (Optional)
            const DocumentUploadField(
              title: 'NTSA Inspection Certificate',
              description: 'Upload your inspection certificate (optional)',
              isOptional: true,
              allowedExtensions: ['pdf', 'jpg', 'png'],
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable widget for uploading documents with form validation.
class DocumentUploadField extends StatefulWidget {
  final String title;
  final String? description;
  final bool isOptional;
  final String? filePath;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String?>? onFilePicked;
  final List<String> allowedExtensions;

  const DocumentUploadField({
    super.key,
    required this.title,
    this.description,
    this.isOptional = false,
    this.filePath,
    this.validator,
    this.onFilePicked,
    required this.allowedExtensions,
  });

  @override
  State<DocumentUploadField> createState() => _DocumentUploadFieldState();
}

class _DocumentUploadFieldState extends State<DocumentUploadField> {
  // We use this local state to manage the file path within the widget itself
  // for display purposes and FormField updates.
  String? _currentFilePath;

  @override
  void initState() {
    super.initState();
    _currentFilePath = widget.filePath;
  }

  // Handle the file picking logic
  Future<void> _pickFile(FormFieldState<String> state) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: widget.allowedExtensions,
    );

    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      setState(() {
        _currentFilePath = path;
      });
      // Notify the parent widget about the change
      widget.onFilePicked?.call(path);
    } else {
      // Clear the file path if picking was canceled or failed
      setState(() {
        _currentFilePath = null;
      });
      widget.onFilePicked?.call(null);
    }

    // Update the FormField state to trigger validation
    state.didChange(_currentFilePath);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasFile = _currentFilePath != null;

    return FormField<String>(
      // We pass the validator provided by the parent (if any)
      validator: widget.validator,
      builder: (FormFieldState<String> state) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppDimensions.shapeMedium),
            border: Border.all(
              color:
                  state.hasError
                      ? theme.colorScheme.error
                      : theme.colorScheme.outline.withValues(alpha: 0.12),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Optional Badge
                _buildHeader(theme),

                if (widget.description != null) ...[
                  const SizedBox(height: AppDimensions.small),
                  Text(
                    widget.description!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],

                const SizedBox(height: AppDimensions.medium),

                // Upload button or file display
                if (hasFile)
                  _buildFileDisplay(theme, state)
                else
                  _buildUploadButton(theme, state),

                // Error message
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: AppDimensions.small),
                    child: Text(
                      state.errorText!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        if (widget.isOptional)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.small,
              vertical: AppDimensions.extraSmall,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(AppDimensions.shapeSmall),
            ),
            child: Text(
              'Optional',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildUploadButton(ThemeData theme, FormFieldState<String> state) {
    return InkWell(
      onTap: () => _pickFile(state),
      borderRadius: BorderRadius.circular(AppDimensions.shapeMedium),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimensions.large),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppDimensions.shapeMedium),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 32,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: AppDimensions.small),
            Text(
              'Tap to upload file',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppDimensions.extraSmall),
            Text(
              'Supports ${widget.allowedExtensions.map((e) => e.toUpperCase()).join(', ')}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileDisplay(ThemeData theme, FormFieldState<String> state) {
    final fileName = _currentFilePath!.split(Platform.pathSeparator).last;
    final fileExtension = fileName.split('.').last.toLowerCase();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.medium),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.shapeMedium),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.small),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppDimensions.shapeSmall),
            ),
            child: Icon(
              _getFileIcon(fileExtension),
              color: theme.colorScheme.onPrimaryContainer,
              size: 20,
            ),
          ),
          const SizedBox(width: AppDimensions.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'File uploaded successfully',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _pickFile(state),
            icon: Icon(Icons.edit_outlined, color: theme.colorScheme.primary),
            tooltip: 'Change file',
          ),
        ],
      ),
    );
  }

  IconData _getFileIcon(String extension) {
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf_outlined;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }
}