import 'package:json_annotation/json_annotation.dart';

import 'message_user_model.dart';

// part 'message_model.g.dart';

// @JsonSerializable()
// class Message {
//
//   final User user;
//   final int? createdAt;
//   final String id;
//   final Map<String, dynamic>? metadata;
//   final String? remoteId;
//   final Message? repliedMessage;
//   final String? roomId;
//   final bool? showStatus;
//   final MessageType type;
//   final int? updatedAt;
//
//   Message({
//     required this.user,
//     this.createdAt,
//     required this.id,
//     this.metadata,
//     this.remoteId,
//     this.repliedMessage,
//     this.roomId,
//     this.showStatus,
//     required this.type,
//     this.updatedAt,
//   });
//
//   factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
//   Map<String, dynamic> toJson() => _$MessageToJson(this);
// }
//
// enum MessageType {
//   audio,
//   custom,
//   file,
//   image,
//   system,
//   text,
//   unsupported,
//   video
// }