import 'package:myapp/core/utils/typedef.dart';

abstract class ImageRepository {
  ResultFuture<String> uploadImage(String path);
}
