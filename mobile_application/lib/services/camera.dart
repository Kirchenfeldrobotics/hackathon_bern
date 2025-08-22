import 'package:camera/camera.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CameraService {
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isInitialized = false;

  Future<void> initialize() async {
    try {
      cameras = await availableCameras();
      if (cameras!.isEmpty) throw Exception('No camera detected');

      controller = CameraController(cameras![0], ResolutionPreset.medium);
      await controller!.initialize();
      isInitialized = true;
    } catch (e) {
      print('Camera error: $e');
      rethrow;
    }
  }

  Future<String?> takePicture() async {
    if (!isInitialized) return null;

    try {
      final image = await controller!.takePicture();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await File(image.path).copy(imagePath);
      return imagePath;
    } catch (e) {
      print('Picture error: $e');
      return null;
    }
  }

  void dispose() {
    controller?.dispose();
  }
}
