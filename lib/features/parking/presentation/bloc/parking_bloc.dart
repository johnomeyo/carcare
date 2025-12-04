import 'dart:async';
import 'package:carcare/features/parking/dormain/usecases/fetch_spots_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'parking_event.dart';
import 'parking_state.dart';

class ParkingBloc extends Bloc<ParkingEvent, ParkingState> {
  final GetParkingSpotsStream getParkingSpotsStream;
  StreamSubscription? _streamSub;

  ParkingBloc(this.getParkingSpotsStream) : super(ParkingInitial()) {
    on<LoadParkingSpots>(_onLoadParkingSpots);
  }

  void _onLoadParkingSpots(
      LoadParkingSpots event, Emitter<ParkingState> emit) async {
    emit(ParkingLoading());
    print('---fetching parking spots stream---');

    _streamSub?.cancel(); 

    _streamSub = getParkingSpotsStream().listen(
      (spots) {
        emit(ParkingLoaded(spots));
        print("---received ${spots.length} parking spots---");
      },
      
      onError: (error) => emit(ParkingError(error.toString())),
    );

    print(' ---listening to parking spots stream---');
  }

  @override
  Future<void> close() {
    _streamSub?.cancel();
    return super.close();
  }
}
