import '../../domain/entities/vehicle_entity.dart';

class VehicleModel extends VehicleEntity {
  final String? logbookUrl;
  final String? insuranceUrl;
  final String? ntsaUrl;
  final List<String> photoUrls;

  VehicleModel({
    required super.registrationNumber,
    required super.make,
    required super.yearOfManufacture,
    required super.powerFuel,
    required super.engineSize,
    required super.chassisNumber,
    required super.transmission,
    required super.steering,
    required super.mileage,
    required super.color,
    this.logbookUrl,
    this.insuranceUrl,
    this.ntsaUrl,
    this.photoUrls = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'registrationNumber': registrationNumber,
      'make': make,
      'yearOfManufacture': yearOfManufacture,
      'powerFuel': powerFuel,
      'engineSize': engineSize,
      'chassisNumber': chassisNumber,
      'transmission': transmission,
      'steering': steering,
      'mileage': mileage,
      'color': color,
      'logbookPath': logbookUrl,
      'insurancePath': insuranceUrl,
      'ntsaPath': ntsaUrl,
      'photoPaths': photoUrls,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }
  
  // Factory to create Model from Entity + Uploaded URLs
  factory VehicleModel.fromEntity(
    VehicleEntity entity, {
    String? logbookUrl,
    String? insuranceUrl,
    String? ntsaUrl,
    String? photoUrl,
  }) {
    return VehicleModel(
      registrationNumber: entity.registrationNumber,
      make: entity.make,
      yearOfManufacture: entity.yearOfManufacture,
      powerFuel: entity.powerFuel,
      engineSize: entity.engineSize,
      chassisNumber: entity.chassisNumber,
      transmission: entity.transmission,
      steering: entity.steering,
      mileage: entity.mileage,
      color: entity.color,
      logbookUrl: logbookUrl,
      insuranceUrl: insuranceUrl,
      ntsaUrl: ntsaUrl,
      photoUrls: photoUrl != null ? [photoUrl] : [],
    );
  }
}