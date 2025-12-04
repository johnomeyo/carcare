import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carcare/features/parking/dormain/usecases/fetch_spots_usecase.dart'; 

import 'parking_event.dart';
import 'parking_state.dart';

class ParkingBloc extends Bloc<ParkingEvent, ParkingState> {
  final GetParkingSpotsStream fetchParkingSpotsUseCase;

  ParkingBloc(this.fetchParkingSpotsUseCase) : super(ParkingInitial()) {
    on<LoadParkingSpots>(_onLoadParkingSpots);
  }
  void _onLoadParkingSpots(
      LoadParkingSpots event, Emitter<ParkingState> emit) async {
    emit(ParkingLoading());
    try {
      final spots = await fetchParkingSpotsUseCase();
      emit(ParkingLoaded(spots));

    } catch (error) {
      emit(ParkingError(error.toString()));
    }
  }
}