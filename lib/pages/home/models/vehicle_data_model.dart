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
}