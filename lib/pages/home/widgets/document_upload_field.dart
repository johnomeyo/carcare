
import 'dart:io';

import 'package:carcare/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentUploadField extends StatefulWidget {
  final String title;
  final String? description;
  final bool isOptional;
  final String? filePath;
  final FormFieldValidator<String?>? validator;
 final ValueChanged<XFile?>? onFilePicked;
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

  String? _currentFilePath;

  @override
  void initState() {
    super.initState();
    _currentFilePath = widget.filePath;
  }

Future<void> _pickFile(FormFieldState<String> state) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: widget.allowedExtensions,
    );

    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      
      final pickedFile = XFile(path); 

      setState(() {
        _currentFilePath = path;
      });
      
      widget.onFilePicked?.call(pickedFile); 
      
      state.didChange(_currentFilePath); 
    } else {
      setState(() {
        _currentFilePath = null;
      });
      widget.onFilePicked?.call(null);
      state.didChange(_currentFilePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasFile = _currentFilePath != null;

    return FormField<String>(
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

                if (hasFile)
                  _buildFileDisplay(theme, state)
                else
                  _buildUploadButton(theme, state),

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