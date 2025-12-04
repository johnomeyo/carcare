import '../../dormain/entities/parking_spot_entity.dart';
import '../../dormain/repositories/parking_repo.dart';
import '../parking_data_source.dart';

class ParkingRepositoryImpl implements ParkingRepository {
  final ParkingRemoteDataSource remoteDataSource;

  ParkingRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<ParkingSpotEntity>> getParkingSpotsStream() {
    return remoteDataSource.getParkingSpotsStream();
  }
}