class VehicleData {
  // Specs
  String? registrationNumber;
  String? make;
  String? yearOfManufacture;
  String? powerFuel;
  String? engineSize;
  String? chassisNumber;
  String? transmission;
  String? steering;
  String? mileage;
  String? color;

  // Documents (File Paths)
  String? logbookPath;
  String? insurancePath;
  String? ntsaPath;

  // Photos (File Paths)
  List<String> photoPaths = [];

  VehicleData();

  // ---------- FROM JSON ----------
  VehicleData.fromJson(Map<String, dynamic> json) {
    registrationNumber = json['registrationNumber'];
    make = json['make'];
    yearOfManufacture = json['yearOfManufacture'];
    powerFuel = json['powerFuel'];
    engineSize = json['engineSize'];
    chassisNumber = json['chassisNumber'];
    transmission = json['transmission'];
    steering = json['steering'];
    mileage = json['mileage'];
    color = json['color'];

    logbookPath = json['logbookPath'];
    insurancePath = json['insurancePath'];
    ntsaPath = json['ntsaPath'];

    photoPaths = List<String>.from(json['photoPaths'] ?? []);
  }

  // ---------- TO JSON ----------
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

      'logbookPath': logbookPath,
      'insurancePath': insurancePath,
      'ntsaPath': ntsaPath,

      'photoPaths': photoPaths,
    };
  }
}
