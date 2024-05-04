// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UploadApiResponse _$$_UploadApiResponseFromJson(Map<String, dynamic> json) =>
    _$_UploadApiResponse(
      userId: json['userId'] as String,
      projectName: json['projectName'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$_UploadApiResponseToJson(
        _$_UploadApiResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'projectName': instance.projectName,
      'imageUrl': instance.imageUrl,
    };

_$_UploadUrlsResponse _$$_UploadUrlsResponseFromJson(
        Map<String, dynamic> json) =>
    _$_UploadUrlsResponse(
      userId: json['userId'] as String,
      projectName: json['projectName'] as String,
      urls: (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_UploadUrlsResponseToJson(
        _$_UploadUrlsResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'projectName': instance.projectName,
      'urls': instance.urls,
    };
