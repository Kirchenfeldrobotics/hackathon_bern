import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mobile_application/services/camera.dart';
import 'package:mobile_application/services/api.dart';
 
class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);
 
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}
 
class _CameraScreenState extends State<CameraScreen> {
  final CameraService _cameraService = CameraService();
  final ApiService _apiService = ApiService();
 
  bool _isLoading = true;
  String? _error;
  String? _result; // Ergebnis vom Raspberry Pi
 
  @override
  void initState() {
    super.initState();
    _initCamera();
  }
 
  Future<void> _initCamera() async {
    try {
      await _cameraService.initialize();
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }
 
Future<void> _takePicture() async {
  final imagePath = await _cameraService.takePicture();
  if (imagePath != null) {
    setState(() {
      _result = "Foto wird analysiert...";
    });

    _apiService.uploadImage(imagePath).then((response) {
      setState(() {
        _result = response ?? "Keine Antwort vom Server";
      });
    }).catchError((e) {
      setState(() {
        _result = "Fehler bei der Analyse: $e";
      });
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fehler beim Foto')));
  }
}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Kamera'),
      ),
      body: _buildBody(),
    );
  }
 
  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }
 
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(_error!, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _error = null;
                  _isLoading = true;
                });
                _initCamera();
              },
              child: const Text('Erneut versuchen'),
            ),
          ],
        ),
      );
    }
    return Stack(
      children: [
        // Camera preview
        Positioned.fill(child: CameraPreview(_cameraService.controller!)),
 
        // Ergebnis-Anzeige
        if (_result != null)
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _result!,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
 
        // Button to take picture
        Positioned(top:30, 
        right:30,
        child: Center(
          child: GestureDetector(
            onTap: null,
            child: Container(
              width: 20,
              height: 10,
              
        child: const Icon(Icons.keyboard_return, size: 40, color: Colors.black),
        ),
        ),
        ),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: _takePicture,
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(Icons.camera, size: 40, color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
 
  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }
}
