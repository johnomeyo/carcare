import 'package:carcare/pages/home/presentation/features/add_car/data/bloc/vehicle_event.dart';
import 'package:carcare/pages/home/presentation/features/add_car/domain/usecases/add_vehicle_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final AddVehicleUsecase submitVehicleUseCase;

  VehicleBloc({required this.submitVehicleUseCase}) : super(VehicleInitial()) {
    on<SubmitVehicleEvent>((event, emit) async {
      emit(VehicleLoading());
      try {
        await submitVehicleUseCase(event.vehicleEntity);
        emit(VehicleSuccess());
      } catch (e) {
        emit(VehicleFailure(e.toString()));
      }
    });
  }
}
