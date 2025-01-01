// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GameState {
  GameSession get currentSession => throw _privateConstructorUsedError;
  List<Clue> get availableClues => throw _privateConstructorUsedError;
  List<Clue> get revealedClues => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  Map<String, dynamic> get cachedData => throw _privateConstructorUsedError;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {GameSession currentSession,
      List<Clue> availableClues,
      List<Clue> revealedClues,
      bool isLoading,
      String? error,
      Map<String, dynamic> cachedData});

  $GameSessionCopyWith<$Res> get currentSession;
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSession = null,
    Object? availableClues = null,
    Object? revealedClues = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? cachedData = null,
  }) {
    return _then(_value.copyWith(
      currentSession: null == currentSession
          ? _value.currentSession
          : currentSession // ignore: cast_nullable_to_non_nullable
              as GameSession,
      availableClues: null == availableClues
          ? _value.availableClues
          : availableClues // ignore: cast_nullable_to_non_nullable
              as List<Clue>,
      revealedClues: null == revealedClues
          ? _value.revealedClues
          : revealedClues // ignore: cast_nullable_to_non_nullable
              as List<Clue>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      cachedData: null == cachedData
          ? _value.cachedData
          : cachedData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GameSessionCopyWith<$Res> get currentSession {
    return $GameSessionCopyWith<$Res>(_value.currentSession, (value) {
      return _then(_value.copyWith(currentSession: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GameSession currentSession,
      List<Clue> availableClues,
      List<Clue> revealedClues,
      bool isLoading,
      String? error,
      Map<String, dynamic> cachedData});

  @override
  $GameSessionCopyWith<$Res> get currentSession;
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSession = null,
    Object? availableClues = null,
    Object? revealedClues = null,
    Object? isLoading = null,
    Object? error = freezed,
    Object? cachedData = null,
  }) {
    return _then(_$GameStateImpl(
      currentSession: null == currentSession
          ? _value.currentSession
          : currentSession // ignore: cast_nullable_to_non_nullable
              as GameSession,
      availableClues: null == availableClues
          ? _value._availableClues
          : availableClues // ignore: cast_nullable_to_non_nullable
              as List<Clue>,
      revealedClues: null == revealedClues
          ? _value._revealedClues
          : revealedClues // ignore: cast_nullable_to_non_nullable
              as List<Clue>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      cachedData: null == cachedData
          ? _value._cachedData
          : cachedData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$GameStateImpl implements _GameState {
  const _$GameStateImpl(
      {required this.currentSession,
      required final List<Clue> availableClues,
      required final List<Clue> revealedClues,
      required this.isLoading,
      required this.error,
      required final Map<String, dynamic> cachedData})
      : _availableClues = availableClues,
        _revealedClues = revealedClues,
        _cachedData = cachedData;

  @override
  final GameSession currentSession;
  final List<Clue> _availableClues;
  @override
  List<Clue> get availableClues {
    if (_availableClues is EqualUnmodifiableListView) return _availableClues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableClues);
  }

  final List<Clue> _revealedClues;
  @override
  List<Clue> get revealedClues {
    if (_revealedClues is EqualUnmodifiableListView) return _revealedClues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_revealedClues);
  }

  @override
  final bool isLoading;
  @override
  final String? error;
  final Map<String, dynamic> _cachedData;
  @override
  Map<String, dynamic> get cachedData {
    if (_cachedData is EqualUnmodifiableMapView) return _cachedData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_cachedData);
  }

  @override
  String toString() {
    return 'GameState(currentSession: $currentSession, availableClues: $availableClues, revealedClues: $revealedClues, isLoading: $isLoading, error: $error, cachedData: $cachedData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.currentSession, currentSession) ||
                other.currentSession == currentSession) &&
            const DeepCollectionEquality()
                .equals(other._availableClues, _availableClues) &&
            const DeepCollectionEquality()
                .equals(other._revealedClues, _revealedClues) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality()
                .equals(other._cachedData, _cachedData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentSession,
      const DeepCollectionEquality().hash(_availableClues),
      const DeepCollectionEquality().hash(_revealedClues),
      isLoading,
      error,
      const DeepCollectionEquality().hash(_cachedData));

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);
}

abstract class _GameState implements GameState {
  const factory _GameState(
      {required final GameSession currentSession,
      required final List<Clue> availableClues,
      required final List<Clue> revealedClues,
      required final bool isLoading,
      required final String? error,
      required final Map<String, dynamic> cachedData}) = _$GameStateImpl;

  @override
  GameSession get currentSession;
  @override
  List<Clue> get availableClues;
  @override
  List<Clue> get revealedClues;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  Map<String, dynamic> get cachedData;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
