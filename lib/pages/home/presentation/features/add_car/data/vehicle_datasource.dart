import 'dart:io';
import 'package:carcare/pages/home/presentation/features/add_car/data/models/vehicle_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class VehicleRemoteDataSource {
  Future<String> uploadFile(XFile file, String folder);
  Future<void> saveVehicleData(VehicleModel model);
}

class VehicleRemoteDataSourceImpl implements VehicleRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  VehicleRemoteDataSourceImpl({
    required this.firestore,
    required this.storage,
  });

  @override
  Future<String> uploadFile(XFile file, String folder) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
    final ref = storage.ref().child('$folder/$fileName');
    
    final uploadTask = await ref.putFile(File(file.path));
    return await uploadTask.ref.getDownloadURL();
  }

  @override
  Future<void> saveVehicleData(VehicleModel model) async {
    await firestore.collection('vehicles').add(model.toJson());
  }
}