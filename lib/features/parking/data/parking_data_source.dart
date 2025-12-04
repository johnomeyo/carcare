import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/parking_spot_model.dart';

abstract class ParkingRemoteDataSource {
  Stream<List<ParkingSpotModel>> getParkingSpotsStream();
}

class ParkingRemoteDataSourceImpl implements ParkingRemoteDataSource {
  final FirebaseFirestore firestore;

  ParkingRemoteDataSourceImpl(this.firestore);

  @override
  Stream<List<ParkingSpotModel>> getParkingSpotsStream() {
    return firestore
        .collection("parking_spots")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ParkingSpotModel.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }
}
