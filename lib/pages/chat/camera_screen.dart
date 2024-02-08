import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'camer_view.dart';
import 'video_view.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
    required this.onImageSend,
    required this.cameras,
  });
  final Function onImageSend;
  final List<CameraDescription> cameras;
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool iscamerafront = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(widget.cameras[0], ResolutionPreset.medium);
    cameraValue = _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraValue = cameraValue;
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_cameraController.value.isRecordingVideo) {
      _cameraController.stopVideoRecording();
    }
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_cameraController));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            top: 25.0,
            left: 25.0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28.0),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the screen and navigate back
              },
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(
                            flash ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              flash = !flash;
                            });
                            flash
                                ? _cameraController
                                    .setFlashMode(FlashMode.torch)
                                : _cameraController.setFlashMode(FlashMode.off);
                          }),
                      GestureDetector(
                        onLongPress: () async {
                          if (!_cameraController.value.isRecordingVideo) {
                            _startVideoRecording();
                          }
                        },
                        onLongPressUp: () async {
                          if (_cameraController.value.isRecordingVideo) {
                            _stopVideoRecording();
                          }
                        },
                        onTap: () {
                          if (!isRecording) {
                            takePhoto(context);
                          }
                        },
                        child: isRecording
                            ? const Icon(
                                Icons.radio_button_on,
                                color: Colors.red,
                                size: 80,
                              )
                            : const Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70,
                              ),
                      ),
                      IconButton(
                          icon: Transform.rotate(
                            angle: transform,
                            child: const Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              iscamerafront = !iscamerafront;
                              transform = transform + pi;
                            });
                            int cameraPos = iscamerafront ? 0 : 1;
                            _cameraController = CameraController(
                                widget.cameras[cameraPos],
                                ResolutionPreset.high);
                            cameraValue = _cameraController.initialize();
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "Tap for Photo & longpress for Video",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    XFile file = await _cameraController.takePicture();
    if (!context.mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraViewPage(
                  path: file.path,
                  onImageSend: widget.onImageSend,
                )));
  }

  Future<void> _startVideoRecording() async {
    try {
      await _cameraController.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      print('Error starting video recording: $e');
    }
  }

  Future<void> _stopVideoRecording() async {
    try {
      XFile videoPath = await _cameraController.stopVideoRecording();
      setState(() {
        isRecording = false;
      });
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => VideoViewPage(
            path: videoPath.path,
            onImageSend: widget.onImageSend,
          ),
        ),
      );
    } catch (e) {
      print('Error stopping video recording: $e');
    }
  }
}
