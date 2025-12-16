import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/imageService/domain/usecases/uploadImageUsecase.dart';
import 'package:myapp/features/imageService/presentation/cubit/imageState.dart';

class Imagecubit extends Cubit<Imagestate> {
  final UploadImageUseCase _uploadImage;

  Imagecubit({required UploadImageUseCase uploadImages})
    : _uploadImage = uploadImages,
      super(ImageInitial());

  Future<void> uploadImage(String imagePath) async {
    emit(ImageLoading());
    final result = await _uploadImage(imagePath);
    result.fold(
      (failure) => emit(ImageError(message: failure.message)),
      (imageUrl) => emit(ImageLoaded(image: imageUrl)),
    );
  }
}
