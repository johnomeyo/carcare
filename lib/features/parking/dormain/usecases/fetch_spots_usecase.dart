import 'package:carcare/features/parking/dormain/repositories/parking_repo.dart';

import '../entities/parking_spot_entity.dart';


class GetParkingSpotsStream {
  final ParkingRepository repository;

  GetParkingSpotsStream(this.repository);

  Future<List<ParkingSpotEntity>> call() {
    return repository.getParkingSpotsStream();
  }
}

