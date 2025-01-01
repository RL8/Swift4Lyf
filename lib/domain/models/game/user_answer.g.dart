// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAnswerImpl _$$UserAnswerImplFromJson(Map<String, dynamic> json) =>
    _$UserAnswerImpl(
      albumId: json['albumId'] as String,
      isCorrect: json['isCorrect'] as bool,
      timeSpentSeconds: (json['timeSpentSeconds'] as num).toInt(),
      pointsEarned: (json['pointsEarned'] as num).toInt(),
      cluesUsed:
          (json['cluesUsed'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$UserAnswerImplToJson(_$UserAnswerImpl instance) =>
    <String, dynamic>{
      'albumId': instance.albumId,
      'isCorrect': instance.isCorrect,
      'timeSpentSeconds': instance.timeSpentSeconds,
      'pointsEarned': instance.pointsEarned,
      'cluesUsed': instance.cluesUsed,
    };
