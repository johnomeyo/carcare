import 'package:carcare/pages/home/models/vehicle_data_model.dart';
import 'package:flutter/material.dart';
import 'pages/vehicle_documents_page.dart';
import 'pages/vehicle_specs_page.dart';
import 'pages/vehicle_photos.dart'; // Ensure you finish this file based on your previous snippet
import '../../../../utils/dialogs_utils.dart';
import 'pages/verify_vehicle_details.dart'; // Assuming this exists

class VehicleOnboardingPage extends StatefulWidget {
  const VehicleOnboardingPage({super.key});

  @override
  State<VehicleOnboardingPage> createState() => _VehicleOnboardingPageState();
}

class _VehicleOnboardingPageState extends State<VehicleOnboardingPage> {
  final PageController _pageController = PageController();
  
  // 1. Create the single source of truth for data
  final VehicleData _vehicleData = VehicleData();

  // 2. Adjust Form Keys (only 3 pages have forms, the verify page doesn't need one)
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(), // Documents
    GlobalKey<FormState>(), // Specs
    GlobalKey<FormState>(), // Photos (if you validate photos)
  ];

  int _currentPage = 0;
  final int _totalPages = 4; // Increased to 4 to include Verify Page

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    // Validation logic
    if (_currentPage < _totalPages - 1) {
      // If we are on a form page, validate it
      if (_currentPage < _formKeys.length) {
        if (!_formKeys[_currentPage].currentState!.validate()) {
          return; // Stop if invalid
        }
        _formKeys[_currentPage].currentState!.save(); // Save form data
      }

      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Final Submit on the Verify Page
      _submitApplication();
    }
  }

  void _submitApplication() {
    // Here you would call your API/Bloc/Provider
    DialogUtils.showSuccessDialog(
      context: context, 
      title: 'Success!', 
      message: "Your car has been successfully added!"
    );
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Vehicle Onboarding')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: LinearProgressIndicator(
              value: (_currentPage + 1) / _totalPages,
              backgroundColor: colorScheme.primary.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              borderRadius: BorderRadius.circular(4),
              minHeight: 8,
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _totalPages,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    // Pass the data object so child can write to it
                    return VehicleDocumentsPage(
                      formKey: _formKeys[0], 
                      data: _vehicleData
                    );
                  case 1:
                    return VehicleSpecificationsPage(
                      formKey: _formKeys[1], 
                      data: _vehicleData
                    );
                  case 2:
                    return VehiclePhotosPage(
                      formKey: _formKeys[2], 
                      data: _vehicleData
                    );
                  case 3:
                    // The new Verify Page
                    return VehicleVerifyPage(
                      data: _vehicleData,
                      onEditPressed: _goToPreviousPage,
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  OutlinedButton(
                    onPressed: _goToPreviousPage,
                    child: const Text('Previous'),
                  ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _goToNextPage,
                  child: Text(
                    _currentPage == _totalPages - 1 ? 'Submit' : 'Next',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}