class ParkingSpotEntity {
  final String id;
  final String name;
  final String address;
  final String distance;
  final double hourlyRate;
  final String availability;
  final bool isOpen24hrs;
  final double latitude;
  final double longitude;
  final String imageUrl;

  const ParkingSpotEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.distance,
    required this.hourlyRate,
    required this.availability,
    required this.isOpen24hrs,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
  });
}
