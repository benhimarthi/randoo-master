import 'package:myapp/features/service/data/models/service_model.dart';

abstract class ServiceRemoteDataSource {
  Future<void> createService(ServiceModel service);
  Future<List<ServiceModel>> getServices();
  Future<void> updateService(ServiceModel service);
  Future<void> deleteService(String serviceId);
  Future<ServiceModel> getServiceById(String serviceId);
}
