// import 'package:flutter/material.dart';
// import 'package:pelis_app/providers/movies_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';

// class FullScreenVideo extends StatefulWidget {
//   const FullScreenVideo({super.key});
  
//   @override
//   State<FullScreenVideo> createState() => _FullScreenVideoState();
// }

// class _FullScreenVideoState extends State<FullScreenVideo> {
//   late VideoPlayerController controller;
//   bool isInitialized = false;
  
//   @override
//   void initState() {
//     super.initState();
//     final provider = Provider.of<MoviesProvider>(context);
//     controller = VideoPlayerController.network()
//       ..initialize().then((_) {
//         setState(() {
//           isInitialized = true;
//         });
//         controller
//           ..setVolume(1.0) // Volumen activado
//           ..setLooping(true)
//           ..play();
//       });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: !isInitialized
//             ? 
//             CircularProgressIndicator(strokeWidth: 2)
//             :
//             GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     controller.value.isPlaying ? controller.pause() : controller.play();
//                   });
//                 },
//                 child: AspectRatio(
//                   aspectRatio: controller.value.aspectRatio,
//                   child: VideoPlayer(controller),
//                 ),
//               )
//       ),
//     );
//   }
// }
