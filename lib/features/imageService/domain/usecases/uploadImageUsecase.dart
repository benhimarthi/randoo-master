import 'package:myapp/core/utils/typedef.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/ImageRepository.dart';

class UploadImageUseCase extends UseCaseWithParam<String, String> {
  final ImageRepository repository;

  UploadImageUseCase(this.repository);

  @override
  ResultFuture<String> call(String params) {
    return repository.uploadImage(params);
  }
}
