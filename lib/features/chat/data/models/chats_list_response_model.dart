import 'package:json_annotation/json_annotation.dart';
import 'package:translators/features/chat/data/models/message_response_model.dart';

part 'chats_list_response_model.g.dart';

@JsonSerializable()
class ChatsListResponseModel {
  final String? message;
  final List<Chats>? chats;

  ChatsListResponseModel({
    this.message,
    this.chats,
  });

  factory ChatsListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChatsListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatsListResponseModelToJson(this);
}

@JsonSerializable()
class Chats {
  @JsonKey(name: '_id')
  final String? id;
  final SenderId? senderId;
  final ReceiverId? receiverId;
  final String? receiverModel;
  final List<Messages>? messages;
  final String? mediaCloudFolder;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int v;

  Chats({
    this.id,
    this.senderId,
    this.receiverId,
    this.receiverModel,
    this.messages,
    this.mediaCloudFolder,
    this.createdAt,
    this.updatedAt,
    required this.v,
  });

  factory Chats.fromJson(Map<String, dynamic> json) => _$ChatsFromJson(json);

  Map<String, dynamic> toJson() => _$ChatsToJson(this);
}
