class Car {
  final String id;
  final String name;
  final String make;
  final String model;
  final String year;
  final String color;
  final String plateNumber;
  final String fuelType;
  final String transmission;
  final String engineSize;
  final String mileage;
  final DateTime? lastService;
  final DateTime? nextService;
  final String? imageUrl;

  Car({
    required this.id,
    required this.name,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.plateNumber,
    required this.fuelType,
    required this.transmission,
    required this.engineSize,
    required this.mileage,
    this.lastService,
    this.nextService,
    this.imageUrl,
  });
}
