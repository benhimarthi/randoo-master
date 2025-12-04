import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/features/serviceMetadata/domain/entities/service_metadata.dart';
import 'package:myapp/features/serviceMetadata/domain/usecases/get_all_service_metadata.dart';
import 'package:myapp/features/serviceMetadata/domain/usecases/get_service_metadata.dart';
import 'package:myapp/features/serviceMetadata/domain/usecases/increment_service_clicks.dart';
import 'package:myapp/features/serviceMetadata/domain/usecases/update_service_review.dart';

part 'service_metadata_event.dart';
part 'service_metadata_state.dart';

class ServiceMetadataBloc
    extends Bloc<ServiceMetadataEvent, ServiceMetadataState> {
  final GetServiceMetadata _getServiceMetadata;
  final GetAllServiceMetadata _getAllServiceMetadata;
  final IncrementServiceClicks _incrementServiceClicks;
  final UpdateServiceReview _updateServiceReview;

  ServiceMetadataBloc({
    required GetServiceMetadata getServiceMetadata,
    required GetAllServiceMetadata getAllServiceMetadata,
    required IncrementServiceClicks incrementServiceClicks,
    required UpdateServiceReview updateServiceReview,
  }) : _getServiceMetadata = getServiceMetadata,
       _getAllServiceMetadata = getAllServiceMetadata,
       _incrementServiceClicks = incrementServiceClicks,
       _updateServiceReview = updateServiceReview,
       super(ServiceMetadataInitial()) {
    on<GetServiceMetadataEvent>(_onGetServiceMetadata);
    on<GetAllServiceMetadataEvent>(_onGetAllServiceMetadata);
    on<IncrementServiceClicksEvent>(_onIncrementServiceClicks);
    on<UpdateServiceReviewEvent>(_onUpdateServiceReview);
  }

  Future<void> _onGetServiceMetadata(
    GetServiceMetadataEvent event,
    Emitter<ServiceMetadataState> emit,
  ) async {
    emit(ServiceMetadataLoading());
    final result = await _getServiceMetadata(event.serviceId);
    result.fold(
      (failure) => emit(ServiceMetadataError(failure.errorMessage)),
      (metadata) => emit(ServiceMetadataLoaded(metadata)),
    );
  }

  Future<void> _onGetAllServiceMetadata(
    GetAllServiceMetadataEvent event,
    Emitter<ServiceMetadataState> emit,
  ) async {
    emit(ServiceMetadataLoading());
    final result = await _getAllServiceMetadata();
    result.fold(
      (failure) => emit(ServiceMetadataError(failure.errorMessage)),
      (metadata) => emit(AllServiceMetadataLoaded(metadata)),
    );
  }

  Future<void> _onIncrementServiceClicks(
    IncrementServiceClicksEvent event,
    Emitter<ServiceMetadataState> emit,
  ) async {
    final result = await _incrementServiceClicks(event.serviceId);
    result.fold(
      (failure) => emit(ServiceMetadataError(failure.errorMessage)),
      (_) => add(GetAllServiceMetadataEvent()),
    );
  }

  Future<void> _onUpdateServiceReview(
    UpdateServiceReviewEvent event,
    Emitter<ServiceMetadataState> emit,
  ) async {
    final result = await _updateServiceReview(
      UpdateServiceReviewParams(
        serviceId: event.serviceId,
        rating: event.rating,
      ),
    );
    result.fold(
      (failure) => emit(ServiceMetadataError(failure.errorMessage)),
      (_) => add(GetAllServiceMetadataEvent()),
    );
  }
}
