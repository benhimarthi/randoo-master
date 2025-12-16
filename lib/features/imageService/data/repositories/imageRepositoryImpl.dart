import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:myapp/core/errors/exceptions.dart';
import 'package:myapp/core/errors/firebase_failure.dart';
import 'package:myapp/core/utils/typedef.dart';

import '../../domain/repositories/ImageRepository.dart';

class ImagerepositoryImpl implements ImageRepository {
  FirebaseStorage storage;

  ImagerepositoryImpl(this.storage);
  @override
  ResultFuture<String> uploadImage(String path) async {
    try {
      final file = File(path);
      final name = "uploads/${DateTime.now().millisecondsSinceEpoch}.jpg";

      final uploadTask = await storage.ref(name).putFile(file);
      final url = await uploadTask.ref.getDownloadURL();

      return Right(url);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
