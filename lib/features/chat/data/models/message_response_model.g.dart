// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageResponseModel _$MessageResponseModelFromJson(
        Map<String, dynamic> json) =>
    MessageResponseModel(
      message: json['message'] as String?,
      chat: json['chat'] == null
          ? null
          : Chat.fromJson(json['chat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageResponseModelToJson(
        MessageResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'chat': instance.chat,
    };

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      id: json['_id'] as String?,
      receiverModel: json['receiverModel'] as String?,
      senderId: json['senderId'] == null
          ? null
          : SenderId.fromJson(json['senderId'] as Map<String, dynamic>),
      receiverId: json['receiverId'] == null
          ? null
          : ReceiverId.fromJson(json['receiverId'] as Map<String, dynamic>),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Messages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      '_id': instance.id,
      'receiverModel': instance.receiverModel,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'messages': instance.messages,
    };

Messages _$MessagesFromJson(Map<String, dynamic> json) => Messages(
      body: json['body'] as String?,
      senderId: json['senderId'] == null
          ? null
          : SenderId.fromJson(json['senderId'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$MessagesToJson(Messages instance) => <String, dynamic>{
      'body': instance.body,
      'senderId': instance.senderId,
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

ReceiverId _$ReceiverIdFromJson(Map<String, dynamic> json) => ReceiverId(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      age: json['age'] as num?,
      profilePic: json['profilePic'] == null
          ? null
          : ProfilePic.fromJson(json['profilePic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReceiverIdToJson(ReceiverId instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'age': instance.age,
      'profilePic': instance.profilePic,
    };

SenderId _$SenderIdFromJson(Map<String, dynamic> json) => SenderId(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      age: json['age'] as num?,
      profilePic: json['profilePic'] == null
          ? null
          : ProfilePic.fromJson(json['profilePic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SenderIdToJson(SenderId instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'age': instance.age,
      'profilePic': instance.profilePic,
    };
