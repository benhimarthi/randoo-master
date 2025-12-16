import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/core/errors/exceptions.dart';
import 'package:myapp/features/service/data/datasources/service_remote_data_source.dart';
import 'package:myapp/features/service/data/models/service_model.dart';

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final FirebaseFirestore _firestore;

  ServiceRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> createService(ServiceModel service) async {
    try {
      await _firestore
          .collection('services')
          .doc(service.id)
          .set(service.toMap());
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
        message: e.message ?? 'An error occurred',
        statusCode: 500,
      );
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      var services = await _firestore.collection('services').get();
      return services.docs
          .map((doc) => ServiceModel.fromMap(doc.data()))
          .toList();
    } on FirebaseExceptions catch (e) {
      throw FirebaseExceptions(message: e.message, statusCode: 500);
    }
  }

  @override
  Future<void> updateService(ServiceModel service) async {
    try {
      await _firestore
          .collection('services')
          .doc(service.id)
          .update(service.toMap());
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
        message: e.message ?? 'An error occurred',
        statusCode: 500,
      );
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> deleteService(String serviceId) async {
    try {
      await _firestore.collection('services').doc(serviceId).delete();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
        message: e.message ?? 'An error occurred',
        statusCode: 500,
      );
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<ServiceModel> getServiceById(String serviceId) async {
    try {
      final md = await _firestore.collection('services').doc(serviceId).get();
      return ServiceModel.fromMap(md.data()!);
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
        message: e.message ?? 'An error occurred',
        statusCode: 500,
      );
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }
}
