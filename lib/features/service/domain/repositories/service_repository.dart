
import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/service/domain/entities/review.dart';
import 'package:myapp/features/service/domain/entities/service.dart';

abstract class ServiceRepository {
  ResultFuture<void> createService(Service service);
  ResultFuture<List<Service>> getServices();
  ResultFuture<void> updateService(Service service);
  ResultFuture<void> deleteService(String serviceId);
  ResultFuture<void> addReview(Review review);
  ResultFuture<List<Review>> getReviews(String serviceId);
}
