import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/core/errors/exceptions.dart';
import 'package:myapp/features/serviceMetadata/data/datasources/service_metadata_remote_data_source.dart';
import 'package:myapp/features/serviceMetadata/data/models/service_metadata_model.dart';

class ServiceMetadataRemoteDataSourceImpl
    implements ServiceMetadataRemoteDataSource {
  final FirebaseFirestore _firestore;

  ServiceMetadataRemoteDataSourceImpl(this._firestore);

  @override
  Future<ServiceMetadataModel> getServiceMetadata(String serviceId) async {
    try {
      final doc = await _firestore
          .collection('serviceMetadata')
          .doc(serviceId)
          .get();
      if (doc.exists) {
        return ServiceMetadataModel.fromMap(doc.data()!);
      } else {
        // Create a new metadata document if it doesn't exist
        final newMetadata = {
          'serviceId': serviceId,
          'clicks': 0,
          'reviewsCount': 0,
          'totalRating': 0,
        };
        await _firestore
            .collection('serviceMetadata')
            .doc(serviceId)
            .set(newMetadata);
        return ServiceMetadataModel.fromMap(newMetadata);
      }
    } on FirebaseExceptions catch (e) {
      throw FirebaseExceptions(
        message: e.message,
        statusCode: 500,
      );
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<ServiceMetadataModel>> getAllServiceMetadata() async {
    try {
      final snapshot = await _firestore.collection('serviceMetadata').get();
      return snapshot.docs
          .map((doc) => ServiceMetadataModel.fromMap(doc.data()))
          .toList();
    } on FirebaseExceptions catch (e) {
      throw FirebaseExceptions(
        message: e.message,
        statusCode: 500,
      );
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> incrementServiceClicks(String serviceId) async {
    try {
      await _firestore.collection('serviceMetadata').doc(serviceId).update({
        'clicks': FieldValue.increment(1),
      });
    } on FirebaseExceptions catch (e) {
      throw FirebaseExceptions(
        message: e.message,
        statusCode: 500,
      );
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<void> updateServiceReview({
    required String serviceId,
    required int rating,
  }) async {
    try {
      await _firestore.collection('serviceMetadata').doc(serviceId).update({
        'reviewsCount': FieldValue.increment(1),
        'totalRating': FieldValue.increment(rating),
      });
    } on FirebaseExceptions catch (e) {
      throw FirebaseExceptions(
        message: e.message,
        statusCode: 500,
      );
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 500);
    }
  }
}
