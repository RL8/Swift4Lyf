// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameSession _$GameSessionFromJson(Map<String, dynamic> json) {
  return _GameSession.fromJson(json);
}

/// @nodoc
mixin _$GameSession {
  String get id => throw _privateConstructorUsedError;
  DifficultyLevel get difficulty => throw _privateConstructorUsedError;
  List<Album> get selectedAlbums => throw _privateConstructorUsedError;
  int get currentRound => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  Map<String, UserAnswer> get userAnswers => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  Duration get timeRemaining => throw _privateConstructorUsedError;

  /// Serializes this GameSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameSessionCopyWith<GameSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameSessionCopyWith<$Res> {
  factory $GameSessionCopyWith(
          GameSession value, $Res Function(GameSession) then) =
      _$GameSessionCopyWithImpl<$Res, GameSession>;
  @useResult
  $Res call(
      {String id,
      DifficultyLevel difficulty,
      List<Album> selectedAlbums,
      int currentRound,
      int score,
      Map<String, UserAnswer> userAnswers,
      GameStatus status,
      DateTime startTime,
      Duration timeRemaining});
}

/// @nodoc
class _$GameSessionCopyWithImpl<$Res, $Val extends GameSession>
    implements $GameSessionCopyWith<$Res> {
  _$GameSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? difficulty = null,
    Object? selectedAlbums = null,
    Object? currentRound = null,
    Object? score = null,
    Object? userAnswers = null,
    Object? status = null,
    Object? startTime = null,
    Object? timeRemaining = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      selectedAlbums: null == selectedAlbums
          ? _value.selectedAlbums
          : selectedAlbums // ignore: cast_nullable_to_non_nullable
              as List<Album>,
      currentRound: null == currentRound
          ? _value.currentRound
          : currentRound // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      userAnswers: null == userAnswers
          ? _value.userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as Map<String, UserAnswer>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeRemaining: null == timeRemaining
          ? _value.timeRemaining
          : timeRemaining // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameSessionImplCopyWith<$Res>
    implements $GameSessionCopyWith<$Res> {
  factory _$$GameSessionImplCopyWith(
          _$GameSessionImpl value, $Res Function(_$GameSessionImpl) then) =
      __$$GameSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DifficultyLevel difficulty,
      List<Album> selectedAlbums,
      int currentRound,
      int score,
      Map<String, UserAnswer> userAnswers,
      GameStatus status,
      DateTime startTime,
      Duration timeRemaining});
}

/// @nodoc
class __$$GameSessionImplCopyWithImpl<$Res>
    extends _$GameSessionCopyWithImpl<$Res, _$GameSessionImpl>
    implements _$$GameSessionImplCopyWith<$Res> {
  __$$GameSessionImplCopyWithImpl(
      _$GameSessionImpl _value, $Res Function(_$GameSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? difficulty = null,
    Object? selectedAlbums = null,
    Object? currentRound = null,
    Object? score = null,
    Object? userAnswers = null,
    Object? status = null,
    Object? startTime = null,
    Object? timeRemaining = null,
  }) {
    return _then(_$GameSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as DifficultyLevel,
      selectedAlbums: null == selectedAlbums
          ? _value._selectedAlbums
          : selectedAlbums // ignore: cast_nullable_to_non_nullable
              as List<Album>,
      currentRound: null == currentRound
          ? _value.currentRound
          : currentRound // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      userAnswers: null == userAnswers
          ? _value._userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as Map<String, UserAnswer>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeRemaining: null == timeRemaining
          ? _value.timeRemaining
          : timeRemaining // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameSessionImpl implements _GameSession {
  const _$GameSessionImpl(
      {required this.id,
      required this.difficulty,
      required final List<Album> selectedAlbums,
      required this.currentRound,
      required this.score,
      required final Map<String, UserAnswer> userAnswers,
      required this.status,
      required this.startTime,
      this.timeRemaining = const Duration(minutes: 3)})
      : _selectedAlbums = selectedAlbums,
        _userAnswers = userAnswers;

  factory _$GameSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameSessionImplFromJson(json);

  @override
  final String id;
  @override
  final DifficultyLevel difficulty;
  final List<Album> _selectedAlbums;
  @override
  List<Album> get selectedAlbums {
    if (_selectedAlbums is EqualUnmodifiableListView) return _selectedAlbums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedAlbums);
  }

  @override
  final int currentRound;
  @override
  final int score;
  final Map<String, UserAnswer> _userAnswers;
  @override
  Map<String, UserAnswer> get userAnswers {
    if (_userAnswers is EqualUnmodifiableMapView) return _userAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_userAnswers);
  }

  @override
  final GameStatus status;
  @override
  final DateTime startTime;
  @override
  @JsonKey()
  final Duration timeRemaining;

  @override
  String toString() {
    return 'GameSession(id: $id, difficulty: $difficulty, selectedAlbums: $selectedAlbums, currentRound: $currentRound, score: $score, userAnswers: $userAnswers, status: $status, startTime: $startTime, timeRemaining: $timeRemaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            const DeepCollectionEquality()
                .equals(other._selectedAlbums, _selectedAlbums) &&
            (identical(other.currentRound, currentRound) ||
                other.currentRound == currentRound) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality()
                .equals(other._userAnswers, _userAnswers) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.timeRemaining, timeRemaining) ||
                other.timeRemaining == timeRemaining));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      difficulty,
      const DeepCollectionEquality().hash(_selectedAlbums),
      currentRound,
      score,
      const DeepCollectionEquality().hash(_userAnswers),
      status,
      startTime,
      timeRemaining);

  /// Create a copy of GameSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameSessionImplCopyWith<_$GameSessionImpl> get copyWith =>
      __$$GameSessionImplCopyWithImpl<_$GameSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameSessionImplToJson(
      this,
    );
  }
}

abstract class _GameSession implements GameSession {
  const factory _GameSession(
      {required final String id,
      required final DifficultyLevel difficulty,
      required final List<Album> selectedAlbums,
      required final int currentRound,
      required final int score,
      required final Map<String, UserAnswer> userAnswers,
      required final GameStatus status,
      required final DateTime startTime,
      final Duration timeRemaining}) = _$GameSessionImpl;

  factory _GameSession.fromJson(Map<String, dynamic> json) =
      _$GameSessionImpl.fromJson;

  @override
  String get id;
  @override
  DifficultyLevel get difficulty;
  @override
  List<Album> get selectedAlbums;
  @override
  int get currentRound;
  @override
  int get score;
  @override
  Map<String, UserAnswer> get userAnswers;
  @override
  GameStatus get status;
  @override
  DateTime get startTime;
  @override
  Duration get timeRemaining;

  /// Create a copy of GameSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameSessionImplCopyWith<_$GameSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
