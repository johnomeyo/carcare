import '../entities/vehicle_entity.dart';

abstract class VehicleRepository {
  Future<void> submitVehicle(VehicleEntity vehicle);
  Future<List<VehicleEntity>> fetchUserVehicles();
}