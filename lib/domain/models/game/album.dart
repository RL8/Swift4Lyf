import 'package:freezed_annotation/freezed_annotation.dart';

part 'album.freezed.dart';
part 'album.g.dart';

@freezed
class Album with _$Album {
  const factory Album({
    required String id,
    required String title,
    required String artist,
    required String imageUrl,
    required int releaseYear,
    required bool isTaylorsVersion,
    required Map<String, dynamic> metadata,
  }) = _Album;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
}
