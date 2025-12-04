import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/core/errors/exceptions.dart';
import 'package:myapp/features/service/data/datasources/service_remote_data_source.dart';
import 'package:myapp/features/service/data/models/review_model.dart';
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
      throw FirebaseExceptions(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Stream<List<ServiceModel>> getServices() {
    return _firestore.collection('services').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ServiceModel.fromMap(doc.data()))
          .toList();
    });
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
      throw FirebaseExceptions(
        message: e.toString(),
        statusCode: 500,
      );
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
      throw FirebaseExceptions(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Future<void> addReview(ReviewModel review) async {
    try {
      await _firestore
          .collection('services')
          .doc(review.serviceId)
          .collection('reviews')
          .add(review.toMap());
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
        message: e.message ?? 'An error occurred',
        statusCode: 500,
      );
    } catch (e) {
      throw FirebaseExceptions(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  @override
  Stream<List<ReviewModel>> getReviews(String serviceId) {
    return _firestore
        .collection('services')
        .doc(serviceId)
        .collection('reviews')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ReviewModel.fromMap(doc.data())).toList();
    });
  }

  @override
  Stream<List<ServiceModel>> getPremiumServices() {
    return _firestore
        .collection('services')
        .where('subVersion', isEqualTo: 'Premium')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ServiceModel.fromMap(doc.data()))
          .toList();
    });
  }
}
