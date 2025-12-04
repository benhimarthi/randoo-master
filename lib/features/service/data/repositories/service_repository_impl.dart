import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/firebase_failure.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/service/data/models/review_model.dart';
import 'package:myapp/features/service/data/models/service_model.dart';
import 'package:myapp/features/service/domain/entities/review.dart';
import 'package:myapp/features/service/domain/entities/service.dart';
import 'package:myapp/features/service/domain/repositories/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final FirebaseFirestore _firestore;

  ServiceRepositoryImpl(this._firestore);

  @override
  ResultFuture<void> createService(Service service) async {
    try {
      final serviceModel = ServiceModel(
        id: service.id,
        name: service.name,
        description: service.description,
        category: service.category,
        town: service.town,
        address: service.address,
        phoneNumber: service.phoneNumber,
        email: service.email,
        ownerId: service.ownerId,
        imageUrls: service.imageUrls,
        averageRating: service.averageRating,
        createdAt: service.createdAt,
        status: service.status,
        subVersion: service.subVersion,
      );
      await _firestore
          .collection('services')
          .doc(serviceModel.id)
          .set(serviceModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(
        FirebaseFailure(message: e.message ?? 'Unknown error', statusCode: 500),
      );
    }
  }

  @override
  ResultFuture<List<Service>> getServices() async {
    try {
      final snapshot = await _firestore.collection('services').get();
      final services =
          snapshot.docs.map((doc) => ServiceModel.fromMap(doc.data())).toList();
      return Right(services);
    } on FirebaseException catch (e) {
      return Left(
        FirebaseFailure(message: e.message ?? 'Unknown error', statusCode: 500),
      );
    }
  }

  @override
  ResultFuture<void> updateService(Service service) async {
    try {
      final serviceModel = ServiceModel(
        id: service.id,
        name: service.name,
        description: service.description,
        category: service.category,
        town: service.town,
        address: service.address,
        phoneNumber: service.phoneNumber,
        email: service.email,
        ownerId: service.ownerId,
        imageUrls: service.imageUrls,
        averageRating: service.averageRating,
        createdAt: service.createdAt,
        status: service.status,
        subVersion: service.subVersion,
      );
      await _firestore
          .collection('services')
          .doc(serviceModel.id)
          .update(serviceModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(
        FirebaseFailure(message: e.message ?? 'Unknown error', statusCode: 500),
      );
    }
  }

  @override
  ResultFuture<void> deleteService(String serviceId) async {
    try {
      await _firestore.collection('services').doc(serviceId).delete();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(
        FirebaseFailure(message: e.message ?? 'Unknown error', statusCode: 500),
      );
    }
  }

  @override
  ResultFuture<void> addReview(Review review) async {
    try {
      final reviewModel = ReviewModel(
        id: review.id,
        serviceId: review.serviceId,
        userId: review.userId,
        rating: review.rating,
        comment: review.comment,
        createdAt: review.createdAt,
      );
      await _firestore
          .collection('reviews')
          .doc(reviewModel.id)
          .set(reviewModel.toMap());
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(
        FirebaseFailure(message: e.message ?? 'Unknown error', statusCode: 500),
      );
    }
  }

  @override
  ResultFuture<List<Review>> getReviews(String serviceId) async {
    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where('serviceId', isEqualTo: serviceId)
          .get();
      final reviews =
          snapshot.docs.map((doc) => ReviewModel.fromMap(doc.data())).toList();
      return Right(reviews);
    } on FirebaseException catch (e) {
      return Left(
        FirebaseFailure(message: e.message ?? 'Unknown error', statusCode: 500),
      );
    }
  }
}
