import 'package:carcare/constants.dart';
import 'package:carcare/pages/home/models/vehicle_data_model.dart';
import 'package:carcare/pages/home/widgets/document_upload_field.dart';
import 'package:flutter/material.dart';

class VehicleDocumentsPage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final VehicleData data;

  const VehicleDocumentsPage(
      {super.key, required this.formKey, required this.data});

  @override
  State<VehicleDocumentsPage> createState() => _VehicleDocumentsPageState();
}

class _VehicleDocumentsPageState extends State<VehicleDocumentsPage> {
  late String? _logbookPath;
  late String? _insurancePath;
  late String? _ntsaPath;

  @override
  void initState() {
    super.initState();
    _logbookPath = widget.data.logbookPath;
    _insurancePath = widget.data.insurancePath;
    _ntsaPath = widget.data.ntsaPath;
  }

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
            DocumentUploadField(
              title: 'Vehicle Logbook',
              description: 'Upload your vehicle logbook (required)',
              onFilePicked: (logbookFile) {
                setState(() {
                  _logbookPath = logbookFile?.path;
                });
                widget.data.logbookPath = logbookFile?.path;
                widget.data.logbookDocument = logbookFile;
              },
              validator: (value) =>
                  _logbookPath == null ? 'Vehicle logbook is required' : null,
              allowedExtensions: const ['pdf', 'jpg', 'png'],
              filePath: _logbookPath,
            ),
            const SizedBox(height: AppDimensions.large),
            DocumentUploadField(
              title: 'Insurance Cover',
              description: 'Upload your insurance certificate (optional)',
              isOptional: true,
              allowedExtensions: const ['pdf', 'jpg', 'png'],
              filePath: _insurancePath,
              onFilePicked: (insuranceCoverFile) {
                setState(() {
                  _insurancePath = insuranceCoverFile?.path;
                  widget.data.insurancePath = insuranceCoverFile?.path;
                  widget.data.insuranceDocument = insuranceCoverFile;
                });
              },
            ),
            const SizedBox(height: AppDimensions.large),
            DocumentUploadField(
              title: 'NTSA Inspection Certificate',
              description: 'Upload your inspection certificate (optional)',
              isOptional: true,
              allowedExtensions: const ['pdf', 'jpg', 'png'],
              filePath: _ntsaPath,
              onFilePicked: (ntsaDocumentFile) {
                final path = ntsaDocumentFile?.path;
                setState(() {
                  _ntsaPath = path;
                  widget.data.ntsaPath = path;
                  widget.data.ntsaDocument = ntsaDocumentFile;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
