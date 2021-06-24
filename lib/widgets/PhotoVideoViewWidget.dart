// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:teemates/app/app_routes.dart';
// import 'package:teemates/appresources/app_colors.dart';
// import 'package:teemates/appresources/app_constants.dart';
// import 'package:teemates/utils/Util.dart';
// import 'package:teemates/views/social/create_post_view.dart';
// import 'package:video_player/video_player.dart';
//
// class PhotoVideoViewWidget extends StatelessWidget {
//   final FileModel model;
//
//   // final Function onDeleteTap;
//   final ValueChanged<FileModel> onDeleteTap;
//
//   const PhotoVideoViewWidget({Key key, this.model, this.onDeleteTap})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return model.type == "video"
//         ? VideoViewWidget(model: model, onDeleteTap: onDeleteTap)
//         : Container(
//           child: Stack(
//       children: [
//           Container(
//             margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
//             width: 80.0,
//             height: 80.0,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: Theme
//                   .of(context)
//                   .scaffoldBackgroundColor,
//               border: Border.all(
//                 color: Theme
//                     .of(context)
//                     .textTheme
//                     .headline4
//                     .color, //                   <--- border color
//                 width: 1.0,
//               ),
//             ),
//             child: model.mediaUrl == null ? ClipRRect(
//                 borderRadius: BorderRadius.circular(10.0),
//                 child: Image.file(
//                   File(model.file.path),
//                   fit: BoxFit.cover,
//                   width: 80.0,
//                   height: 80.0,
//                 )
//             ) : ClipRRect(
//                 borderRadius: BorderRadius.circular(10.0),
//                 child: Image.network(
//                   model.mediaUrl,
//                   fit: BoxFit.cover,
//                   width: 80.0,
//                   height: 80.0,
//                 )
//             ),
//           ),
//
//           Positioned(
//             right: 1.0,
//             top: 0.0,
//             child: Container(
//                 height: 20,
//                 width: 20,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.green,
//                 ),
//                 child: InkWell(
//                     onTap: () {
//                       onDeleteTap(model);
//                     },
//                     child: Icon(Icons.clear, size: 17.0, color: Colors.white,))
//             ),
//           ),
//       ],
//     ),
//         );
//   }
// }
//
// class VideoViewWidget extends StatefulWidget {
//
//   final FileModel model;
//   final ValueChanged<FileModel> onDeleteTap;
//
//   VideoViewWidget({this.model, this.onDeleteTap});
//   @override
//   _VideoViewWidgetState createState() => _VideoViewWidgetState();
// }
//
// class _VideoViewWidgetState extends State<VideoViewWidget> {
//
//   VideoPlayerController _controller;
//
//   int fileSize = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     print('VIDEO URLLLL =======> ${widget.model.mediaUrl}');
//
//     _controller = widget.model.mediaUrl == null ? VideoPlayerController.file(
//         File(widget.model.file.path)) : VideoPlayerController.network(
//         widget.model.mediaUrl);
//     _controller.addListener(() {
//       if (_controller.value.position == _controller.value.duration) {
//         setState(() {
//           // started = false;
//         });
//       }
//     });
//     _controller.initialize().then((_) => setState(() {}));
//
//     _controller.play();
//
//     Timer(Duration(seconds: 1), () {
//       _controller.pause();
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery
//         .of(context)
//         .size;
//
//     // calculate scale for aspect ratio widget
//     var scale = _controller.value.aspectRatio / size.aspectRatio;
//
//     // check if adjustments are needed...
//     if (_controller.value.aspectRatio < size.aspectRatio) {
//       scale = 1 / scale;
//     }
//
//     if (widget.model.file != null) {
//       fileSize = widget.model.file
//           .size; //Util.getFileSize(widget.model.file.size, 1);
//       print(widget.model.file.size);
//     }
//
//     return Stack(
//       children: [
//         widget.model.file != null ? Container(
//           margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
//           width: 80.0,
//           height: 80.0,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12.0),
//             color: Theme
//                 .of(context)
//                 .scaffoldBackgroundColor,
//             border: Border.all(
//               color: (fileSize > 25000000) ? Colors.red : Theme
//                   .of(context)
//                   .textTheme
//                   .headline4
//                   .color, //                   <--- border color
//               width: (fileSize > 25000000) ? 2.0 : 1.0,
//             ),
//           ),
//           child: Center(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10.0),
//               child: _controller.value.initialized
//                   ? VideoPlayer(_controller,)
//                   : Container(),
//             ),
//           ),
//         )
//             : ClipRRect(
//             borderRadius: BorderRadius.circular(10.0),
//             child: Image.network(
//               (widget.model.videoThumbanil == null) ? AppConstants.NULL_IMAGE_PLACEHOLDER : widget.model.videoThumbanil,
//               fit: BoxFit.cover,
//               width: 80.0,
//               height: 80.0,
//             )
//         ),
//
//         Positioned(
//           right: 0.0,
//           top: 0.0,
//           bottom: 0.0,
//           left: 0.0,
//           child: IconButton(
//             splashColor: Colors.transparent,
//             icon: Icon(Icons.play_circle_fill, color: Colors.grey,),
//              onPressed: () async {
// //               print(widget.model.mediaUrl);
// //
// //               Map<String, dynamic> map = {
// //                 "title": 'Video',
// //                 "path": widget.model.mediaUrl
// //               };
// //               Navigator.pushNamed(context, AppRoutes.FULL_VIDEO_VIEW, arguments: map);
//
//              }
//           ),
//         ),
//
//         Positioned(
//           right: 1.0,
//           top: 0.0,
//           child: Container(
//               height: 20,
//               width: 20,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.green,
//               ),
//               child: InkWell(
//                   onTap: () {
//                     widget.onDeleteTap(widget.model);
//
//
//                   },
//                   child: Icon(Icons.clear, size: 17.0, color: Colors.white,))
//           ),),
//       ],
//     );
//   }
// }
