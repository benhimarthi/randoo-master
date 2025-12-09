import 'package:myapp/features/serviceMetadata/data/models/service_metadata_model.dart';

abstract class ServiceMetadataRemoteDataSource {
  Future<ServiceMetadataModel> getServiceMetadata(String serviceId);
  Future<List<ServiceMetadataModel>> getAllServiceMetadata();
  Future<void> incrementServiceClicks(String serviceId);
  Future<void> updateServiceReview({
    required String serviceId,
    required int rating,
  });
}
