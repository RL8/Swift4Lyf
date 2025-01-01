// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlbumImpl _$$AlbumImplFromJson(Map<String, dynamic> json) => _$AlbumImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      imageUrl: json['imageUrl'] as String,
      releaseYear: (json['releaseYear'] as num).toInt(),
      isTaylorsVersion: json['isTaylorsVersion'] as bool,
      metadata: json['metadata'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$AlbumImplToJson(_$AlbumImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'artist': instance.artist,
      'imageUrl': instance.imageUrl,
      'releaseYear': instance.releaseYear,
      'isTaylorsVersion': instance.isTaylorsVersion,
      'metadata': instance.metadata,
    };
