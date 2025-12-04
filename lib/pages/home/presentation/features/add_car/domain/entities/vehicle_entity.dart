import 'package:image_picker/image_picker.dart';

class VehicleEntity {
  final String registrationNumber;
  final String make;
  final String yearOfManufacture;
  final String powerFuel;
  final String engineSize;
  final String chassisNumber;
  final String transmission;
  final String steering;
  final String mileage;
  final String color;
  
  // Files to be uploaded
  final XFile? vehiclePhoto;
  final XFile? logbookDocument;
  final XFile? insuranceDocument;
  final XFile? ntsaDocument;

  VehicleEntity({
    required this.registrationNumber,
    required this.make,
    required this.yearOfManufacture,
    required this.powerFuel,
    required this.engineSize,
    required this.chassisNumber,
    required this.transmission,
    required this.steering,
    required this.mileage,
    required this.color,
    this.vehiclePhoto,
    this.logbookDocument,
    this.insuranceDocument,
    this.ntsaDocument,
  });
}