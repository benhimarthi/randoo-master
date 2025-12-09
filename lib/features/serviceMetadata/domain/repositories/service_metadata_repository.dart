import 'package:myapp/core/utils/typedef.dart';
import 'package:myapp/features/serviceMetadata/domain/entities/service_metadata.dart';

abstract class ServiceMetadataRepository {
  ResultFuture<ServiceMetadata> getServiceMetadata(String serviceId);
  ResultFuture<List<ServiceMetadata>> getAllServiceMetadata();
  ResultVoid incrementServiceClicks(String serviceId);
  ResultVoid updateServiceReview({
    required String serviceId,
    required int rating,
  });
}
