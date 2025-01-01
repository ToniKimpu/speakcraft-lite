// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DayImpl _$$DayImplFromJson(Map<String, dynamic> json) => _$DayImpl(
      id: (json['id'] as num).toInt(),
      orderNumber: (json['order_number'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      isComplete: json['isComplete'] as bool,
    );

Map<String, dynamic> _$$DayImplToJson(_$DayImpl instance) => <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'created_at': instance.createdAt.toIso8601String(),
      'lessons': instance.lessons,
      'exercises': instance.exercises,
      'isComplete': instance.isComplete,
    };
