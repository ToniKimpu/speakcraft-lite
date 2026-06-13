// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guided_lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GuidedLessonImpl _$$GuidedLessonImplFromJson(Map<String, dynamic> json) =>
    _$GuidedLessonImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      level: (json['level'] as num?)?.toInt() ?? 1,
      objectiveEn: json['objective_en'] as String,
      objectiveMm: json['objective_mm'] as String? ?? '',
      modelParagraphEn: json['model_paragraph_en'] as String,
      template: json['template'] as String? ?? '',
      sentences: (json['sentences'] as List<dynamic>?)
              ?.map((e) => GuidedSentence.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <GuidedSentence>[],
      slots: (json['slots'] as List<dynamic>?)
              ?.map((e) => GuidedSlot.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <GuidedSlot>[],
      vocabulary: (json['vocabulary'] as List<dynamic>?)
              ?.map((e) => GuidedVocab.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <GuidedVocab>[],
      targetPhrases: (json['target_phrases'] as List<dynamic>?)
              ?.map(
                  (e) => TopicTargetPhrase.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TopicTargetPhrase>[],
      warmupQuestions: (json['warmup_questions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      durationTargetSeconds:
          (json['duration_target_seconds'] as num?)?.toInt() ?? 60,
      sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$GuidedLessonImplToJson(_$GuidedLessonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'level': instance.level,
      'objective_en': instance.objectiveEn,
      'objective_mm': instance.objectiveMm,
      'model_paragraph_en': instance.modelParagraphEn,
      'template': instance.template,
      'sentences': instance.sentences,
      'slots': instance.slots,
      'vocabulary': instance.vocabulary,
      'target_phrases': instance.targetPhrases,
      'warmup_questions': instance.warmupQuestions,
      'duration_target_seconds': instance.durationTargetSeconds,
      'sort_order': instance.sortOrder,
    };

_$GuidedSentenceImpl _$$GuidedSentenceImplFromJson(Map<String, dynamic> json) =>
    _$GuidedSentenceImpl(
      textEn: json['text_en'] as String,
      textMm: json['text_mm'] as String? ?? '',
      explanationMm: json['explanation_mm'] as String? ?? '',
      highlights: (json['highlights'] as List<dynamic>?)
              ?.map((e) => GuidedHighlight.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <GuidedHighlight>[],
    );

Map<String, dynamic> _$$GuidedSentenceImplToJson(
        _$GuidedSentenceImpl instance) =>
    <String, dynamic>{
      'text_en': instance.textEn,
      'text_mm': instance.textMm,
      'explanation_mm': instance.explanationMm,
      'highlights': instance.highlights,
    };

_$GuidedHighlightImpl _$$GuidedHighlightImplFromJson(
        Map<String, dynamic> json) =>
    _$GuidedHighlightImpl(
      phrase: json['phrase'] as String,
      vocabId: json['vocab_id'] as String,
    );

Map<String, dynamic> _$$GuidedHighlightImplToJson(
        _$GuidedHighlightImpl instance) =>
    <String, dynamic>{
      'phrase': instance.phrase,
      'vocab_id': instance.vocabId,
    };

_$GuidedVocabImpl _$$GuidedVocabImplFromJson(Map<String, dynamic> json) =>
    _$GuidedVocabImpl(
      id: json['id'] as String? ?? '',
      term: json['term'] as String,
      group: json['group'] as String? ?? '',
      definitionMm: json['definition_mm'] as String? ?? '',
      related: (json['related'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      opposite: (json['opposite'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      exampleEn: json['example_en'] as String? ?? '',
      slot: json['slot'] as String? ?? '',
    );

Map<String, dynamic> _$$GuidedVocabImplToJson(_$GuidedVocabImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'term': instance.term,
      'group': instance.group,
      'definition_mm': instance.definitionMm,
      'related': instance.related,
      'opposite': instance.opposite,
      'example_en': instance.exampleEn,
      'slot': instance.slot,
    };

_$GuidedSlotImpl _$$GuidedSlotImplFromJson(Map<String, dynamic> json) =>
    _$GuidedSlotImpl(
      id: json['id'] as String,
      labelEn: json['label_en'] as String,
      labelMm: json['label_mm'] as String? ?? '',
      hint: json['hint'] as String? ?? '',
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$GuidedSlotImplToJson(_$GuidedSlotImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label_en': instance.labelEn,
      'label_mm': instance.labelMm,
      'hint': instance.hint,
      'options': instance.options,
    };
