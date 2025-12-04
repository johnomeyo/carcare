
import 'package:carcare/pages/home/presentation/features/add_car/domain/entities/vehicle_entity.dart';
import 'package:carcare/pages/home/presentation/features/add_car/domain/repositories/add_vehicle_repository.dart';
import 'package:carcare/pages/home/presentation/features/add_car/data/vehicle_datasource.dart';

import '../models/vehicle_model.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleRemoteDataSource remoteDataSource;

  VehicleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> submitVehicle(VehicleEntity vehicle) async {
    String? logbookUrl;
    String? insuranceUrl;
    String? ntsaUrl;
    String? photoUrl;

    // 1. Upload Logbook
    if (vehicle.logbookDocument != null) {
      logbookUrl = await remoteDataSource.uploadFile(
          vehicle.logbookDocument!, 'documents/logbooks');
    }

    // 2. Upload Insurance
    if (vehicle.insuranceDocument != null) {
      insuranceUrl = await remoteDataSource.uploadFile(
          vehicle.insuranceDocument!, 'documents/insurance');
    }

    // 3. Upload NTSA
    if (vehicle.ntsaDocument != null) {
      ntsaUrl = await remoteDataSource.uploadFile(
          vehicle.ntsaDocument!, 'documents/ntsa');
    }

    // 4. Upload Vehicle Photo
    if (vehicle.vehiclePhoto != null) {
      photoUrl = await remoteDataSource.uploadFile(
          vehicle.vehiclePhoto!, 'photos/vehicles');
    }

    final vehicleModel = VehicleModel.fromEntity(
      vehicle,
      logbookUrl: logbookUrl,
      insuranceUrl: insuranceUrl,
      ntsaUrl: ntsaUrl,
      photoUrl: photoUrl,
    );

    await remoteDataSource.saveVehicleData(vehicleModel);
  }
}