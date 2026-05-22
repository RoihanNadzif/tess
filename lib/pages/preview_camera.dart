import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PreviewCamera extends StatefulWidget {
  final List<CameraDescription> cameras;
  const PreviewCamera({super.key, required this.cameras});
  @override
  State<PreviewCamera> createState() => _PreviewCameraState();
}

class _PreviewCameraState extends State<PreviewCamera> {
  late CameraController _cameraController;
  late Future<void> _initializecameracontroller;
  int _kameraIndex = 0;

  void _initCamera(CameraDescription cameraDescription) {
    _cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.high,
    );
    _initializecameracontroller = _cameraController.initialize();
  }

  @override
  void initState() {
    super.initState();
    _initCamera(widget.cameras[_kameraIndex]);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kamera")),

      body: FutureBuilder<void>(
        future: _initializecameracontroller,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(children: 
            [
              CameraPreview(_cameraController)
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}