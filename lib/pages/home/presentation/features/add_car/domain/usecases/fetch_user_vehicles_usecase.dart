import 'package:carcare/pages/home/presentation/features/add_car/domain/entities/vehicle_entity.dart';
import 'package:carcare/pages/home/presentation/features/add_car/domain/repositories/add_vehicle_repository.dart';

class FetchUserVehiclesUseCase {
  final VehicleRepository repository;

  FetchUserVehiclesUseCase({required this.repository});

  Future<List<VehicleEntity>> call() {
    return repository.fetchUserVehicles();
  }
}