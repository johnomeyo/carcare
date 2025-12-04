import 'package:carcare/features/parking/dormain/entities/parking_spot_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ParkingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ParkingInitial extends ParkingState {}

class ParkingLoading extends ParkingState {}

class ParkingLoaded extends ParkingState {
  final List<ParkingSpotEntity> spots;
  ParkingLoaded(this.spots);

  @override
  List<Object?> get props => [spots];
}

class ParkingError extends ParkingState {
  final String message;
  ParkingError(this.message);

  @override
  List<Object?> get props => [message];
}
