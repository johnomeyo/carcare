import 'package:carcare/pages/home/models/vehicle_data_model.dart';
// import 'package:carcare/pages/home/presentation/features/add_car/data/bloc/vehicle_bloc.dart';
// import 'package:carcare/pages/home/presentation/features/add_car/data/bloc/vehicle_event.dart';
// import 'package:carcare/pages/home/presentation/features/add_car/domain/entities/vehicle_entity.dart';
import 'package:flutter/material.dart';
import 'vehicle_documents_page.dart';
import 'vehicle_specs_page.dart';
import 'vehicle_photos.dart';
import 'verify_vehicle_details.dart';

class VehicleOnboardingPage extends StatefulWidget {
  const VehicleOnboardingPage({super.key});

  @override
  State<VehicleOnboardingPage> createState() => _VehicleOnboardingPageState();
}

class _VehicleOnboardingPageState extends State<VehicleOnboardingPage> {
  final PageController _pageController = PageController();

  final VehicleData _vehicleData = VehicleData();

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  int _currentPage = 0;
  final int _totalPages = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages - 1) {
      if (_currentPage < _formKeys.length) {
        if (!_formKeys[_currentPage].currentState!.validate()) {
          return;
        }
        _formKeys[_currentPage].currentState!.save();
      }

      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      submitApplication();
    }
  }

  void submitApplication() {

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
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                    return VehicleDocumentsPage(
                        formKey: _formKeys[0], data: _vehicleData);
                  case 1:
                    return VehicleSpecificationsPage(
                        formKey: _formKeys[1], data: _vehicleData);
                  case 2:
                    return VehiclePhotosPage(
                        formKey: _formKeys[2], data: _vehicleData);
                  case 3:
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
