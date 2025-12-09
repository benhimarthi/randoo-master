import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/features/service/domain/entities/review.dart';
import 'package:myapp/features/service/domain/entities/service.dart';
import 'package:myapp/features/service/domain/usecases/add_review.dart';
import 'package:myapp/features/service/domain/usecases/create_service.dart';
import 'package:myapp/features/service/domain/usecases/delete_service.dart';
import 'package:myapp/features/service/domain/usecases/get_reviews.dart';
import 'package:myapp/features/service/domain/usecases/get_services.dart';
import 'package:myapp/features/service/domain/usecases/update_service.dart';
import 'package:myapp/features/service/domain/usecases/get_reviewed_services.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  final CreateService _createService;
  final GetServices _getServices;
  final UpdateService _updateService;
  final DeleteService _deleteService;
  final AddReview _addReview;
  final GetReviews _getReviews;
  final GetReviewedServices _getReviewedServices;

  StreamSubscription? _servicesSubscription;

  ServiceCubit({
    required CreateService createService,
    required GetServices getServices,
    required UpdateService updateService,
    required DeleteService deleteService,
    required AddReview addReview,
    required GetReviews getReviews,
    required GetReviewedServices getReviewedServices,
  }) : _createService = createService,
       _getServices = getServices,
       _updateService = updateService,
       _deleteService = deleteService,
       _addReview = addReview,
       _getReviews = getReviews,
       _getReviewedServices = getReviewedServices,
       super(ServiceInitial());

  Future<void> createService(Service service) async {
    emit(CreatingService());
    final result = await _createService(service);
    result.fold(
      (failure) => emit(ServiceError(failure.message)),
      (_) => emit(ServiceCreated()),
    );
  }

  Future<void> getServices() async {
    emit(GettingServices());
    var res = await _getServices();
    res.fold(
      (failure) => emit(ServiceError(failure.message)),
      (services) => emit(ServicesLoaded(services)),
    );
  }

  Future<void> updateService(Service service) async {
    emit(UpdatingService());
    final result = await _updateService(service);
    result.fold(
      (failure) => emit(ServiceError(failure.message)),
      (_) => emit(ServiceUpdated()),
    );
  }

  Future<void> deleteService(String serviceId) async {
    emit(DeletingService());
    final result = await _deleteService(serviceId);
    result.fold(
      (failure) => emit(ServiceError(failure.message)),
      (_) => emit(ServiceDeleted()),
    );
  }

  Future<void> addReview(Review review) async {
    final result = await _addReview(review);
    result.fold((failure) => emit(ServiceError(failure.message)), (_) {
      getReviews(review.serviceId);
    });
  }

  Future<void> getReviews(String serviceId) async {
    final result = await _getReviews(serviceId);
    result.fold(
      (failure) => emit(ServiceError(failure.message)),
      (reviews) => emit(ReviewsLoaded(reviews)),
    );
  }

  Future<void> getReviewedServices(String userId) async {
    emit(GettingServices());
    final result = await _getReviewedServices(userId);
    result.fold(
      (failure) => emit(ServiceError(failure.message)),
      (services) => emit(ReviewedServicesLoaded(services)),
    );
  }

  @override
  Future<void> close() {
    _servicesSubscription?.cancel();
    return super.close();
  }
}
