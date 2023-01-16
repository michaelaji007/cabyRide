// import 'dart:async';
//
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_caby_rider/configs/app_configs.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../../../shared/utils/colors.dart';
//
// class AnswerCall extends StatefulWidget {
//   final String? callerName;
//   final String? channelName;
//   final bool? initiatingCall;
//   final String? receiverToken;
//   AnswerCall(
//       {Key? key,
//       this.callerName,
//       this.channelName,
//       this.initiatingCall,
//       this.receiverToken})
//       : super(key: key);
//
//   @override
//   _AnswerCallState createState() => _AnswerCallState();
// }
//
// class _AnswerCallState extends State<AnswerCall> {
//   AudioPlayer audioPlayer = AudioPlayer();
//   AudioPlayer audioPlayerEnd = AudioPlayer();
//   AudioCache? audioCache;
//   AudioCache? audioCache2;
//   String path = "audio/calling.mp3";
//   RtcEngine? _engine;
//   // ChatState chatState;
//   // LoginState loginState;
//   bool repeatAnimation = true;
//   String stopWatchDisplay = "00:00:00";
//   bool speaker = false;
//   Timer? _timer;
//   int seconds = 0;
//   int minutes = 0;
//   int hours = 0;
//   var swatch = Stopwatch();
//   // void startTimer() {
//   //   const oneSec = const Duration(seconds: 1);
//   //   _timer = new Timer.periodic(oneSec, (Timer timer) {
//   //     if (mounted) {
//   //       setState(
//   //             () {
//   //           if (seconds < 0) {
//   //             timer.cancel();
//   //           } else {
//   //             seconds = seconds + 1;
//   //             if (seconds > 59) {
//   //               minutes += 1;
//   //               seconds = 0;
//   //               if (minutes > 59) {
//   //                 hours += 1;
//   //                 minutes = 0;
//   //               }
//   //             }
//   //           }
//   //         },
//   //       );
//   //     }
//   //   });
//   // }
//   final dur = const Duration(seconds: 1);
//   void startTimer() {
//     _timer = Timer(dur, keepRunning);
//   }
//
//   void keepRunning() {
//     if (swatch.isRunning) {
//       startTimer();
//     }
//     setState(() {
//       stopWatchDisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
//           ":" +
//           (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
//           ":" +
//           (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
//     });
//
// //
//   }
//
//   void startWatch() {
//     swatch.start();
//     startTimer();
//     print("watch called");
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     audioCache = AudioCache();
//     audioCache2 = AudioCache();
//     if (widget.initiatingCall!) {
//       //play sound only if the user is initiating the call before the other party joins
//       playWaitingSound();
//       initializeAgora();
//     }
//   }
//
//   Future<void> initializeAgora() async {
//     try {
//       // Get microphone permission
//       await [Permission.microphone].request();
//
//       RtcEngineContext cont =
//           const RtcEngineContext(appId: AppConstants.agoraAppID);
//       _engine = await RtcEngine.createWithContext(cont);
//
//       _addAgoraEventHandlers();
//
//
//     } on Exception catch (e) {
//       print(e.toString() + " error starting agora");
//     }
//   }
//
//   void _addAgoraEventHandlers() {
//     _engine?.setEventHandler(
//       RtcEngineEventHandler(
//         z: (code) {
//           print(code);
//         },
//         onJoinChannelSuccess: (channel, uid, elapsed) async {
//           print("joined successfully");
//           if (widget.initiatingCall!) {
//             //notify the other user
//             // var res = await chatState.sendFCMNotification(
//             //   senderName: ""
//             //   body: "Tap to answer the call",
//             //   action: "call",
//             //   senderId:"",
//             //   myToken: FirebaseNotificationManager().deviceToken,
//             //   receiverToken: widget.receiverToken,
//             //   title: "${loginState.user.fullName} is calling",
//             //   channelName: widget.channelName,
//             // );
//             // print(res.toString());
//           } else {
//             setState(() {
//               callStatus = "Connected";
//               startWatch();
//             });
//           }
//           setState(() {
//             repeatAnimation = false;
//           });
//         },
//         leaveChannel: (stats) {},
//         userJoined: (uid, elapsed) {
//           if (uid != "") {
//             //stop audio when another user joins the channel so that the involved parties can hear each other
//             if (widget.initiatingCall!) {
//               pauseMusic();
//             }
//
//             setState(() {
//               callStatus = "Connected";
//             });
//             startWatch();
//           }
//         },
//         userOffline: (uid, elapsed) {
//           endCall();
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _engine?.leaveChannel();
//     audioPlayer.release();
//     audioPlayer.dispose();
//     if (_timer != null) {
//       _timer!.cancel();
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           margin: EdgeInsets.symmetric(vertical: 50),
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   Text(
//                     widget.callerName!,
//                     style: TextStyle(
//                         color: Theme.of(context).primaryColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 40.sp),
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Text(
//                     callStatus,
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   callStatus == "Connected"
//                       ? Text(
//                           stopWatchDisplay,
//                           style: TextStyle(
//                               color: AppColors.darkBlue,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 15),
//                         )
//                       : SizedBox()
//                 ],
//               ),
//               CircleAvatar(
//                 backgroundColor: Colors.black12,
//                 radius: 50,
//                 child: Icon(
//                   Icons.person,
//                   size: 75,
//                   color: Colors.black54,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 50,
//                     width: 50,
//                     child: FloatingActionButton(
//                       onPressed: endCall,
//                       child: Icon(
//                         Icons.call_end,
//                         color: Colors.white,
//                         size: 25,
//                       ),
//                       backgroundColor: Colors.red,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 30,
//                   ),
//                   (widget.initiatingCall!)
//                       ? SizedBox()
//                       : Container(
//                           height: 50.w,
//                           width: 50.w,
//                           child: FloatingActionButton(
//                             onPressed: () {
//                               // answer call
//                               initializeAgora();
//
//                               startWatch();
//                             },
//                             child: Icon(
//                               Icons.call,
//                               color: Colors.white,
//                               size: 25.sp,
//                             ),
//                             backgroundColor: Colors.green,
//                           ),
//                         ),
//                   callStatus == "Connected"
//                       ? Container(
//                           height: 40,
//                           width: 40,
//                           child: FloatingActionButton(
//                             onPressed: () async {
//                               // answer call
//                               speaker = !speaker;
//
//                               await _engine!.setEnableSpeakerphone(speaker);
//                               setState(() {});
//                             },
//                             child: Icon(
//                               (!speaker)
//                                   ? Icons.volume_up
//                                   : Icons.speaker_phone,
//                               color: Colors.grey,
//                               size: 25,
//                             ),
//                             backgroundColor: Colors.white,
//                           ),
//                         )
//                       : SizedBox(),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void endCall() async {
//     _engine?.leaveChannel();
//     await playEndCallSound();
//
//     Navigator.pop(context);
//   }
//
//   void answerCall() {}
//   playWaitingSound() async {
//     print("playing sound");
//     // await audioPlayer!.play(path);
//   }
//
//   Future<void> playEndCallSound() async {
//     await audioPlayer.pause();
//     // await audioPlayer.play("audio/end_call.mp3");
//   }
//
//   pauseMusic() async {
//     await audioPlayer.pause();
//   }
//
//   String callStatus = "Connecting";
//   @override
//   void afterFirstLayout(BuildContext context) {
//     // initializeAgora();
//   }
// }
