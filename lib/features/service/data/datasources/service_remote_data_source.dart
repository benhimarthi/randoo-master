import 'package:myapp/features/service/data/models/review_model.dart';
import 'package:myapp/features/service/data/models/service_model.dart';

abstract class ServiceRemoteDataSource {
  Future<void> createService(ServiceModel service);
  Stream<List<ServiceModel>> getServices();
  Stream<List<ServiceModel>> getPremiumServices();
  Future<void> updateService(ServiceModel service);
  Future<void> deleteService(String serviceId);
  Future<void> addReview(ReviewModel review);
  Stream<List<ReviewModel>> getReviews(String serviceId);
}
