// import 'package:dartz/dartz.dart';
// import 'package:data_connection_checker/data_connection_checker.dart';
// import 'package:primhex/core/error/failures.dart';
// import 'package:primhex/features/chat/api/remote_data.dart';
// import 'package:primhex/features/chat/model/agora_token.dart';
//
// abstract class ChatRepository {
//   Future<Either<Failure, AgoraToken>> getCallToken({channel, token});
//   Future<Either<Failure, AgoraToken>> getMessageToken({channel, token});
//   Future<Either<Failure, int>> sendFCMNotification(
//       {
//         String receiverToken,
//         String myToken,
//         String action,
//         String senderName,
//         String channelName,
//         String message,
//         String senderId,
//         String body,
//         String title
//       });
// }
//
// class ChatRepoImpl implements ChatRepository {
//   @override
//   Future<Either<Failure, AgoraToken>> getCallToken({channel, token}) async {
//     if (await DataConnectionChecker().hasConnection) {
//       try {
//         final res =
//             await ChatImpl().getCallToken(channel: channel, token: token);
//
//         if (res["error"] == false) {
//           return Right(res["token"]);
//         } else {
//           return Left(ServerFailure(res["message"]));
//         }
//       } catch (e) {
//         print(e);
//         return Left(ServerFailure(e));
//       }
//     }
//     return Left(ServerFailure("No internet access"));
//   }
//
//   @override
//   Future<Either<Failure, AgoraToken>> getMessageToken({channel, token}) async {
//     if (await DataConnectionChecker().hasConnection) {
//       try {
//         final res =
//             await ChatImpl().getMessageToken(channel: channel, token: token);
//
//         if (res["error"] == false) {
//           return Right(res["token"]);
//         } else {
//           return Left(ServerFailure(res["message"]));
//         }
//       } catch (e) {
//         print(e);
//         return Left(ServerFailure(e));
//       }
//     }
//     return Left(ServerFailure("No internet access"));
//   }
//
//   @override
//   Future<Either<Failure, int>> sendFCMNotification(
//       { String receiverToken,
//         String myToken,
//         String action,
//         String senderName,
//         String channelName,
//         String message,
//         String senderId,
//         String body,
//         String title}) async {
//     if (await DataConnectionChecker().hasConnection) {
//       try {
//         final res = await ChatImpl().sendFCMNotification(
//             receiverToken: receiverToken,
//             action: action,
//             channelName: channelName,
//             body: body,
//             title: title,
//             senderId: senderId,
//           senderName: senderName,
//           message: message,
//             myToken: myToken
//         );
//
//         if (res["error"] == false) {
//           return Right(res["token"]);
//         } else {
//           return Left(ServerFailure(res["message"]));
//         }
//       } catch (e) {
//         print(e);
//         return Left(ServerFailure(e));
//       }
//     }
//     return Left(ServerFailure("No internet access"));
//   }
// }
