import 'package:carcare/pages/home/models/vehicle_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeDatasource {
  Future<void> addUserVehicle(VehicleData vehicle) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('vehicles')
        .add(vehicle.toJson());
  }
}

