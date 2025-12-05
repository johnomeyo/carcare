part of 'vehicle_bloc.dart';

abstract class VehicleState {}

class VehicleInitial extends VehicleState {}
class VehicleLoading extends VehicleState {}
class VehicleSuccess extends VehicleState {}
class VehicleFailure extends VehicleState {
  final String message;
  VehicleFailure(this.message);
}

class FetchVehiclesEvent extends VehicleEvent {}
class VehiclesLoaded extends VehicleState {
  final List<VehicleEntity> vehicles;

  VehiclesLoaded({required this.vehicles});
}