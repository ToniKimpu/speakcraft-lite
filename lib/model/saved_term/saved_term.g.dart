// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_term.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedTermImpl _$$SavedTermImplFromJson(Map<String, dynamic> json) =>
    _$SavedTermImpl(
      id: (json['id'] as num?)?.toInt(),
      term: json['term'] as String,
      kind: json['kind'] as String? ?? '',
      translationMy: json['translationMy'] as String?,
      definitionMy: json['definitionMy'] as String?,
      examplesJson: json['examplesJson'] as String? ?? '[]',
      sourceTitle: json['sourceTitle'] as String?,
      sourceSentence: json['sourceSentence'] as String?,
      savedAt: DateTime.parse(json['savedAt'] as String),
    );

Map<String, dynamic> _$$SavedTermImplToJson(_$SavedTermImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'term': instance.term,
      'kind': instance.kind,
      'translationMy': instance.translationMy,
      'definitionMy': instance.definitionMy,
      'examplesJson': instance.examplesJson,
      'sourceTitle': instance.sourceTitle,
      'sourceSentence': instance.sourceSentence,
      'savedAt': instance.savedAt.toIso8601String(),
    };
