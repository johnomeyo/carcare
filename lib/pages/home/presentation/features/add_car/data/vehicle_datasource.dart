import 'dart:io';
import 'package:carcare/pages/home/presentation/features/add_car/data/models/vehicle_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class VehicleRemoteDataSource {
  Future<String> uploadFile(XFile file, String folder);
  Future<void> saveVehicleData(VehicleModel model);
  Future<List<VehicleModel>> fetchUserVehicles(); 
}

class VehicleRemoteDataSourceImpl implements VehicleRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final FirebaseAuth auth;

  VehicleRemoteDataSourceImpl({
    required this.firestore,
    required this.storage,
    required this.auth, 
  });

  String get _currentUserId {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    return user.uid;
  }

  @override
  Future<String> uploadFile(XFile file, String folder) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
    final ref = storage.ref().child('$folder/$fileName');

    final uploadTask = await ref.putFile(File(file.path));
    return await uploadTask.ref.getDownloadURL();
  }

  @override
  Future<void> saveVehicleData(VehicleModel model) async {
    final uid = _currentUserId;

    await firestore
        .collection('users')
        .doc(uid)
        .collection('vehicles')
        .add(model.toJson());
  }

  // ⭐ Implementation of the new fetchUserVehicles method
  @override
  Future<List<VehicleModel>> fetchUserVehicles() async {
    final uid = _currentUserId;

    // 1. Fetch the documents from the 'vehicles' subcollection
    final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('users')
        .doc(uid)
        .collection('vehicles')
        // Optional: Order the vehicles, for example, by creation date
        // .orderBy('timestamp', descending: true) 
        .get();

    // 2. Map the list of documents (QueryDocumentSnapshot) to a list of VehicleModel
    final List<VehicleModel> vehicles = snapshot.docs.map((doc) {
      // It's good practice to include the document ID in the model if needed 
      // for future operations (e.g., update/delete)
      final data = doc.data();
      data['id'] = doc.id; // Assuming VehicleModel has an 'id' field
      
      return VehicleModel.fromJson(data);
    }).toList();

    return vehicles;
  }
}