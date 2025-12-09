import 'package:myapp/features/service/data/models/service_model.dart';

import '../models/review_model.dart';

abstract class ServiceRemoteDataSource {
  Future<void> createService(ServiceModel service);
  Future<List<ServiceModel>> getServices();
  Future<void> updateService(ServiceModel service);
  Future<void> deleteService(String serviceId);
  Future<void> addReview(ReviewModel review);
  Stream<List<ReviewModel>> getReviews(String serviceId);
}
