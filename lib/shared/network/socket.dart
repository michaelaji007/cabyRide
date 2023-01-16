// import 'package:socket_io_client/socket_io_client.dart';
//
// import '../utils/storage.dart';
//
// class SocketIO {
//   Socket? socket;
//   Future<void> init() async {
//     print("have been initialed");
//     var token = "Bearer ${await UserTokenManager.getAccessToken()}";
//     try {
//       socket = io(
//               "wss://zepta-api-eqtxqyoupa-ez.a.run.app",
//               OptionBuilder().setTransports(['websocket']).setExtraHeaders(
//                   {'authorization': token}).build())
//           .connect();
//       socket!.onConnect((ff) {
//         print("connect:${socket!.connected}");
//         socket!.on('GET_FEEDS', (data) {
//           print("Joined $data");
//         });
//       });
//
//       socket!.on('GET_FEEDS', (data) {
//         print("Joined $data");
//       });
//       // socket!.em
//
//       socket!.onConnectError(pprint);
//       socket!.onConnectTimeout((xx) {
//         print("Socket Timeout: ${xx}");
//         print("Socket Timeout ${socket!.disconnected}");
//         socket!.connect();
//       });
//       socket!.onError(pprint);
//       socket!.onDisconnect((socket1) {
//         print("Socket Disconnected $socket1");
//         socket!.connect();
//       });
//     } catch (e) {
//       print('error==>${e.toString()}');
//     }
//   }
//
//   pprint(data) {
//     print("$data");
//
//     if (data is Map) {
//       print("socket222 is connected ");
//     }
//   }
// }
