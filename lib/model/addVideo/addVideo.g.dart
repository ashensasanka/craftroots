// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addVideo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddVideo _$AddVideoFromJson(Map<String, dynamic> json) => AddVideo(
      id: json['id'] as String?,
      by: json['by'] as String?,
      level: json['level'] as String?,
      name: json['name'] as String?,
      thumb: json['thumb'] as String?,
      timeStamp: json['timeStamp'] == null
          ? null
          : DateTime.parse(json['timeStamp'] as String),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$AddVideoToJson(AddVideo instance) => <String, dynamic>{
      'id': instance.id,
      'by': instance.by,
      'level': instance.level,
      'name': instance.name,
      'thumb': instance.thumb,
      'timeStamp': instance.timeStamp?.toIso8601String(),
      'url': instance.url,
    };
