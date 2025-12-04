
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

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final CreateService _createService;
  final GetServices _getServices;
  final UpdateService _updateService;
  final DeleteService _deleteService;
  final AddReview _addReview;
  final GetReviews _getReviews;

  ServiceBloc({
    required CreateService createService,
    required GetServices getServices,
    required UpdateService updateService,
    required DeleteService deleteService,
    required AddReview addReview,
    required GetReviews getReviews,
  })  : _createService = createService,
        _getServices = getServices,
        _updateService = updateService,
        _deleteService = deleteService,
        _addReview = addReview,
        _getReviews = getReviews,
        super(ServiceInitial()) {
    on<CreateServiceEvent>(_createServiceHandler);
    on<GetServicesEvent>(_getServicesHandler);
    on<UpdateServiceEvent>(_updateServiceHandler);
    on<DeleteServiceEvent>(_deleteServiceHandler);
    on<AddReviewEvent>(_addReviewHandler);
    on<GetReviewsEvent>(_getReviewsHandler);
  }

  Future<void> _createServiceHandler(
    CreateServiceEvent event,
    Emitter<ServiceState> emit,
  ) async {
    emit(CreatingService());
    final result = await _createService(event.service);
    result.fold(
      (failure) => emit(ServiceError(failure.errorMessage)),
      (_) => emit(ServiceCreated()),
    );
  }

  Future<void> _getServicesHandler(
    GetServicesEvent event,
    Emitter<ServiceState> emit,
  ) async {
    emit(GettingServices());
    final result = await _getServices();
    result.fold(
      (failure) => emit(ServiceError(failure.errorMessage)),
      (services) => emit(ServicesLoaded(services)),
    );
  }

  Future<void> _updateServiceHandler(
    UpdateServiceEvent event,
    Emitter<ServiceState> emit,
  ) async {
    emit(UpdatingService());
    final result = await _updateService(event.service);
    result.fold(
      (failure) => emit(ServiceError(failure.errorMessage)),
      (_) => emit(ServiceUpdated()),
    );
  }

  Future<void> _deleteServiceHandler(
    DeleteServiceEvent event,
    Emitter<ServiceState> emit,
  ) async {
    emit(DeletingService());
    final result = await _deleteService(event.serviceId);
    result.fold(
      (failure) => emit(ServiceError(failure.errorMessage)),
      (_) => emit(ServiceDeleted()),
    );
  }

  Future<void> _addReviewHandler(
    AddReviewEvent event,
    Emitter<ServiceState> emit,
  ) async {
    emit(AddingReview());
    final result = await _addReview(event.review);
    result.fold(
      (failure) => emit(ServiceError(failure.errorMessage)),
      (_) => emit(ReviewAdded()),
    );
  }

  Future<void> _getReviewsHandler(
    GetReviewsEvent event,
    Emitter<ServiceState> emit,
  ) async {
    emit(GettingReviews());
    final result = await _getReviews(event.serviceId);
    result.fold(
      (failure) => emit(ServiceError(failure.errorMessage)),
      (reviews) => emit(ReviewsLoaded(reviews)),
    );
  }
}
