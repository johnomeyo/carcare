// vehicle_bloc.dart

import 'package:carcare/pages/home/presentation/features/add_car/domain/entities/vehicle_entity.dart';
import 'package:carcare/pages/home/presentation/features/add_car/domain/usecases/add_vehicle_usecase.dart';
// ⭐ Import the new Use Case
import 'package:carcare/pages/home/presentation/features/add_car/domain/usecases/fetch_user_vehicles_usecase.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carcare/pages/home/presentation/features/add_car/data/bloc/vehicle_event.dart'; // Assume VehicleEvent is here
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final AddVehicleUsecase submitVehicleUseCase;
  // ⭐ New Use Case dependency
  final FetchUserVehiclesUseCase fetchUserVehiclesUseCase; 

  VehicleBloc({
    required this.submitVehicleUseCase,
    // ⭐ Initialize the new Use Case
    required this.fetchUserVehiclesUseCase, 
  }) : super(VehicleInitial()) {
    
    // Handler for submitting a vehicle (existing logic)
    on<SubmitVehicleEvent>((event, emit) async {
      emit(VehicleLoading());
      try {
        await submitVehicleUseCase(event.vehicleEntity);
        emit(VehicleSuccess());
      } catch (e) {
        emit(VehicleFailure(e.toString()));
      }
    });

    // ⭐ New Handler for fetching vehicles
    on<FetchVehiclesEvent>((event, emit) async {
      emit(VehicleLoading()); // Transition to loading state
      try {
        // Call the use case to fetch the data
        final List<VehicleEntity> vehicles = await fetchUserVehiclesUseCase(); 
        
        // Transition to a state that holds the fetched data
        emit(VehiclesLoaded(vehicles: vehicles)); 
      } catch (e) {
        // Handle any errors during fetching
        emit(VehicleFailure('Failed to load vehicles: ${e.toString()}'));
      }
    });
  }
}