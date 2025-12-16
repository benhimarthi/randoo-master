import 'package:equatable/equatable.dart';

class Imagestate extends Equatable {
  const Imagestate();
  @override
  List<Object?> get props => [];
}

class ImageInitial extends Imagestate {}

class ImageLoading extends Imagestate {}

class ImageLoaded extends Imagestate {
  final String image;

  const ImageLoaded({required this.image});
}

class ImageError extends Imagestate {
  final String message;

  const ImageError({required this.message});
}
