import 'package:myapp/features/service/data/models/review_model.dart';
import 'package:myapp/features/service/data/models/service_model.dart';

abstract class ReviewRemoteDataSource {
  Future<void> addReview(ReviewModel review);
  Future<List<ReviewModel>> getReviews(String serviceId);
  Future<List<ServiceModel>> getReviewedServices(String userId);
}
