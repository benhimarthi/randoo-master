import 'package:dartz/dartz.dart';
import 'package:myapp/core/errors/exceptions.dart';
import 'package:myapp/core/errors/firebase_failure.dart';
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/serviceMetadata/data/datasources/service_metadata_remote_data_source.dart';
import 'package:myapp/features/serviceMetadata/domain/entities/service_metadata.dart';
import 'package:myapp/features/serviceMetadata/domain/repositories/service_metadata_repository.dart';

class ServiceMetadataRepositoryImpl implements ServiceMetadataRepository {
  final ServiceMetadataRemoteDataSource remoteDataSource;

  ServiceMetadataRepositoryImpl(this.remoteDataSource);

  @override
  ResultFuture<ServiceMetadata> getServiceMetadata(String serviceId) async {
    try {
      final result = await remoteDataSource.getServiceMetadata(serviceId);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> incrementServiceClicks(String serviceId) async {
    try {
      final result = await remoteDataSource.incrementServiceClicks(serviceId);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updateServiceReview({
    required String serviceId,
    required int rating,
  }) async {
    try {
      final result = await remoteDataSource.updateServiceReview(
        serviceId: serviceId,
        rating: rating,
      );
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ServiceMetadata>> getAllServiceMetadata() async {
    try {
      final result = await remoteDataSource.getAllServiceMetadata();
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
