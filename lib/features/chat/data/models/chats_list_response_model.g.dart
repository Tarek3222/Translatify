// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatsListResponseModel _$ChatsListResponseModelFromJson(
        Map<String, dynamic> json) =>
    ChatsListResponseModel(
      message: json['message'] as String?,
      chats: (json['chats'] as List<dynamic>?)
          ?.map((e) => Chats.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatsListResponseModelToJson(
        ChatsListResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'chats': instance.chats,
    };

Chats _$ChatsFromJson(Map<String, dynamic> json) => Chats(
      id: json['_id'] as String?,
      senderId: json['senderId'] == null
          ? null
          : SenderId.fromJson(json['senderId'] as Map<String, dynamic>),
      receiverId: json['receiverId'] == null
          ? null
          : ReceiverId.fromJson(json['receiverId'] as Map<String, dynamic>),
      receiverModel: json['receiverModel'] as String?,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Messages.fromJson(e as Map<String, dynamic>))
          .toList(),
      mediaCloudFolder: json['mediaCloudFolder'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$ChatsToJson(Chats instance) => <String, dynamic>{
      '_id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'receiverModel': instance.receiverModel,
      'messages': instance.messages,
      'mediaCloudFolder': instance.mediaCloudFolder,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
