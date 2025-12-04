import 'package:equatable/equatable.dart';

abstract class ParkingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadParkingSpots extends ParkingEvent {}
