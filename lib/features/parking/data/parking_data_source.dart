import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/parking_spot_model.dart';

// --- 1. Update the Abstract Class ---
abstract class ParkingRemoteDataSource {
  // Changed return type from Stream to Future
  Future<List<ParkingSpotModel>> getParkingSpots();
}

class ParkingRemoteDataSourceImpl implements ParkingRemoteDataSource {
  final FirebaseFirestore firestore;

  ParkingRemoteDataSourceImpl(this.firestore);

  @override
  // --- 2. Update the Concrete Implementation ---
  Future<List<ParkingSpotModel>> getParkingSpots() async {
    // Use .get() instead of .snapshots() to fetch data once
    final querySnapshot = await firestore
        .collection("parking_slots")
        .get();

    // Process the QuerySnapshot to map it to a list of models
    return querySnapshot.docs.map((doc) {
      // Ensure your ParkingSpotModel.fromJson handles the data and ID correctly
      return ParkingSpotModel.fromJson(doc.data(), doc.id);
    }).toList();
  }
}