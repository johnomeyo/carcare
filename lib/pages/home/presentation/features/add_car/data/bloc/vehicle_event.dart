

import 'package:carcare/pages/home/presentation/features/add_car/domain/entities/vehicle_entity.dart';

abstract class VehicleEvent {}

class SubmitVehicleEvent extends VehicleEvent {
  final VehicleEntity vehicleEntity;
  SubmitVehicleEvent(this.vehicleEntity);
}