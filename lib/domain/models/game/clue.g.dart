// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClueImpl _$$ClueImplFromJson(Map<String, dynamic> json) => _$ClueImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      clueType: json['clueType'] as String,
      difficulty: $enumDecode(_$DifficultyLevelEnumMap, json['difficulty']),
      difficultyRating: (json['difficultyRating'] as num).toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$ClueImplToJson(_$ClueImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'clueType': instance.clueType,
      'difficulty': _$DifficultyLevelEnumMap[instance.difficulty]!,
      'difficultyRating': instance.difficultyRating,
      'metadata': instance.metadata,
    };

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.easy: 'easy',
  DifficultyLevel.medium: 'medium',
  DifficultyLevel.hard: 'hard',
  DifficultyLevel.expert: 'expert',
};
