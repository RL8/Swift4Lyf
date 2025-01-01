// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Clue _$ClueFromJson(Map<String, dynamic> json) {
  return _Clue.fromJson(json);
}

/// @nodoc
mixin _$Clue {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get clueType => throw _privateConstructorUsedError;
  DifficultyLevel get difficulty => throw _privateConstructorUsedError;
  double get difficultyRating => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this Clue to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Clue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClueCopyWith<Clue> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClueCopyWith<$Res> {
  factory $ClueCopyWith(Clue value, $Res Function(Clue) then) =
      _$ClueCopyWithImpl<$Res, Clue>;
  @useResult
  $Res call(
      {String id,
      String text,
      String clueType,
      DifficultyLevel difficulty,
      double difficultyRating,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$ClueCopyWithImpl<$Res, $Val extends Clue>
    implements $ClueCopyWith<$Res> {
  _$ClueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Clue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? clueType = null,
    Object? difficulty = null,
    Object? difficultyRating = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      clueType: null == clueType
          ? _value.clueType
          : clueType // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      difficultyRating: null == difficultyRating
          ? _value.difficultyRating
          : difficultyRating // ignore: cast_nullable_to_non_nullable
              as double,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClueImplCopyWith<$Res> implements $ClueCopyWith<$Res> {
  factory _$$ClueImplCopyWith(
          _$ClueImpl value, $Res Function(_$ClueImpl) then) =
      __$$ClueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String text,
      String clueType,
      DifficultyLevel difficulty,
      double difficultyRating,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$ClueImplCopyWithImpl<$Res>
    extends _$ClueCopyWithImpl<$Res, _$ClueImpl>
    implements _$$ClueImplCopyWith<$Res> {
  __$$ClueImplCopyWithImpl(_$ClueImpl _value, $Res Function(_$ClueImpl) _then)
      : super(_value, _then);

  /// Create a copy of Clue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? clueType = null,
    Object? difficulty = null,
    Object? difficultyRating = null,
    Object? metadata = null,
  }) {
    return _then(_$ClueImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      clueType: null == clueType
          ? _value.clueType
          : clueType // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      difficultyRating: null == difficultyRating
          ? _value.difficultyRating
          : difficultyRating // ignore: cast_nullable_to_non_nullable
              as double,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClueImpl implements _Clue {
  const _$ClueImpl(
      {required this.id,
      required this.text,
      required this.clueType,
      required this.difficulty,
      required this.difficultyRating,
      required final Map<String, dynamic> metadata})
      : _metadata = metadata;

  factory _$ClueImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClueImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  final String clueType;
  @override
  final DifficultyLevel difficulty;
  @override
  final double difficultyRating;
  final Map<String, dynamic> _metadata;
  @override
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'Clue(id: $id, text: $text, clueType: $clueType, difficulty: $difficulty, difficultyRating: $difficultyRating, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClueImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.clueType, clueType) ||
                other.clueType == clueType) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.difficultyRating, difficultyRating) ||
                other.difficultyRating == difficultyRating) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, clueType, difficulty,
      difficultyRating, const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of Clue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClueImplCopyWith<_$ClueImpl> get copyWith =>
      __$$ClueImplCopyWithImpl<_$ClueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClueImplToJson(
      this,
    );
  }
}

abstract class _Clue implements Clue {
  const factory _Clue(
      {required final String id,
      required final String text,
      required final String clueType,
      required final DifficultyLevel difficulty,
      required final double difficultyRating,
      required final Map<String, dynamic> metadata}) = _$ClueImpl;

  factory _Clue.fromJson(Map<String, dynamic> json) = _$ClueImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  String get clueType;
  @override
  DifficultyLevel get difficulty;
  @override
  double get difficultyRating;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of Clue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClueImplCopyWith<_$ClueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
