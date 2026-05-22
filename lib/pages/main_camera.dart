import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tess/pages/preview_camera.dart';

class MainCamera extends StatefulWidget {
  final List<CameraDescription> cameras;
  const MainCamera({super.key, required this.cameras});

  @override
  State<MainCamera> createState() => _MainCameraState();
}

class _MainCameraState extends State<MainCamera> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (_) => 
      PreviewCamera(cameras: widget.cameras))), icon: Icon(Icons.camera_alt)),
    );
  }
}
