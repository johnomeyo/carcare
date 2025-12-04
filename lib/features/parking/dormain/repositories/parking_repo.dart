import '../entities/parking_spot_entity.dart';

abstract class ParkingRepository {
  Future<List<ParkingSpotEntity>> getParkingSpotsStream();
}