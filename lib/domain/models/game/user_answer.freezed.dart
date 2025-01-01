// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserAnswer _$UserAnswerFromJson(Map<String, dynamic> json) {
  return _UserAnswer.fromJson(json);
}

/// @nodoc
mixin _$UserAnswer {
  String get albumId => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  int get timeSpentSeconds => throw _privateConstructorUsedError;
  int get pointsEarned => throw _privateConstructorUsedError;
  List<String> get cluesUsed => throw _privateConstructorUsedError;

  /// Serializes this UserAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserAnswerCopyWith<UserAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAnswerCopyWith<$Res> {
  factory $UserAnswerCopyWith(
          UserAnswer value, $Res Function(UserAnswer) then) =
      _$UserAnswerCopyWithImpl<$Res, UserAnswer>;
  @useResult
  $Res call(
      {String albumId,
      bool isCorrect,
      int timeSpentSeconds,
      int pointsEarned,
      List<String> cluesUsed});
}

/// @nodoc
class _$UserAnswerCopyWithImpl<$Res, $Val extends UserAnswer>
    implements $UserAnswerCopyWith<$Res> {
  _$UserAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? albumId = null,
    Object? isCorrect = null,
    Object? timeSpentSeconds = null,
    Object? pointsEarned = null,
    Object? cluesUsed = null,
  }) {
    return _then(_value.copyWith(
      albumId: null == albumId
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      timeSpentSeconds: null == timeSpentSeconds
          ? _value.timeSpentSeconds
          : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      cluesUsed: null == cluesUsed
          ? _value.cluesUsed
          : cluesUsed // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserAnswerImplCopyWith<$Res>
    implements $UserAnswerCopyWith<$Res> {
  factory _$$UserAnswerImplCopyWith(
          _$UserAnswerImpl value, $Res Function(_$UserAnswerImpl) then) =
      __$$UserAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String albumId,
      bool isCorrect,
      int timeSpentSeconds,
      int pointsEarned,
      List<String> cluesUsed});
}

/// @nodoc
class __$$UserAnswerImplCopyWithImpl<$Res>
    extends _$UserAnswerCopyWithImpl<$Res, _$UserAnswerImpl>
    implements _$$UserAnswerImplCopyWith<$Res> {
  __$$UserAnswerImplCopyWithImpl(
      _$UserAnswerImpl _value, $Res Function(_$UserAnswerImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? albumId = null,
    Object? isCorrect = null,
    Object? timeSpentSeconds = null,
    Object? pointsEarned = null,
    Object? cluesUsed = null,
  }) {
    return _then(_$UserAnswerImpl(
      albumId: null == albumId
          ? _value.albumId
          : albumId // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      timeSpentSeconds: null == timeSpentSeconds
          ? _value.timeSpentSeconds
          : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      pointsEarned: null == pointsEarned
          ? _value.pointsEarned
          : pointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      cluesUsed: null == cluesUsed
          ? _value._cluesUsed
          : cluesUsed // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAnswerImpl implements _UserAnswer {
  const _$UserAnswerImpl(
      {required this.albumId,
      required this.isCorrect,
      required this.timeSpentSeconds,
      required this.pointsEarned,
      required final List<String> cluesUsed})
      : _cluesUsed = cluesUsed;

  factory _$UserAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAnswerImplFromJson(json);

  @override
  final String albumId;
  @override
  final bool isCorrect;
  @override
  final int timeSpentSeconds;
  @override
  final int pointsEarned;
  final List<String> _cluesUsed;
  @override
  List<String> get cluesUsed {
    if (_cluesUsed is EqualUnmodifiableListView) return _cluesUsed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cluesUsed);
  }

  @override
  String toString() {
    return 'UserAnswer(albumId: $albumId, isCorrect: $isCorrect, timeSpentSeconds: $timeSpentSeconds, pointsEarned: $pointsEarned, cluesUsed: $cluesUsed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAnswerImpl &&
            (identical(other.albumId, albumId) || other.albumId == albumId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.timeSpentSeconds, timeSpentSeconds) ||
                other.timeSpentSeconds == timeSpentSeconds) &&
            (identical(other.pointsEarned, pointsEarned) ||
                other.pointsEarned == pointsEarned) &&
            const DeepCollectionEquality()
                .equals(other._cluesUsed, _cluesUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      albumId,
      isCorrect,
      timeSpentSeconds,
      pointsEarned,
      const DeepCollectionEquality().hash(_cluesUsed));

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAnswerImplCopyWith<_$UserAnswerImpl> get copyWith =>
      __$$UserAnswerImplCopyWithImpl<_$UserAnswerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAnswerImplToJson(
      this,
    );
  }
}

abstract class _UserAnswer implements UserAnswer {
  const factory _UserAnswer(
      {required final String albumId,
      required final bool isCorrect,
      required final int timeSpentSeconds,
      required final int pointsEarned,
      required final List<String> cluesUsed}) = _$UserAnswerImpl;

  factory _UserAnswer.fromJson(Map<String, dynamic> json) =
      _$UserAnswerImpl.fromJson;

  @override
  String get albumId;
  @override
  bool get isCorrect;
  @override
  int get timeSpentSeconds;
  @override
  int get pointsEarned;
  @override
  List<String> get cluesUsed;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserAnswerImplCopyWith<_$UserAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
