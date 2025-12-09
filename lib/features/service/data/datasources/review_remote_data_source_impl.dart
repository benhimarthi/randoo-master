import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/core/errors/firebase_failure.dart';
import 'package:myapp/features/service/data/datasources/review_remote_data_source.dart';
import 'package:myapp/features/service/data/models/review_model.dart';
import 'package:myapp/features/service/data/models/service_model.dart';

import '../../../../core/errors/exceptions.dart';

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final FirebaseFirestore _firestore;

  ReviewRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> addReview(ReviewModel review) async {
    try {
      await _firestore.collection('reviews').add(review.toMap());
    } on FirebaseExceptions catch (e) {
      throw FirebaseFailure.fromException(e);
    }
  }

  @override
  Future<List<ReviewModel>> getReviews(String serviceId) async {
    try {
      var reviews = await _firestore.collection('reviews').get();
      return reviews.docs
          .map((doc) => ReviewModel.fromMap(doc.data()))
          .toList();
    } on FirebaseExceptions catch (e) {
      throw FirebaseFailure.fromException(e);
    }
  }

  @override
  Future<List<ServiceModel>> getReviewedServices(String userId) async {
    try {
      //serviceIds
      final reviewsQuery = await _firestore
          .collection('reviews')
          .where('userId', isEqualTo: userId)
          .get();

      print("TTTTTTTTTTTTTTTTTTTTTTTTTTTT ${reviewsQuery.size}");

      final serviceIds = reviewsQuery.docs
          .map((doc) => doc.data()['serviceId'] as String)
          .toSet()
          .toList();

      final services = <ServiceModel>[];
      for (final serviceId in serviceIds) {
        final serviceDoc = await _firestore
            .collection('services')
            .doc(serviceId)
            .get();
        if (serviceDoc.exists) {
          services.add(ServiceModel.fromMap(serviceDoc.data()!));
        }
      }
      return services;
    } on FirebaseExceptions catch (e) {
      throw FirebaseFailure.fromException(e);
    }
  }
}
