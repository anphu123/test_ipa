import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class CustomCameraView extends StatefulWidget {
  final String title;
  final Function(File) onImageCaptured;

  CustomCameraView({
    Key? key,
    required this.onImageCaptured,
    this.title = "Chụp ảnh",
  }) : super(key: key);

  @override
  State<CustomCameraView> createState() => _CustomCameraViewState();
}

class _CustomCameraViewState extends State<CustomCameraView> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  bool _isInitialized = false;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    await _startCamera(_selectedCameraIndex);
  }

  Future<void> _startCamera(int index) async {
    _controller = CameraController(_cameras[index], ResolutionPreset.high);
    await _controller.initialize();
    if (!mounted) return;
    setState(() => _isInitialized = true);
  }

  Future<void> _switchCamera() async {
    if (_cameras.length < 2) return;
    setState(() => _isInitialized = false);
    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
    await _startCamera(_selectedCameraIndex);
  }

  Future<void> _takePicture() async {
    final file = await _controller.takePicture();
    final directory = await getTemporaryDirectory();
    final imagePath = path.join(
      directory.path,
      '${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    final savedImage = await File(file.path).copy(imagePath);
    widget.onImageCaptured(savedImage);
    Get.back();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          _isInitialized
              ? Stack(
                children: [
                  CameraPreview(_controller),

                  // Khung định hướng
                  Align(
                    alignment: Alignment.center,
                    child: AspectRatio(
                      aspectRatio: 5.2,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  // Tiêu đề
                  Positioned(
                    top: 48,
                    left: 16,
                    right: 16,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),

                  // Nút chuyển camera
                  Positioned(
                    top: 40,
                    right: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.cameraswitch,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: _switchCamera,
                    ),
                  ),

                  // Nút chụp
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _takePicture,
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}
