// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameSessionImpl _$$GameSessionImplFromJson(Map<String, dynamic> json) =>
    _$GameSessionImpl(
      id: json['id'] as String,
      difficulty: $enumDecode(_$DifficultyLevelEnumMap, json['difficulty']),
      selectedAlbums: (json['selectedAlbums'] as List<dynamic>)
          .map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentRound: (json['currentRound'] as num).toInt(),
      score: (json['score'] as num).toInt(),
      userAnswers: (json['userAnswers'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, UserAnswer.fromJson(e as Map<String, dynamic>)),
      ),
      status: $enumDecode(_$GameStatusEnumMap, json['status']),
      startTime: DateTime.parse(json['startTime'] as String),
      timeRemaining: json['timeRemaining'] == null
          ? const Duration(minutes: 3)
          : Duration(microseconds: (json['timeRemaining'] as num).toInt()),
    );

Map<String, dynamic> _$$GameSessionImplToJson(_$GameSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'difficulty': _$DifficultyLevelEnumMap[instance.difficulty]!,
      'selectedAlbums': instance.selectedAlbums,
      'currentRound': instance.currentRound,
      'score': instance.score,
      'userAnswers': instance.userAnswers,
      'status': _$GameStatusEnumMap[instance.status]!,
      'startTime': instance.startTime.toIso8601String(),
      'timeRemaining': instance.timeRemaining.inMicroseconds,
    };

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.easy: 'easy',
  DifficultyLevel.medium: 'medium',
  DifficultyLevel.hard: 'hard',
  DifficultyLevel.expert: 'expert',
};

const _$GameStatusEnumMap = {
  GameStatus.notStarted: 'notStarted',
  GameStatus.inProgress: 'inProgress',
  GameStatus.paused: 'paused',
  GameStatus.completed: 'completed',
};
