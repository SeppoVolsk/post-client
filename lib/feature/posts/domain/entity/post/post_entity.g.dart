// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostEntity _$$_PostEntityFromJson(Map<String, dynamic> json) =>
    _$_PostEntity(
      id: json['id'] as int,
      name: json['name'] as String,
      preContent: json['preContent'] as String?,
      author: json['author'] == null
          ? null
          : AuthorEntity.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PostEntityToJson(_$_PostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'preContent': instance.preContent,
      'author': instance.author,
    };
