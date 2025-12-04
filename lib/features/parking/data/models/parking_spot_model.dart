
import 'package:carcare/features/parking/dormain/entities/parking_spot_entity.dart';

class ParkingSpotModel extends ParkingSpotEntity {
  const ParkingSpotModel({
    required super.id,
    required super.name,
    required super.address,
    required super.distance,
    required super.hourlyRate,
    required super.availability,
    required super.isOpen24hrs,
    required super.latitude,
    required super.longitude,
    required super.imageUrl,
  });

  factory ParkingSpotModel.fromJson(Map<String, dynamic> data, String id) {
    return ParkingSpotModel(
      id: id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      distance: data['distance'] ?? '',
      hourlyRate: (data['hourlyRate'] ?? 0).toDouble(),
      availability: data['availability'] ?? '',
      isOpen24hrs: data['isOpen24hrs'] ?? false,
      latitude: (data['latitude'] ?? 0).toDouble(),
      longitude: (data['longitude'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "address": address,
      "distance": distance,
      "hourlyRate": hourlyRate,
      "availability": availability,
      "isOpen24hrs": isOpen24hrs,
      "latitude": latitude,
      "longitude": longitude,
      "imageUrl": imageUrl,
    };
  }
}
