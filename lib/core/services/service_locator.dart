import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

// Auth imports
import 'package:myapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:myapp/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:myapp/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:myapp/features/auth/domain/repositories/auth_repo.dart';
import 'package:myapp/features/auth/domain/usecases/forgot_password.dart';
import 'package:myapp/features/auth/domain/usecases/register.dart';
import 'package:myapp/features/auth/domain/usecases/sign_in.dart';
import 'package:myapp/features/auth/presentation/bloc/auth_bloc.dart';

// Service imports
import 'package:myapp/features/service/data/datasources/service_remote_data_source.dart';
import 'package:myapp/features/service/data/datasources/service_remote_data_source_impl.dart';
import 'package:myapp/features/service/data/repositories/service_repository_impl.dart';
import 'package:myapp/features/service/domain/repositories/service_repository.dart';
import 'package:myapp/features/service/domain/usecases/add_review.dart';
import 'package:myapp/features/service/domain/usecases/create_service.dart';
import 'package:myapp/features/service/domain/usecases/delete_service.dart';
import 'package:myapp/features/service/domain/usecases/get_reviews.dart';
import 'package:myapp/features/service/domain/usecases/get_services.dart';
import 'package:myapp/features/service/domain/usecases/update_service.dart';
import 'package:myapp/features/service/presentation/bloc/service_bloc.dart';

// Service Metadata imports
import 'package:myapp/features/serviceMetadata/data/datasources/service_metadata_remote_data_source.dart';
import 'package:myapp/features/serviceMetadata/data/datasources/service_metadata_remote_data_source_impl.dart';
import 'package:myapp/features/serviceMetadata/data/repositories/service_metadata_repository_impl.dart';
import 'package:myapp/features/serviceMetadata/domain/repositories/service_metadata_repository.dart';
import 'package:myapp/features/serviceMetadata/domain/usecases/get_all_service_metadata.dart';
import 'package:myapp/features/serviceMetadata/domain/usecases/get_service_metadata.dart';
import 'package:myapp/features/serviceMetadata/domain/usecases/increment_service_clicks.dart';
import 'package:myapp/features/serviceMetadata/domain/usecases/update_service_review.dart';
import 'package:myapp/features/serviceMetadata/presentation/bloc/service_metadata_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory(
    () => AuthBloc(signIn: sl(), register: sl(), forgotPassword: sl()),
  );
  sl.registerFactory(
    () => ServiceBloc(
      createService: sl(),
      getServices: sl(),
      updateService: sl(),
      deleteService: sl(),
      addReview: sl(),
      getReviews: sl(),
    ),
  );
  sl.registerFactory(
    () => ServiceMetadataBloc(
      getServiceMetadata: sl(),
      getAllServiceMetadata: sl(),
      incrementServiceClicks: sl(),
      updateServiceReview: sl(),
    ),
  );

  // Use cases
  // Auth
  sl.registerLazySingleton(() => SignIn(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => ForgotPassword(sl()));
  // Service
  sl.registerLazySingleton(() => CreateService(sl()));
  sl.registerLazySingleton(() => GetServices(sl()));
  sl.registerLazySingleton(() => UpdateService(sl()));
  sl.registerLazySingleton(() => DeleteService(sl()));
  sl.registerLazySingleton(() => AddReview(sl()));
  sl.registerLazySingleton(() => GetReviews(sl()));
  // Service Metadata
  sl.registerLazySingleton(() => GetServiceMetadata(sl()));
  sl.registerLazySingleton(() => GetAllServiceMetadata(sl()));
  sl.registerLazySingleton(() => IncrementServiceClicks(sl()));
  sl.registerLazySingleton(() => UpdateServiceReview(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()));
  sl.registerLazySingleton<ServiceRepository>(
    () => ServiceRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ServiceMetadataRepository>(
    () => ServiceMetadataRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ServiceRemoteDataSource>(
    () => ServiceRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ServiceMetadataRemoteDataSource>(
    () => ServiceMetadataRemoteDataSourceImpl(sl()),
  );

  // External
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
