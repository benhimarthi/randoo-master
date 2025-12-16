import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/exceptions.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/service/data/datasources/review_remote_data_source.dart';
import 'package:myapp/features/service/data/datasources/service_remote_data_source.dart';
import 'package:myapp/features/service/data/models/review_model.dart';
import 'package:myapp/features/service/data/models/service_model.dart';
import 'package:myapp/features/service/domain/entities/review.dart';
import 'package:myapp/features/service/domain/entities/service.dart';
import 'package:myapp/features/service/domain/repositories/service_repository.dart';
import '../../../../core/errors/firebase_failure.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource _serviceRemoteDataSource;
  final ReviewRemoteDataSource _reviewRemoteDataSource;

  ServiceRepositoryImpl(
    this._serviceRemoteDataSource,
    this._reviewRemoteDataSource,
  );

  @override
  ResultFuture<void> createService(Service service) async {
    try {
      final serviceModel = ServiceModel.fromEntity(service);
      await _serviceRemoteDataSource.createService(serviceModel);
      return const Right(null);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updateService(Service service) async {
    try {
      final serviceModel = ServiceModel.fromEntity(service);
      await _serviceRemoteDataSource.updateService(serviceModel);
      return const Right(null);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> deleteService(String serviceId) async {
    try {
      await _serviceRemoteDataSource.deleteService(serviceId);
      return const Right(null);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Service>> getServices() async {
    try {
      var result = await _serviceRemoteDataSource.getServices();
      return right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> addReview(Review review) async {
    try {
      final reviewModel = ReviewModel.fromEntity(review);
      await _reviewRemoteDataSource.addReview(reviewModel);
      return const Right(null);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Review>> getReviews(String serviceId) async {
    try {
      var result = await _reviewRemoteDataSource.getReviews(serviceId);
      return right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Service>> getReviewedServices(String userId) async {
    try {
      final result = await _reviewRemoteDataSource.getReviewedServices(userId);
      return right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Service> getServiceById(String serviceId) async {
    try {
      final result = await _serviceRemoteDataSource.getServiceById(serviceId);
      return right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
