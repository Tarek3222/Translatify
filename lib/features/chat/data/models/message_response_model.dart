import 'package:json_annotation/json_annotation.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
part "message_response_model.g.dart";

@JsonSerializable()
class MessageResponseModel {
  final String? message;
  final Chat? chat;

  MessageResponseModel({
    this.message,
    this.chat,
  });

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResponseModelToJson(this);
}

@JsonSerializable()
class Chat {
  @JsonKey(name: "_id")
  final String? id;
  final String? receiverModel;
  final SenderId? senderId;
  final ReceiverId? receiverId;
  final List<Messages>? messages;

  Chat({
    this.id,
    this.receiverModel,
    this.senderId,
    this.receiverId,
    this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}

@JsonSerializable()
class Messages {
  final String? body;
  final SenderId? senderId;
  @JsonKey(name: "_id")
  final String? id;
  final String? createdAt;
  final String? updatedAt;

  Messages({
    this.body,
    this.senderId,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Messages.fromJson(Map<String, dynamic> json) =>
      _$MessagesFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesToJson(this);
}

@JsonSerializable()
class ReceiverId {
  @JsonKey(name: "_id")
  final String? id;
  final String? name;
  final String? email;
  final num? age;
  final ProfilePic? profilePic;

  ReceiverId({
    this.id,
    this.name,
    this.email,
    this.age,
    this.profilePic,
  });
  factory ReceiverId.fromJson(Map<String, dynamic> json) =>
      _$ReceiverIdFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiverIdToJson(this);
}

@JsonSerializable()
class SenderId {
  @JsonKey(name: "_id")
  final String? id;
  final String? name;
  final String? email;
  final num? age;
  final ProfilePic? profilePic;

  SenderId({
    this.id,
    this.name,
    this.email,
    this.age,
    this.profilePic,
  });
  factory SenderId.fromJson(Map<String, dynamic> json) =>
      _$SenderIdFromJson(json);

  Map<String, dynamic> toJson() => _$SenderIdToJson(this);
}
