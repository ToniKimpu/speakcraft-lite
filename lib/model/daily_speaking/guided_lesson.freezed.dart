// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guided_lesson.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GuidedLesson _$GuidedLessonFromJson(Map<String, dynamic> json) {
  return _GuidedLesson.fromJson(json);
}

/// @nodoc
mixin _$GuidedLesson {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  /// 1, 2, or 3. Drives both the list grouping and how much of the learner's
  /// own paragraph stays visible while recording (L1 full / L2 keywords /
  /// L3 hidden — the scaffold fades as they grow).
  int get level => throw _privateConstructorUsedError;

  /// The payoff shown up front: "By the end you'll be able to …".
  @JsonKey(name: 'objective_en')
  String get objectiveEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'objective_mm')
  String get objectiveMm => throw _privateConstructorUsedError;

  /// The worked example shown in the "I do" step (e.g. "I'm James. I come
  /// from the USA…"). Hidden once the learner moves on to record.
  @JsonKey(name: 'model_paragraph_en')
  String get modelParagraphEn => throw _privateConstructorUsedError;

  /// Same paragraph as a fill-in template using `{slotId}` tokens. The "We do"
  /// step replaces each token with the learner's own answer to assemble their
  /// paragraph. See [GuidedSlot].
  String get template => throw _privateConstructorUsedError;

  /// Per-sentence breakdown for the "I do" step (English sentence + Burmese
  /// explanation of what it's doing / why this wording).
  List<GuidedSentence> get sentences => throw _privateConstructorUsedError;

  /// The slots the learner fills in the "We do" step.
  List<GuidedSlot> get slots => throw _privateConstructorUsedError;
  List<TopicVocabItem> get vocabulary => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_phrases')
  List<TopicTargetPhrase> get targetPhrases =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'warmup_questions')
  List<String> get warmupQuestions => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_target_seconds')
  int get durationTargetSeconds => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this GuidedLesson to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GuidedLesson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GuidedLessonCopyWith<GuidedLesson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuidedLessonCopyWith<$Res> {
  factory $GuidedLessonCopyWith(
          GuidedLesson value, $Res Function(GuidedLesson) then) =
      _$GuidedLessonCopyWithImpl<$Res, GuidedLesson>;
  @useResult
  $Res call(
      {String id,
      String title,
      int level,
      @JsonKey(name: 'objective_en') String objectiveEn,
      @JsonKey(name: 'objective_mm') String objectiveMm,
      @JsonKey(name: 'model_paragraph_en') String modelParagraphEn,
      String template,
      List<GuidedSentence> sentences,
      List<GuidedSlot> slots,
      List<TopicVocabItem> vocabulary,
      @JsonKey(name: 'target_phrases') List<TopicTargetPhrase> targetPhrases,
      @JsonKey(name: 'warmup_questions') List<String> warmupQuestions,
      @JsonKey(name: 'duration_target_seconds') int durationTargetSeconds,
      @JsonKey(name: 'sort_order') int sortOrder});
}

/// @nodoc
class _$GuidedLessonCopyWithImpl<$Res, $Val extends GuidedLesson>
    implements $GuidedLessonCopyWith<$Res> {
  _$GuidedLessonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GuidedLesson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? level = null,
    Object? objectiveEn = null,
    Object? objectiveMm = null,
    Object? modelParagraphEn = null,
    Object? template = null,
    Object? sentences = null,
    Object? slots = null,
    Object? vocabulary = null,
    Object? targetPhrases = null,
    Object? warmupQuestions = null,
    Object? durationTargetSeconds = null,
    Object? sortOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      objectiveEn: null == objectiveEn
          ? _value.objectiveEn
          : objectiveEn // ignore: cast_nullable_to_non_nullable
              as String,
      objectiveMm: null == objectiveMm
          ? _value.objectiveMm
          : objectiveMm // ignore: cast_nullable_to_non_nullable
              as String,
      modelParagraphEn: null == modelParagraphEn
          ? _value.modelParagraphEn
          : modelParagraphEn // ignore: cast_nullable_to_non_nullable
              as String,
      template: null == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
      sentences: null == sentences
          ? _value.sentences
          : sentences // ignore: cast_nullable_to_non_nullable
              as List<GuidedSentence>,
      slots: null == slots
          ? _value.slots
          : slots // ignore: cast_nullable_to_non_nullable
              as List<GuidedSlot>,
      vocabulary: null == vocabulary
          ? _value.vocabulary
          : vocabulary // ignore: cast_nullable_to_non_nullable
              as List<TopicVocabItem>,
      targetPhrases: null == targetPhrases
          ? _value.targetPhrases
          : targetPhrases // ignore: cast_nullable_to_non_nullable
              as List<TopicTargetPhrase>,
      warmupQuestions: null == warmupQuestions
          ? _value.warmupQuestions
          : warmupQuestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      durationTargetSeconds: null == durationTargetSeconds
          ? _value.durationTargetSeconds
          : durationTargetSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GuidedLessonImplCopyWith<$Res>
    implements $GuidedLessonCopyWith<$Res> {
  factory _$$GuidedLessonImplCopyWith(
          _$GuidedLessonImpl value, $Res Function(_$GuidedLessonImpl) then) =
      __$$GuidedLessonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      int level,
      @JsonKey(name: 'objective_en') String objectiveEn,
      @JsonKey(name: 'objective_mm') String objectiveMm,
      @JsonKey(name: 'model_paragraph_en') String modelParagraphEn,
      String template,
      List<GuidedSentence> sentences,
      List<GuidedSlot> slots,
      List<TopicVocabItem> vocabulary,
      @JsonKey(name: 'target_phrases') List<TopicTargetPhrase> targetPhrases,
      @JsonKey(name: 'warmup_questions') List<String> warmupQuestions,
      @JsonKey(name: 'duration_target_seconds') int durationTargetSeconds,
      @JsonKey(name: 'sort_order') int sortOrder});
}

/// @nodoc
class __$$GuidedLessonImplCopyWithImpl<$Res>
    extends _$GuidedLessonCopyWithImpl<$Res, _$GuidedLessonImpl>
    implements _$$GuidedLessonImplCopyWith<$Res> {
  __$$GuidedLessonImplCopyWithImpl(
      _$GuidedLessonImpl _value, $Res Function(_$GuidedLessonImpl) _then)
      : super(_value, _then);

  /// Create a copy of GuidedLesson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? level = null,
    Object? objectiveEn = null,
    Object? objectiveMm = null,
    Object? modelParagraphEn = null,
    Object? template = null,
    Object? sentences = null,
    Object? slots = null,
    Object? vocabulary = null,
    Object? targetPhrases = null,
    Object? warmupQuestions = null,
    Object? durationTargetSeconds = null,
    Object? sortOrder = null,
  }) {
    return _then(_$GuidedLessonImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      objectiveEn: null == objectiveEn
          ? _value.objectiveEn
          : objectiveEn // ignore: cast_nullable_to_non_nullable
              as String,
      objectiveMm: null == objectiveMm
          ? _value.objectiveMm
          : objectiveMm // ignore: cast_nullable_to_non_nullable
              as String,
      modelParagraphEn: null == modelParagraphEn
          ? _value.modelParagraphEn
          : modelParagraphEn // ignore: cast_nullable_to_non_nullable
              as String,
      template: null == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
      sentences: null == sentences
          ? _value._sentences
          : sentences // ignore: cast_nullable_to_non_nullable
              as List<GuidedSentence>,
      slots: null == slots
          ? _value._slots
          : slots // ignore: cast_nullable_to_non_nullable
              as List<GuidedSlot>,
      vocabulary: null == vocabulary
          ? _value._vocabulary
          : vocabulary // ignore: cast_nullable_to_non_nullable
              as List<TopicVocabItem>,
      targetPhrases: null == targetPhrases
          ? _value._targetPhrases
          : targetPhrases // ignore: cast_nullable_to_non_nullable
              as List<TopicTargetPhrase>,
      warmupQuestions: null == warmupQuestions
          ? _value._warmupQuestions
          : warmupQuestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      durationTargetSeconds: null == durationTargetSeconds
          ? _value.durationTargetSeconds
          : durationTargetSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GuidedLessonImpl implements _GuidedLesson {
  const _$GuidedLessonImpl(
      {required this.id,
      required this.title,
      this.level = 1,
      @JsonKey(name: 'objective_en') required this.objectiveEn,
      @JsonKey(name: 'objective_mm') this.objectiveMm = '',
      @JsonKey(name: 'model_paragraph_en') required this.modelParagraphEn,
      this.template = '',
      final List<GuidedSentence> sentences = const <GuidedSentence>[],
      final List<GuidedSlot> slots = const <GuidedSlot>[],
      final List<TopicVocabItem> vocabulary = const <TopicVocabItem>[],
      @JsonKey(name: 'target_phrases')
      final List<TopicTargetPhrase> targetPhrases = const <TopicTargetPhrase>[],
      @JsonKey(name: 'warmup_questions')
      final List<String> warmupQuestions = const <String>[],
      @JsonKey(name: 'duration_target_seconds') this.durationTargetSeconds = 60,
      @JsonKey(name: 'sort_order') this.sortOrder = 0})
      : _sentences = sentences,
        _slots = slots,
        _vocabulary = vocabulary,
        _targetPhrases = targetPhrases,
        _warmupQuestions = warmupQuestions;

  factory _$GuidedLessonImpl.fromJson(Map<String, dynamic> json) =>
      _$$GuidedLessonImplFromJson(json);

  @override
  final String id;
  @override
  final String title;

  /// 1, 2, or 3. Drives both the list grouping and how much of the learner's
  /// own paragraph stays visible while recording (L1 full / L2 keywords /
  /// L3 hidden — the scaffold fades as they grow).
  @override
  @JsonKey()
  final int level;

  /// The payoff shown up front: "By the end you'll be able to …".
  @override
  @JsonKey(name: 'objective_en')
  final String objectiveEn;
  @override
  @JsonKey(name: 'objective_mm')
  final String objectiveMm;

  /// The worked example shown in the "I do" step (e.g. "I'm James. I come
  /// from the USA…"). Hidden once the learner moves on to record.
  @override
  @JsonKey(name: 'model_paragraph_en')
  final String modelParagraphEn;

  /// Same paragraph as a fill-in template using `{slotId}` tokens. The "We do"
  /// step replaces each token with the learner's own answer to assemble their
  /// paragraph. See [GuidedSlot].
  @override
  @JsonKey()
  final String template;

  /// Per-sentence breakdown for the "I do" step (English sentence + Burmese
  /// explanation of what it's doing / why this wording).
  final List<GuidedSentence> _sentences;

  /// Per-sentence breakdown for the "I do" step (English sentence + Burmese
  /// explanation of what it's doing / why this wording).
  @override
  @JsonKey()
  List<GuidedSentence> get sentences {
    if (_sentences is EqualUnmodifiableListView) return _sentences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sentences);
  }

  /// The slots the learner fills in the "We do" step.
  final List<GuidedSlot> _slots;

  /// The slots the learner fills in the "We do" step.
  @override
  @JsonKey()
  List<GuidedSlot> get slots {
    if (_slots is EqualUnmodifiableListView) return _slots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_slots);
  }

  final List<TopicVocabItem> _vocabulary;
  @override
  @JsonKey()
  List<TopicVocabItem> get vocabulary {
    if (_vocabulary is EqualUnmodifiableListView) return _vocabulary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vocabulary);
  }

  final List<TopicTargetPhrase> _targetPhrases;
  @override
  @JsonKey(name: 'target_phrases')
  List<TopicTargetPhrase> get targetPhrases {
    if (_targetPhrases is EqualUnmodifiableListView) return _targetPhrases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targetPhrases);
  }

  final List<String> _warmupQuestions;
  @override
  @JsonKey(name: 'warmup_questions')
  List<String> get warmupQuestions {
    if (_warmupQuestions is EqualUnmodifiableListView) return _warmupQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warmupQuestions);
  }

  @override
  @JsonKey(name: 'duration_target_seconds')
  final int durationTargetSeconds;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  @override
  String toString() {
    return 'GuidedLesson(id: $id, title: $title, level: $level, objectiveEn: $objectiveEn, objectiveMm: $objectiveMm, modelParagraphEn: $modelParagraphEn, template: $template, sentences: $sentences, slots: $slots, vocabulary: $vocabulary, targetPhrases: $targetPhrases, warmupQuestions: $warmupQuestions, durationTargetSeconds: $durationTargetSeconds, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuidedLessonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.objectiveEn, objectiveEn) ||
                other.objectiveEn == objectiveEn) &&
            (identical(other.objectiveMm, objectiveMm) ||
                other.objectiveMm == objectiveMm) &&
            (identical(other.modelParagraphEn, modelParagraphEn) ||
                other.modelParagraphEn == modelParagraphEn) &&
            (identical(other.template, template) ||
                other.template == template) &&
            const DeepCollectionEquality()
                .equals(other._sentences, _sentences) &&
            const DeepCollectionEquality().equals(other._slots, _slots) &&
            const DeepCollectionEquality()
                .equals(other._vocabulary, _vocabulary) &&
            const DeepCollectionEquality()
                .equals(other._targetPhrases, _targetPhrases) &&
            const DeepCollectionEquality()
                .equals(other._warmupQuestions, _warmupQuestions) &&
            (identical(other.durationTargetSeconds, durationTargetSeconds) ||
                other.durationTargetSeconds == durationTargetSeconds) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      level,
      objectiveEn,
      objectiveMm,
      modelParagraphEn,
      template,
      const DeepCollectionEquality().hash(_sentences),
      const DeepCollectionEquality().hash(_slots),
      const DeepCollectionEquality().hash(_vocabulary),
      const DeepCollectionEquality().hash(_targetPhrases),
      const DeepCollectionEquality().hash(_warmupQuestions),
      durationTargetSeconds,
      sortOrder);

  /// Create a copy of GuidedLesson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuidedLessonImplCopyWith<_$GuidedLessonImpl> get copyWith =>
      __$$GuidedLessonImplCopyWithImpl<_$GuidedLessonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GuidedLessonImplToJson(
      this,
    );
  }
}

abstract class _GuidedLesson implements GuidedLesson {
  const factory _GuidedLesson(
      {required final String id,
      required final String title,
      final int level,
      @JsonKey(name: 'objective_en') required final String objectiveEn,
      @JsonKey(name: 'objective_mm') final String objectiveMm,
      @JsonKey(name: 'model_paragraph_en')
      required final String modelParagraphEn,
      final String template,
      final List<GuidedSentence> sentences,
      final List<GuidedSlot> slots,
      final List<TopicVocabItem> vocabulary,
      @JsonKey(name: 'target_phrases')
      final List<TopicTargetPhrase> targetPhrases,
      @JsonKey(name: 'warmup_questions') final List<String> warmupQuestions,
      @JsonKey(name: 'duration_target_seconds') final int durationTargetSeconds,
      @JsonKey(name: 'sort_order') final int sortOrder}) = _$GuidedLessonImpl;

  factory _GuidedLesson.fromJson(Map<String, dynamic> json) =
      _$GuidedLessonImpl.fromJson;

  @override
  String get id;
  @override
  String get title;

  /// 1, 2, or 3. Drives both the list grouping and how much of the learner's
  /// own paragraph stays visible while recording (L1 full / L2 keywords /
  /// L3 hidden — the scaffold fades as they grow).
  @override
  int get level;

  /// The payoff shown up front: "By the end you'll be able to …".
  @override
  @JsonKey(name: 'objective_en')
  String get objectiveEn;
  @override
  @JsonKey(name: 'objective_mm')
  String get objectiveMm;

  /// The worked example shown in the "I do" step (e.g. "I'm James. I come
  /// from the USA…"). Hidden once the learner moves on to record.
  @override
  @JsonKey(name: 'model_paragraph_en')
  String get modelParagraphEn;

  /// Same paragraph as a fill-in template using `{slotId}` tokens. The "We do"
  /// step replaces each token with the learner's own answer to assemble their
  /// paragraph. See [GuidedSlot].
  @override
  String get template;

  /// Per-sentence breakdown for the "I do" step (English sentence + Burmese
  /// explanation of what it's doing / why this wording).
  @override
  List<GuidedSentence> get sentences;

  /// The slots the learner fills in the "We do" step.
  @override
  List<GuidedSlot> get slots;
  @override
  List<TopicVocabItem> get vocabulary;
  @override
  @JsonKey(name: 'target_phrases')
  List<TopicTargetPhrase> get targetPhrases;
  @override
  @JsonKey(name: 'warmup_questions')
  List<String> get warmupQuestions;
  @override
  @JsonKey(name: 'duration_target_seconds')
  int get durationTargetSeconds;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;

  /// Create a copy of GuidedLesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuidedLessonImplCopyWith<_$GuidedLessonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GuidedSentence _$GuidedSentenceFromJson(Map<String, dynamic> json) {
  return _GuidedSentence.fromJson(json);
}

/// @nodoc
mixin _$GuidedSentence {
  @JsonKey(name: 'text_en')
  String get textEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'explanation_mm')
  String get explanationMm => throw _privateConstructorUsedError;

  /// Serializes this GuidedSentence to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GuidedSentence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GuidedSentenceCopyWith<GuidedSentence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuidedSentenceCopyWith<$Res> {
  factory $GuidedSentenceCopyWith(
          GuidedSentence value, $Res Function(GuidedSentence) then) =
      _$GuidedSentenceCopyWithImpl<$Res, GuidedSentence>;
  @useResult
  $Res call(
      {@JsonKey(name: 'text_en') String textEn,
      @JsonKey(name: 'explanation_mm') String explanationMm});
}

/// @nodoc
class _$GuidedSentenceCopyWithImpl<$Res, $Val extends GuidedSentence>
    implements $GuidedSentenceCopyWith<$Res> {
  _$GuidedSentenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GuidedSentence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textEn = null,
    Object? explanationMm = null,
  }) {
    return _then(_value.copyWith(
      textEn: null == textEn
          ? _value.textEn
          : textEn // ignore: cast_nullable_to_non_nullable
              as String,
      explanationMm: null == explanationMm
          ? _value.explanationMm
          : explanationMm // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GuidedSentenceImplCopyWith<$Res>
    implements $GuidedSentenceCopyWith<$Res> {
  factory _$$GuidedSentenceImplCopyWith(_$GuidedSentenceImpl value,
          $Res Function(_$GuidedSentenceImpl) then) =
      __$$GuidedSentenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'text_en') String textEn,
      @JsonKey(name: 'explanation_mm') String explanationMm});
}

/// @nodoc
class __$$GuidedSentenceImplCopyWithImpl<$Res>
    extends _$GuidedSentenceCopyWithImpl<$Res, _$GuidedSentenceImpl>
    implements _$$GuidedSentenceImplCopyWith<$Res> {
  __$$GuidedSentenceImplCopyWithImpl(
      _$GuidedSentenceImpl _value, $Res Function(_$GuidedSentenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of GuidedSentence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textEn = null,
    Object? explanationMm = null,
  }) {
    return _then(_$GuidedSentenceImpl(
      textEn: null == textEn
          ? _value.textEn
          : textEn // ignore: cast_nullable_to_non_nullable
              as String,
      explanationMm: null == explanationMm
          ? _value.explanationMm
          : explanationMm // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GuidedSentenceImpl implements _GuidedSentence {
  const _$GuidedSentenceImpl(
      {@JsonKey(name: 'text_en') required this.textEn,
      @JsonKey(name: 'explanation_mm') this.explanationMm = ''});

  factory _$GuidedSentenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$GuidedSentenceImplFromJson(json);

  @override
  @JsonKey(name: 'text_en')
  final String textEn;
  @override
  @JsonKey(name: 'explanation_mm')
  final String explanationMm;

  @override
  String toString() {
    return 'GuidedSentence(textEn: $textEn, explanationMm: $explanationMm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuidedSentenceImpl &&
            (identical(other.textEn, textEn) || other.textEn == textEn) &&
            (identical(other.explanationMm, explanationMm) ||
                other.explanationMm == explanationMm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, textEn, explanationMm);

  /// Create a copy of GuidedSentence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuidedSentenceImplCopyWith<_$GuidedSentenceImpl> get copyWith =>
      __$$GuidedSentenceImplCopyWithImpl<_$GuidedSentenceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GuidedSentenceImplToJson(
      this,
    );
  }
}

abstract class _GuidedSentence implements GuidedSentence {
  const factory _GuidedSentence(
          {@JsonKey(name: 'text_en') required final String textEn,
          @JsonKey(name: 'explanation_mm') final String explanationMm}) =
      _$GuidedSentenceImpl;

  factory _GuidedSentence.fromJson(Map<String, dynamic> json) =
      _$GuidedSentenceImpl.fromJson;

  @override
  @JsonKey(name: 'text_en')
  String get textEn;
  @override
  @JsonKey(name: 'explanation_mm')
  String get explanationMm;

  /// Create a copy of GuidedSentence
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuidedSentenceImplCopyWith<_$GuidedSentenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GuidedSlot _$GuidedSlotFromJson(Map<String, dynamic> json) {
  return _GuidedSlot.fromJson(json);
}

/// @nodoc
mixin _$GuidedSlot {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'label_en')
  String get labelEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'label_mm')
  String get labelMm => throw _privateConstructorUsedError;
  String get hint => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;

  /// Serializes this GuidedSlot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GuidedSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GuidedSlotCopyWith<GuidedSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuidedSlotCopyWith<$Res> {
  factory $GuidedSlotCopyWith(
          GuidedSlot value, $Res Function(GuidedSlot) then) =
      _$GuidedSlotCopyWithImpl<$Res, GuidedSlot>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'label_en') String labelEn,
      @JsonKey(name: 'label_mm') String labelMm,
      String hint,
      List<String> options});
}

/// @nodoc
class _$GuidedSlotCopyWithImpl<$Res, $Val extends GuidedSlot>
    implements $GuidedSlotCopyWith<$Res> {
  _$GuidedSlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GuidedSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? labelEn = null,
    Object? labelMm = null,
    Object? hint = null,
    Object? options = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      labelEn: null == labelEn
          ? _value.labelEn
          : labelEn // ignore: cast_nullable_to_non_nullable
              as String,
      labelMm: null == labelMm
          ? _value.labelMm
          : labelMm // ignore: cast_nullable_to_non_nullable
              as String,
      hint: null == hint
          ? _value.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GuidedSlotImplCopyWith<$Res>
    implements $GuidedSlotCopyWith<$Res> {
  factory _$$GuidedSlotImplCopyWith(
          _$GuidedSlotImpl value, $Res Function(_$GuidedSlotImpl) then) =
      __$$GuidedSlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'label_en') String labelEn,
      @JsonKey(name: 'label_mm') String labelMm,
      String hint,
      List<String> options});
}

/// @nodoc
class __$$GuidedSlotImplCopyWithImpl<$Res>
    extends _$GuidedSlotCopyWithImpl<$Res, _$GuidedSlotImpl>
    implements _$$GuidedSlotImplCopyWith<$Res> {
  __$$GuidedSlotImplCopyWithImpl(
      _$GuidedSlotImpl _value, $Res Function(_$GuidedSlotImpl) _then)
      : super(_value, _then);

  /// Create a copy of GuidedSlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? labelEn = null,
    Object? labelMm = null,
    Object? hint = null,
    Object? options = null,
  }) {
    return _then(_$GuidedSlotImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      labelEn: null == labelEn
          ? _value.labelEn
          : labelEn // ignore: cast_nullable_to_non_nullable
              as String,
      labelMm: null == labelMm
          ? _value.labelMm
          : labelMm // ignore: cast_nullable_to_non_nullable
              as String,
      hint: null == hint
          ? _value.hint
          : hint // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GuidedSlotImpl implements _GuidedSlot {
  const _$GuidedSlotImpl(
      {required this.id,
      @JsonKey(name: 'label_en') required this.labelEn,
      @JsonKey(name: 'label_mm') this.labelMm = '',
      this.hint = '',
      final List<String> options = const <String>[]})
      : _options = options;

  factory _$GuidedSlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$GuidedSlotImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'label_en')
  final String labelEn;
  @override
  @JsonKey(name: 'label_mm')
  final String labelMm;
  @override
  @JsonKey()
  final String hint;
  final List<String> _options;
  @override
  @JsonKey()
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  String toString() {
    return 'GuidedSlot(id: $id, labelEn: $labelEn, labelMm: $labelMm, hint: $hint, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuidedSlotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.labelEn, labelEn) || other.labelEn == labelEn) &&
            (identical(other.labelMm, labelMm) || other.labelMm == labelMm) &&
            (identical(other.hint, hint) || other.hint == hint) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, labelEn, labelMm, hint,
      const DeepCollectionEquality().hash(_options));

  /// Create a copy of GuidedSlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GuidedSlotImplCopyWith<_$GuidedSlotImpl> get copyWith =>
      __$$GuidedSlotImplCopyWithImpl<_$GuidedSlotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GuidedSlotImplToJson(
      this,
    );
  }
}

abstract class _GuidedSlot implements GuidedSlot {
  const factory _GuidedSlot(
      {required final String id,
      @JsonKey(name: 'label_en') required final String labelEn,
      @JsonKey(name: 'label_mm') final String labelMm,
      final String hint,
      final List<String> options}) = _$GuidedSlotImpl;

  factory _GuidedSlot.fromJson(Map<String, dynamic> json) =
      _$GuidedSlotImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'label_en')
  String get labelEn;
  @override
  @JsonKey(name: 'label_mm')
  String get labelMm;
  @override
  String get hint;
  @override
  List<String> get options;

  /// Create a copy of GuidedSlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GuidedSlotImplCopyWith<_$GuidedSlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
