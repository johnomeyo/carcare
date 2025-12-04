import '../entities/parking_spot_entity.dart';

abstract class ParkingRepository {
  Stream<List<ParkingSpotEntity>> getParkingSpotsStream();
}