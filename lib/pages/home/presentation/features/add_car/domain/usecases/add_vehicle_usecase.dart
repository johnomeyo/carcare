import 'package:carcare/pages/home/presentation/features/add_car/domain/repositories/add_vehicle_repository.dart';

import '../entities/vehicle_entity.dart';

class AddVehicleUsecase {
  final VehicleRepository repository;

  AddVehicleUsecase(this.repository);

  Future<void> call(VehicleEntity vehicle) {
    return repository.submitVehicle(vehicle);
  }
}