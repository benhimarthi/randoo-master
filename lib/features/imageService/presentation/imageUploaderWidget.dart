import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'cubit/imageCubit.dart';
import 'cubit/imageState.dart';
import 'image.carousel.dart';

class ImageUploaderWidget extends StatefulWidget {
  final bool displayUploadBtn;
  const ImageUploaderWidget({super.key, required this.displayUploadBtn});

  @override
  State<ImageUploaderWidget> createState() => _ImageUploaderWidgetState();
}

class _ImageUploaderWidgetState extends State<ImageUploaderWidget> {
  bool loading = false;
  String? preview;
  late List<String> myImages;

  @override
  void initState() {
    super.initState();
    myImages = [];
  }

  Future<void> pickAndUpload() async {
    final status = await getStoragePermission();
    if (status.isGranted) {
      // Proceed to pick images
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);

      if (image == null) return;
      context.read<Imagecubit>().uploadImage(image.path);
    } else {}
  }

  Future<PermissionStatus> getStoragePermission() async {
    if (Platform.isAndroid) {
      //final androidInfo = await DeviceInfoPlugin().androidInfo;
      /*if (androidInfo.version.sdkInt <= 32) {
        return await Permission.storage.status;
      } else {
        return await Permission.photos.status;
      }*/
      return PermissionStatus.granted;
    } else if (Platform.isIOS) {
      return await Permission.photos.status;
    } else {
      return PermissionStatus.granted; // For other platforms
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Imagecubit, Imagestate>(
      listener: (context, state) {
        if (state is ImageLoading) {
          loading = true;
        }
        if (state is ImageLoaded) {
          loading = false;
          preview = state.image;

          setState(() {
            myImages.add(state.image);
          });
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            ImageCarousel(imageUrls: myImages, height: 200, autoPlay: false),
            const SizedBox(height: 12),
            if (widget.displayUploadBtn)
              ElevatedButton(
                onPressed: loading ? null : pickAndUpload,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Upload Image"),
              ),
          ],
        );
      },
    );
  }
}
