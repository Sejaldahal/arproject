// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});

//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   CameraController? _controller;
//   List<CameraDescription>? _cameras;
//   XFile? _capturedImage;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     try {
//       // Get list of available cameras
//       _cameras = await availableCameras();

//       if (_cameras != null && _cameras!.isNotEmpty) {
//         // Use the first available camera (usually the back camera)
//         _controller = CameraController(
//           _cameras![0],
//           ResolutionPreset.medium,
//         );

//         // Initialize the camera controller
//         await _controller!.initialize();

//         // Update the UI once the controller is initialized
//         if (mounted) {
//           setState(() {});
//         }
//       }
//     } catch (e) {
//       print('Error initializing camera: $e');
//     }
//   }

//   Future<void> _takePicture() async {
//     if (_controller == null || !_controller!.value.isInitialized) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Camera not ready')),
//       );
//       return;
//     }

//     try {
//       final XFile image = await _controller!.takePicture();
//       setState(() {
//         _capturedImage = image;
//       });
//     } catch (e) {
//       print('Error taking picture: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Camera'),
//         backgroundColor: const Color(0xFF8B4513),
//       ),
//       body: Column(
//         children: [
//           // Camera preview
//           Expanded(
//             child: _controller == null
//                 ? const Center(child: CircularProgressIndicator())
//                 : CameraPreview(_controller!),
//           ),

//           // Captured image preview (if any)
//           if (_capturedImage != null)
//             Expanded(
//               child: Image.file(File(_capturedImage!.path)),
//             ),

//           // Camera capture button
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: _takePicture,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF8B4513),
//                 shape: const CircleBorder(),
//                 padding: const EdgeInsets.all(20),
//               ),
//               child: const Icon(
//                 Icons.camera_alt,
//                 color: Colors.white,
//                 size: 30,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

// void main() async {
//   // Ensure that the app is initialized correctly
//   WidgetsFlutterBinding.ensureInitialized();

//   // Get the list of available cameras
//   final cameras = await availableCameras();

//   // Get the first camera (you can choose other cameras based on your needs)
//   final firstCamera = cameras.first;

//   // Run the app and pass the selected camera to the camera preview widget
//   runApp(MyApp(camera: firstCamera));
// }

// class MyApp extends StatelessWidget {
//   final CameraDescription camera;

//   const MyApp({super.key, required this.camera});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CameraScreen(camera: camera),
//     );
//   }
// }

// class CameraScreen extends StatefulWidget {
//   final CameraDescription camera;

//   const CameraScreen({super.key, required this.camera});

//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();

//     // Initialize the camera controller
//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.high, // Set the resolution
//     );

//     // Initialize the camera controller future
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     // Dispose of the controller when the screen is disposed
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Camera Preview")),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             // If the camera is initialized, display the camera preview
//             return CameraPreview(_controller);
//           } else {
//             // Otherwise, show a loading indicator
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
// lib/screens/camera_screen.dart
import 'package:flutter/material.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Camera Screen'),
      ),
    );
  }
}