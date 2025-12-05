import '../../domain/entities/vehicle_entity.dart';

class VehicleModel extends VehicleEntity {
  final String? logbookUrl;
  final String? insuranceUrl;
  final String? ntsaUrl;
  final List<String> photoUrls;
  final String? id; 
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
    this.id,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      registrationNumber: json['registrationNumber'] as String,
      make: json['make'] as String,
      yearOfManufacture: json['yearOfManufacture'] as String,
      powerFuel: json['powerFuel'] as String,
      engineSize: json['engineSize'] as String,
      chassisNumber: json['chassisNumber'] as String,
      transmission: json['transmission'] as String,
      steering: json['steering'] as String,
      mileage: json['mileage'] as String,
      color: json['color'] as String,
      
      logbookUrl: json['logbookPath'] ?? '',
      insuranceUrl: json['insurancePath'] ?? '',
      ntsaUrl: json['ntsaPath'] ?? '',
      
      photoUrls: (json['photoPaths'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          const [],
          
      id: json['id'] as String?,
    );
  }

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
  
  // 3. Factory constructor for converting VehicleEntity to VehicleModel
  factory VehicleModel.fromEntity(
    VehicleEntity entity, {
    String? logbookUrl,
    String? insuranceUrl,
    String? ntsaUrl,
    String? photoUrl,
    String? id,
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
      id: id,
    );
  }

    VehicleEntity toEntity() {
    return VehicleEntity(
      registrationNumber: registrationNumber,
      make: make,
      yearOfManufacture: yearOfManufacture,
      powerFuel: powerFuel,
      engineSize: engineSize,
      chassisNumber: chassisNumber,
      transmission: transmission,
      steering: steering,
      mileage: mileage,
      color: color,
    );
  }
}