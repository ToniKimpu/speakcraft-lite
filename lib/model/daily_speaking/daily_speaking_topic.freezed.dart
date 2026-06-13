// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_speaking_topic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailySpeakingTopic _$DailySpeakingTopicFromJson(Map<String, dynamic> json) {
  return _DailySpeakingTopic.fromJson(json);
}

/// @nodoc
mixin _$DailySpeakingTopic {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'prompt_en')
  String get promptEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'prompt_mm')
  String get promptMm => throw _privateConstructorUsedError;
  TopicDifficulty get difficulty => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration_target_seconds')
  int get durationTargetSeconds => throw _privateConstructorUsedError;
  List<TopicVocabItem> get vocabulary => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_phrases')
  List<TopicTargetPhrase> get targetPhrases =>
      throw _privateConstructorUsedError;

  /// The suggested-topic "guide" fields (P3 prep page). All optional so older
  /// topics and the guided→topic mapping keep working with empty lists.
  /// `outline` is the talk's spine; `grammarPatterns` the structural backbone;
  /// `commonMistakes` Myanmar-interference fixes; `exampleAnswer*` a gated model.
  List<TopicOutlineStep> get outline => throw _privateConstructorUsedError;
  @JsonKey(name: 'grammar_patterns')
  List<TopicGrammarPattern> get grammarPatterns =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'common_mistakes')
  List<TopicCommonMistake> get commonMistakes =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'example_answer_en')
  String get exampleAnswerEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'example_answer_mm')
  String get exampleAnswerMm => throw _privateConstructorUsedError;
  @JsonKey(name: 'warmup_questions')
  List<String> get warmupQuestions => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this DailySpeakingTopic to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailySpeakingTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailySpeakingTopicCopyWith<DailySpeakingTopic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailySpeakingTopicCopyWith<$Res> {
  factory $DailySpeakingTopicCopyWith(
          DailySpeakingTopic value, $Res Function(DailySpeakingTopic) then) =
      _$DailySpeakingTopicCopyWithImpl<$Res, DailySpeakingTopic>;
  @useResult
  $Res call(
      {String id,
      String title,
      @JsonKey(name: 'prompt_en') String promptEn,
      @JsonKey(name: 'prompt_mm') String promptMm,
      TopicDifficulty difficulty,
      @JsonKey(name: 'duration_target_seconds') int durationTargetSeconds,
      List<TopicVocabItem> vocabulary,
      @JsonKey(name: 'target_phrases') List<TopicTargetPhrase> targetPhrases,
      List<TopicOutlineStep> outline,
      @JsonKey(name: 'grammar_patterns')
      List<TopicGrammarPattern> grammarPatterns,
      @JsonKey(name: 'common_mistakes') List<TopicCommonMistake> commonMistakes,
      @JsonKey(name: 'example_answer_en') String exampleAnswerEn,
      @JsonKey(name: 'example_answer_mm') String exampleAnswerMm,
      @JsonKey(name: 'warmup_questions') List<String> warmupQuestions,
      List<String> tags,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$DailySpeakingTopicCopyWithImpl<$Res, $Val extends DailySpeakingTopic>
    implements $DailySpeakingTopicCopyWith<$Res> {
  _$DailySpeakingTopicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailySpeakingTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? promptEn = null,
    Object? promptMm = null,
    Object? difficulty = null,
    Object? durationTargetSeconds = null,
    Object? vocabulary = null,
    Object? targetPhrases = null,
    Object? outline = null,
    Object? grammarPatterns = null,
    Object? commonMistakes = null,
    Object? exampleAnswerEn = null,
    Object? exampleAnswerMm = null,
    Object? warmupQuestions = null,
    Object? tags = null,
    Object? createdAt = freezed,
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
      promptEn: null == promptEn
          ? _value.promptEn
          : promptEn // ignore: cast_nullable_to_non_nullable
              as String,
      promptMm: null == promptMm
          ? _value.promptMm
          : promptMm // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as TopicDifficulty,
      durationTargetSeconds: null == durationTargetSeconds
          ? _value.durationTargetSeconds
          : durationTargetSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      vocabulary: null == vocabulary
          ? _value.vocabulary
          : vocabulary // ignore: cast_nullable_to_non_nullable
              as List<TopicVocabItem>,
      targetPhrases: null == targetPhrases
          ? _value.targetPhrases
          : targetPhrases // ignore: cast_nullable_to_non_nullable
              as List<TopicTargetPhrase>,
      outline: null == outline
          ? _value.outline
          : outline // ignore: cast_nullable_to_non_nullable
              as List<TopicOutlineStep>,
      grammarPatterns: null == grammarPatterns
          ? _value.grammarPatterns
          : grammarPatterns // ignore: cast_nullable_to_non_nullable
              as List<TopicGrammarPattern>,
      commonMistakes: null == commonMistakes
          ? _value.commonMistakes
          : commonMistakes // ignore: cast_nullable_to_non_nullable
              as List<TopicCommonMistake>,
      exampleAnswerEn: null == exampleAnswerEn
          ? _value.exampleAnswerEn
          : exampleAnswerEn // ignore: cast_nullable_to_non_nullable
              as String,
      exampleAnswerMm: null == exampleAnswerMm
          ? _value.exampleAnswerMm
          : exampleAnswerMm // ignore: cast_nullable_to_non_nullable
              as String,
      warmupQuestions: null == warmupQuestions
          ? _value.warmupQuestions
          : warmupQuestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailySpeakingTopicImplCopyWith<$Res>
    implements $DailySpeakingTopicCopyWith<$Res> {
  factory _$$DailySpeakingTopicImplCopyWith(_$DailySpeakingTopicImpl value,
          $Res Function(_$DailySpeakingTopicImpl) then) =
      __$$DailySpeakingTopicImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      @JsonKey(name: 'prompt_en') String promptEn,
      @JsonKey(name: 'prompt_mm') String promptMm,
      TopicDifficulty difficulty,
      @JsonKey(name: 'duration_target_seconds') int durationTargetSeconds,
      List<TopicVocabItem> vocabulary,
      @JsonKey(name: 'target_phrases') List<TopicTargetPhrase> targetPhrases,
      List<TopicOutlineStep> outline,
      @JsonKey(name: 'grammar_patterns')
      List<TopicGrammarPattern> grammarPatterns,
      @JsonKey(name: 'common_mistakes') List<TopicCommonMistake> commonMistakes,
      @JsonKey(name: 'example_answer_en') String exampleAnswerEn,
      @JsonKey(name: 'example_answer_mm') String exampleAnswerMm,
      @JsonKey(name: 'warmup_questions') List<String> warmupQuestions,
      List<String> tags,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$DailySpeakingTopicImplCopyWithImpl<$Res>
    extends _$DailySpeakingTopicCopyWithImpl<$Res, _$DailySpeakingTopicImpl>
    implements _$$DailySpeakingTopicImplCopyWith<$Res> {
  __$$DailySpeakingTopicImplCopyWithImpl(_$DailySpeakingTopicImpl _value,
      $Res Function(_$DailySpeakingTopicImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailySpeakingTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? promptEn = null,
    Object? promptMm = null,
    Object? difficulty = null,
    Object? durationTargetSeconds = null,
    Object? vocabulary = null,
    Object? targetPhrases = null,
    Object? outline = null,
    Object? grammarPatterns = null,
    Object? commonMistakes = null,
    Object? exampleAnswerEn = null,
    Object? exampleAnswerMm = null,
    Object? warmupQuestions = null,
    Object? tags = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$DailySpeakingTopicImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      promptEn: null == promptEn
          ? _value.promptEn
          : promptEn // ignore: cast_nullable_to_non_nullable
              as String,
      promptMm: null == promptMm
          ? _value.promptMm
          : promptMm // ignore: cast_nullable_to_non_nullable
              as String,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as TopicDifficulty,
      durationTargetSeconds: null == durationTargetSeconds
          ? _value.durationTargetSeconds
          : durationTargetSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      vocabulary: null == vocabulary
          ? _value._vocabulary
          : vocabulary // ignore: cast_nullable_to_non_nullable
              as List<TopicVocabItem>,
      targetPhrases: null == targetPhrases
          ? _value._targetPhrases
          : targetPhrases // ignore: cast_nullable_to_non_nullable
              as List<TopicTargetPhrase>,
      outline: null == outline
          ? _value._outline
          : outline // ignore: cast_nullable_to_non_nullable
              as List<TopicOutlineStep>,
      grammarPatterns: null == grammarPatterns
          ? _value._grammarPatterns
          : grammarPatterns // ignore: cast_nullable_to_non_nullable
              as List<TopicGrammarPattern>,
      commonMistakes: null == commonMistakes
          ? _value._commonMistakes
          : commonMistakes // ignore: cast_nullable_to_non_nullable
              as List<TopicCommonMistake>,
      exampleAnswerEn: null == exampleAnswerEn
          ? _value.exampleAnswerEn
          : exampleAnswerEn // ignore: cast_nullable_to_non_nullable
              as String,
      exampleAnswerMm: null == exampleAnswerMm
          ? _value.exampleAnswerMm
          : exampleAnswerMm // ignore: cast_nullable_to_non_nullable
              as String,
      warmupQuestions: null == warmupQuestions
          ? _value._warmupQuestions
          : warmupQuestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailySpeakingTopicImpl implements _DailySpeakingTopic {
  const _$DailySpeakingTopicImpl(
      {required this.id,
      required this.title,
      @JsonKey(name: 'prompt_en') required this.promptEn,
      @JsonKey(name: 'prompt_mm') required this.promptMm,
      this.difficulty = TopicDifficulty.beginner,
      @JsonKey(name: 'duration_target_seconds')
      this.durationTargetSeconds = 180,
      final List<TopicVocabItem> vocabulary = const <TopicVocabItem>[],
      @JsonKey(name: 'target_phrases')
      final List<TopicTargetPhrase> targetPhrases = const <TopicTargetPhrase>[],
      final List<TopicOutlineStep> outline = const <TopicOutlineStep>[],
      @JsonKey(name: 'grammar_patterns')
      final List<TopicGrammarPattern> grammarPatterns =
          const <TopicGrammarPattern>[],
      @JsonKey(name: 'common_mistakes')
      final List<TopicCommonMistake> commonMistakes =
          const <TopicCommonMistake>[],
      @JsonKey(name: 'example_answer_en') this.exampleAnswerEn = '',
      @JsonKey(name: 'example_answer_mm') this.exampleAnswerMm = '',
      @JsonKey(name: 'warmup_questions')
      final List<String> warmupQuestions = const <String>[],
      final List<String> tags = const <String>[],
      @JsonKey(name: 'created_at') this.createdAt})
      : _vocabulary = vocabulary,
        _targetPhrases = targetPhrases,
        _outline = outline,
        _grammarPatterns = grammarPatterns,
        _commonMistakes = commonMistakes,
        _warmupQuestions = warmupQuestions,
        _tags = tags;

  factory _$DailySpeakingTopicImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailySpeakingTopicImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey(name: 'prompt_en')
  final String promptEn;
  @override
  @JsonKey(name: 'prompt_mm')
  final String promptMm;
  @override
  @JsonKey()
  final TopicDifficulty difficulty;
  @override
  @JsonKey(name: 'duration_target_seconds')
  final int durationTargetSeconds;
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

  /// The suggested-topic "guide" fields (P3 prep page). All optional so older
  /// topics and the guided→topic mapping keep working with empty lists.
  /// `outline` is the talk's spine; `grammarPatterns` the structural backbone;
  /// `commonMistakes` Myanmar-interference fixes; `exampleAnswer*` a gated model.
  final List<TopicOutlineStep> _outline;

  /// The suggested-topic "guide" fields (P3 prep page). All optional so older
  /// topics and the guided→topic mapping keep working with empty lists.
  /// `outline` is the talk's spine; `grammarPatterns` the structural backbone;
  /// `commonMistakes` Myanmar-interference fixes; `exampleAnswer*` a gated model.
  @override
  @JsonKey()
  List<TopicOutlineStep> get outline {
    if (_outline is EqualUnmodifiableListView) return _outline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outline);
  }

  final List<TopicGrammarPattern> _grammarPatterns;
  @override
  @JsonKey(name: 'grammar_patterns')
  List<TopicGrammarPattern> get grammarPatterns {
    if (_grammarPatterns is EqualUnmodifiableListView) return _grammarPatterns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_grammarPatterns);
  }

  final List<TopicCommonMistake> _commonMistakes;
  @override
  @JsonKey(name: 'common_mistakes')
  List<TopicCommonMistake> get commonMistakes {
    if (_commonMistakes is EqualUnmodifiableListView) return _commonMistakes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commonMistakes);
  }

  @override
  @JsonKey(name: 'example_answer_en')
  final String exampleAnswerEn;
  @override
  @JsonKey(name: 'example_answer_mm')
  final String exampleAnswerMm;
  final List<String> _warmupQuestions;
  @override
  @JsonKey(name: 'warmup_questions')
  List<String> get warmupQuestions {
    if (_warmupQuestions is EqualUnmodifiableListView) return _warmupQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warmupQuestions);
  }

  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'DailySpeakingTopic(id: $id, title: $title, promptEn: $promptEn, promptMm: $promptMm, difficulty: $difficulty, durationTargetSeconds: $durationTargetSeconds, vocabulary: $vocabulary, targetPhrases: $targetPhrases, outline: $outline, grammarPatterns: $grammarPatterns, commonMistakes: $commonMistakes, exampleAnswerEn: $exampleAnswerEn, exampleAnswerMm: $exampleAnswerMm, warmupQuestions: $warmupQuestions, tags: $tags, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailySpeakingTopicImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.promptEn, promptEn) ||
                other.promptEn == promptEn) &&
            (identical(other.promptMm, promptMm) ||
                other.promptMm == promptMm) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.durationTargetSeconds, durationTargetSeconds) ||
                other.durationTargetSeconds == durationTargetSeconds) &&
            const DeepCollectionEquality()
                .equals(other._vocabulary, _vocabulary) &&
            const DeepCollectionEquality()
                .equals(other._targetPhrases, _targetPhrases) &&
            const DeepCollectionEquality().equals(other._outline, _outline) &&
            const DeepCollectionEquality()
                .equals(other._grammarPatterns, _grammarPatterns) &&
            const DeepCollectionEquality()
                .equals(other._commonMistakes, _commonMistakes) &&
            (identical(other.exampleAnswerEn, exampleAnswerEn) ||
                other.exampleAnswerEn == exampleAnswerEn) &&
            (identical(other.exampleAnswerMm, exampleAnswerMm) ||
                other.exampleAnswerMm == exampleAnswerMm) &&
            const DeepCollectionEquality()
                .equals(other._warmupQuestions, _warmupQuestions) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      promptEn,
      promptMm,
      difficulty,
      durationTargetSeconds,
      const DeepCollectionEquality().hash(_vocabulary),
      const DeepCollectionEquality().hash(_targetPhrases),
      const DeepCollectionEquality().hash(_outline),
      const DeepCollectionEquality().hash(_grammarPatterns),
      const DeepCollectionEquality().hash(_commonMistakes),
      exampleAnswerEn,
      exampleAnswerMm,
      const DeepCollectionEquality().hash(_warmupQuestions),
      const DeepCollectionEquality().hash(_tags),
      createdAt);

  /// Create a copy of DailySpeakingTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailySpeakingTopicImplCopyWith<_$DailySpeakingTopicImpl> get copyWith =>
      __$$DailySpeakingTopicImplCopyWithImpl<_$DailySpeakingTopicImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailySpeakingTopicImplToJson(
      this,
    );
  }
}

abstract class _DailySpeakingTopic implements DailySpeakingTopic {
  const factory _DailySpeakingTopic(
      {required final String id,
      required final String title,
      @JsonKey(name: 'prompt_en') required final String promptEn,
      @JsonKey(name: 'prompt_mm') required final String promptMm,
      final TopicDifficulty difficulty,
      @JsonKey(name: 'duration_target_seconds') final int durationTargetSeconds,
      final List<TopicVocabItem> vocabulary,
      @JsonKey(name: 'target_phrases')
      final List<TopicTargetPhrase> targetPhrases,
      final List<TopicOutlineStep> outline,
      @JsonKey(name: 'grammar_patterns')
      final List<TopicGrammarPattern> grammarPatterns,
      @JsonKey(name: 'common_mistakes')
      final List<TopicCommonMistake> commonMistakes,
      @JsonKey(name: 'example_answer_en') final String exampleAnswerEn,
      @JsonKey(name: 'example_answer_mm') final String exampleAnswerMm,
      @JsonKey(name: 'warmup_questions') final List<String> warmupQuestions,
      final List<String> tags,
      @JsonKey(name: 'created_at')
      final DateTime? createdAt}) = _$DailySpeakingTopicImpl;

  factory _DailySpeakingTopic.fromJson(Map<String, dynamic> json) =
      _$DailySpeakingTopicImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'prompt_en')
  String get promptEn;
  @override
  @JsonKey(name: 'prompt_mm')
  String get promptMm;
  @override
  TopicDifficulty get difficulty;
  @override
  @JsonKey(name: 'duration_target_seconds')
  int get durationTargetSeconds;
  @override
  List<TopicVocabItem> get vocabulary;
  @override
  @JsonKey(name: 'target_phrases')
  List<TopicTargetPhrase> get targetPhrases;

  /// The suggested-topic "guide" fields (P3 prep page). All optional so older
  /// topics and the guided→topic mapping keep working with empty lists.
  /// `outline` is the talk's spine; `grammarPatterns` the structural backbone;
  /// `commonMistakes` Myanmar-interference fixes; `exampleAnswer*` a gated model.
  @override
  List<TopicOutlineStep> get outline;
  @override
  @JsonKey(name: 'grammar_patterns')
  List<TopicGrammarPattern> get grammarPatterns;
  @override
  @JsonKey(name: 'common_mistakes')
  List<TopicCommonMistake> get commonMistakes;
  @override
  @JsonKey(name: 'example_answer_en')
  String get exampleAnswerEn;
  @override
  @JsonKey(name: 'example_answer_mm')
  String get exampleAnswerMm;
  @override
  @JsonKey(name: 'warmup_questions')
  List<String> get warmupQuestions;
  @override
  List<String> get tags;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of DailySpeakingTopic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailySpeakingTopicImplCopyWith<_$DailySpeakingTopicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopicVocabItem _$TopicVocabItemFromJson(Map<String, dynamic> json) {
  return _TopicVocabItem.fromJson(json);
}

/// @nodoc
mixin _$TopicVocabItem {
  String get term => throw _privateConstructorUsedError;
  @JsonKey(name: 'definition_mm')
  String get definitionMm => throw _privateConstructorUsedError;
  @JsonKey(name: 'example_en')
  String get exampleEn => throw _privateConstructorUsedError;

  /// Optional "you could also use" alternatives, shown in the vocab sheet.
  List<String> get related => throw _privateConstructorUsedError;

  /// Serializes this TopicVocabItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopicVocabItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopicVocabItemCopyWith<TopicVocabItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicVocabItemCopyWith<$Res> {
  factory $TopicVocabItemCopyWith(
          TopicVocabItem value, $Res Function(TopicVocabItem) then) =
      _$TopicVocabItemCopyWithImpl<$Res, TopicVocabItem>;
  @useResult
  $Res call(
      {String term,
      @JsonKey(name: 'definition_mm') String definitionMm,
      @JsonKey(name: 'example_en') String exampleEn,
      List<String> related});
}

/// @nodoc
class _$TopicVocabItemCopyWithImpl<$Res, $Val extends TopicVocabItem>
    implements $TopicVocabItemCopyWith<$Res> {
  _$TopicVocabItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopicVocabItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? term = null,
    Object? definitionMm = null,
    Object? exampleEn = null,
    Object? related = null,
  }) {
    return _then(_value.copyWith(
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
      definitionMm: null == definitionMm
          ? _value.definitionMm
          : definitionMm // ignore: cast_nullable_to_non_nullable
              as String,
      exampleEn: null == exampleEn
          ? _value.exampleEn
          : exampleEn // ignore: cast_nullable_to_non_nullable
              as String,
      related: null == related
          ? _value.related
          : related // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopicVocabItemImplCopyWith<$Res>
    implements $TopicVocabItemCopyWith<$Res> {
  factory _$$TopicVocabItemImplCopyWith(_$TopicVocabItemImpl value,
          $Res Function(_$TopicVocabItemImpl) then) =
      __$$TopicVocabItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String term,
      @JsonKey(name: 'definition_mm') String definitionMm,
      @JsonKey(name: 'example_en') String exampleEn,
      List<String> related});
}

/// @nodoc
class __$$TopicVocabItemImplCopyWithImpl<$Res>
    extends _$TopicVocabItemCopyWithImpl<$Res, _$TopicVocabItemImpl>
    implements _$$TopicVocabItemImplCopyWith<$Res> {
  __$$TopicVocabItemImplCopyWithImpl(
      _$TopicVocabItemImpl _value, $Res Function(_$TopicVocabItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopicVocabItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? term = null,
    Object? definitionMm = null,
    Object? exampleEn = null,
    Object? related = null,
  }) {
    return _then(_$TopicVocabItemImpl(
      term: null == term
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
      definitionMm: null == definitionMm
          ? _value.definitionMm
          : definitionMm // ignore: cast_nullable_to_non_nullable
              as String,
      exampleEn: null == exampleEn
          ? _value.exampleEn
          : exampleEn // ignore: cast_nullable_to_non_nullable
              as String,
      related: null == related
          ? _value._related
          : related // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopicVocabItemImpl implements _TopicVocabItem {
  const _$TopicVocabItemImpl(
      {required this.term,
      @JsonKey(name: 'definition_mm') required this.definitionMm,
      @JsonKey(name: 'example_en') required this.exampleEn,
      final List<String> related = const <String>[]})
      : _related = related;

  factory _$TopicVocabItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopicVocabItemImplFromJson(json);

  @override
  final String term;
  @override
  @JsonKey(name: 'definition_mm')
  final String definitionMm;
  @override
  @JsonKey(name: 'example_en')
  final String exampleEn;

  /// Optional "you could also use" alternatives, shown in the vocab sheet.
  final List<String> _related;

  /// Optional "you could also use" alternatives, shown in the vocab sheet.
  @override
  @JsonKey()
  List<String> get related {
    if (_related is EqualUnmodifiableListView) return _related;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_related);
  }

  @override
  String toString() {
    return 'TopicVocabItem(term: $term, definitionMm: $definitionMm, exampleEn: $exampleEn, related: $related)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicVocabItemImpl &&
            (identical(other.term, term) || other.term == term) &&
            (identical(other.definitionMm, definitionMm) ||
                other.definitionMm == definitionMm) &&
            (identical(other.exampleEn, exampleEn) ||
                other.exampleEn == exampleEn) &&
            const DeepCollectionEquality().equals(other._related, _related));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, term, definitionMm, exampleEn,
      const DeepCollectionEquality().hash(_related));

  /// Create a copy of TopicVocabItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicVocabItemImplCopyWith<_$TopicVocabItemImpl> get copyWith =>
      __$$TopicVocabItemImplCopyWithImpl<_$TopicVocabItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopicVocabItemImplToJson(
      this,
    );
  }
}

abstract class _TopicVocabItem implements TopicVocabItem {
  const factory _TopicVocabItem(
      {required final String term,
      @JsonKey(name: 'definition_mm') required final String definitionMm,
      @JsonKey(name: 'example_en') required final String exampleEn,
      final List<String> related}) = _$TopicVocabItemImpl;

  factory _TopicVocabItem.fromJson(Map<String, dynamic> json) =
      _$TopicVocabItemImpl.fromJson;

  @override
  String get term;
  @override
  @JsonKey(name: 'definition_mm')
  String get definitionMm;
  @override
  @JsonKey(name: 'example_en')
  String get exampleEn;

  /// Optional "you could also use" alternatives, shown in the vocab sheet.
  @override
  List<String> get related;

  /// Create a copy of TopicVocabItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicVocabItemImplCopyWith<_$TopicVocabItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopicOutlineStep _$TopicOutlineStepFromJson(Map<String, dynamic> json) {
  return _TopicOutlineStep.fromJson(json);
}

/// @nodoc
mixin _$TopicOutlineStep {
  @JsonKey(name: 'point_en')
  String get pointEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'point_mm')
  String get pointMm => throw _privateConstructorUsedError;
  @JsonKey(name: 'starter_en')
  String get starterEn => throw _privateConstructorUsedError;

  /// Serializes this TopicOutlineStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopicOutlineStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopicOutlineStepCopyWith<TopicOutlineStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicOutlineStepCopyWith<$Res> {
  factory $TopicOutlineStepCopyWith(
          TopicOutlineStep value, $Res Function(TopicOutlineStep) then) =
      _$TopicOutlineStepCopyWithImpl<$Res, TopicOutlineStep>;
  @useResult
  $Res call(
      {@JsonKey(name: 'point_en') String pointEn,
      @JsonKey(name: 'point_mm') String pointMm,
      @JsonKey(name: 'starter_en') String starterEn});
}

/// @nodoc
class _$TopicOutlineStepCopyWithImpl<$Res, $Val extends TopicOutlineStep>
    implements $TopicOutlineStepCopyWith<$Res> {
  _$TopicOutlineStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopicOutlineStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pointEn = null,
    Object? pointMm = null,
    Object? starterEn = null,
  }) {
    return _then(_value.copyWith(
      pointEn: null == pointEn
          ? _value.pointEn
          : pointEn // ignore: cast_nullable_to_non_nullable
              as String,
      pointMm: null == pointMm
          ? _value.pointMm
          : pointMm // ignore: cast_nullable_to_non_nullable
              as String,
      starterEn: null == starterEn
          ? _value.starterEn
          : starterEn // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopicOutlineStepImplCopyWith<$Res>
    implements $TopicOutlineStepCopyWith<$Res> {
  factory _$$TopicOutlineStepImplCopyWith(_$TopicOutlineStepImpl value,
          $Res Function(_$TopicOutlineStepImpl) then) =
      __$$TopicOutlineStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'point_en') String pointEn,
      @JsonKey(name: 'point_mm') String pointMm,
      @JsonKey(name: 'starter_en') String starterEn});
}

/// @nodoc
class __$$TopicOutlineStepImplCopyWithImpl<$Res>
    extends _$TopicOutlineStepCopyWithImpl<$Res, _$TopicOutlineStepImpl>
    implements _$$TopicOutlineStepImplCopyWith<$Res> {
  __$$TopicOutlineStepImplCopyWithImpl(_$TopicOutlineStepImpl _value,
      $Res Function(_$TopicOutlineStepImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopicOutlineStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pointEn = null,
    Object? pointMm = null,
    Object? starterEn = null,
  }) {
    return _then(_$TopicOutlineStepImpl(
      pointEn: null == pointEn
          ? _value.pointEn
          : pointEn // ignore: cast_nullable_to_non_nullable
              as String,
      pointMm: null == pointMm
          ? _value.pointMm
          : pointMm // ignore: cast_nullable_to_non_nullable
              as String,
      starterEn: null == starterEn
          ? _value.starterEn
          : starterEn // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopicOutlineStepImpl implements _TopicOutlineStep {
  const _$TopicOutlineStepImpl(
      {@JsonKey(name: 'point_en') required this.pointEn,
      @JsonKey(name: 'point_mm') this.pointMm = '',
      @JsonKey(name: 'starter_en') this.starterEn = ''});

  factory _$TopicOutlineStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopicOutlineStepImplFromJson(json);

  @override
  @JsonKey(name: 'point_en')
  final String pointEn;
  @override
  @JsonKey(name: 'point_mm')
  final String pointMm;
  @override
  @JsonKey(name: 'starter_en')
  final String starterEn;

  @override
  String toString() {
    return 'TopicOutlineStep(pointEn: $pointEn, pointMm: $pointMm, starterEn: $starterEn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicOutlineStepImpl &&
            (identical(other.pointEn, pointEn) || other.pointEn == pointEn) &&
            (identical(other.pointMm, pointMm) || other.pointMm == pointMm) &&
            (identical(other.starterEn, starterEn) ||
                other.starterEn == starterEn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pointEn, pointMm, starterEn);

  /// Create a copy of TopicOutlineStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicOutlineStepImplCopyWith<_$TopicOutlineStepImpl> get copyWith =>
      __$$TopicOutlineStepImplCopyWithImpl<_$TopicOutlineStepImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopicOutlineStepImplToJson(
      this,
    );
  }
}

abstract class _TopicOutlineStep implements TopicOutlineStep {
  const factory _TopicOutlineStep(
          {@JsonKey(name: 'point_en') required final String pointEn,
          @JsonKey(name: 'point_mm') final String pointMm,
          @JsonKey(name: 'starter_en') final String starterEn}) =
      _$TopicOutlineStepImpl;

  factory _TopicOutlineStep.fromJson(Map<String, dynamic> json) =
      _$TopicOutlineStepImpl.fromJson;

  @override
  @JsonKey(name: 'point_en')
  String get pointEn;
  @override
  @JsonKey(name: 'point_mm')
  String get pointMm;
  @override
  @JsonKey(name: 'starter_en')
  String get starterEn;

  /// Create a copy of TopicOutlineStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicOutlineStepImplCopyWith<_$TopicOutlineStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopicGrammarPattern _$TopicGrammarPatternFromJson(Map<String, dynamic> json) {
  return _TopicGrammarPattern.fromJson(json);
}

/// @nodoc
mixin _$TopicGrammarPattern {
  @JsonKey(name: 'pattern_en')
  String get patternEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'example_en')
  String get exampleEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'note_mm')
  String get noteMm => throw _privateConstructorUsedError;

  /// Serializes this TopicGrammarPattern to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopicGrammarPattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopicGrammarPatternCopyWith<TopicGrammarPattern> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicGrammarPatternCopyWith<$Res> {
  factory $TopicGrammarPatternCopyWith(
          TopicGrammarPattern value, $Res Function(TopicGrammarPattern) then) =
      _$TopicGrammarPatternCopyWithImpl<$Res, TopicGrammarPattern>;
  @useResult
  $Res call(
      {@JsonKey(name: 'pattern_en') String patternEn,
      @JsonKey(name: 'example_en') String exampleEn,
      @JsonKey(name: 'note_mm') String noteMm});
}

/// @nodoc
class _$TopicGrammarPatternCopyWithImpl<$Res, $Val extends TopicGrammarPattern>
    implements $TopicGrammarPatternCopyWith<$Res> {
  _$TopicGrammarPatternCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopicGrammarPattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patternEn = null,
    Object? exampleEn = null,
    Object? noteMm = null,
  }) {
    return _then(_value.copyWith(
      patternEn: null == patternEn
          ? _value.patternEn
          : patternEn // ignore: cast_nullable_to_non_nullable
              as String,
      exampleEn: null == exampleEn
          ? _value.exampleEn
          : exampleEn // ignore: cast_nullable_to_non_nullable
              as String,
      noteMm: null == noteMm
          ? _value.noteMm
          : noteMm // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopicGrammarPatternImplCopyWith<$Res>
    implements $TopicGrammarPatternCopyWith<$Res> {
  factory _$$TopicGrammarPatternImplCopyWith(_$TopicGrammarPatternImpl value,
          $Res Function(_$TopicGrammarPatternImpl) then) =
      __$$TopicGrammarPatternImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'pattern_en') String patternEn,
      @JsonKey(name: 'example_en') String exampleEn,
      @JsonKey(name: 'note_mm') String noteMm});
}

/// @nodoc
class __$$TopicGrammarPatternImplCopyWithImpl<$Res>
    extends _$TopicGrammarPatternCopyWithImpl<$Res, _$TopicGrammarPatternImpl>
    implements _$$TopicGrammarPatternImplCopyWith<$Res> {
  __$$TopicGrammarPatternImplCopyWithImpl(_$TopicGrammarPatternImpl _value,
      $Res Function(_$TopicGrammarPatternImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopicGrammarPattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patternEn = null,
    Object? exampleEn = null,
    Object? noteMm = null,
  }) {
    return _then(_$TopicGrammarPatternImpl(
      patternEn: null == patternEn
          ? _value.patternEn
          : patternEn // ignore: cast_nullable_to_non_nullable
              as String,
      exampleEn: null == exampleEn
          ? _value.exampleEn
          : exampleEn // ignore: cast_nullable_to_non_nullable
              as String,
      noteMm: null == noteMm
          ? _value.noteMm
          : noteMm // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopicGrammarPatternImpl implements _TopicGrammarPattern {
  const _$TopicGrammarPatternImpl(
      {@JsonKey(name: 'pattern_en') required this.patternEn,
      @JsonKey(name: 'example_en') this.exampleEn = '',
      @JsonKey(name: 'note_mm') this.noteMm = ''});

  factory _$TopicGrammarPatternImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopicGrammarPatternImplFromJson(json);

  @override
  @JsonKey(name: 'pattern_en')
  final String patternEn;
  @override
  @JsonKey(name: 'example_en')
  final String exampleEn;
  @override
  @JsonKey(name: 'note_mm')
  final String noteMm;

  @override
  String toString() {
    return 'TopicGrammarPattern(patternEn: $patternEn, exampleEn: $exampleEn, noteMm: $noteMm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicGrammarPatternImpl &&
            (identical(other.patternEn, patternEn) ||
                other.patternEn == patternEn) &&
            (identical(other.exampleEn, exampleEn) ||
                other.exampleEn == exampleEn) &&
            (identical(other.noteMm, noteMm) || other.noteMm == noteMm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, patternEn, exampleEn, noteMm);

  /// Create a copy of TopicGrammarPattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicGrammarPatternImplCopyWith<_$TopicGrammarPatternImpl> get copyWith =>
      __$$TopicGrammarPatternImplCopyWithImpl<_$TopicGrammarPatternImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopicGrammarPatternImplToJson(
      this,
    );
  }
}

abstract class _TopicGrammarPattern implements TopicGrammarPattern {
  const factory _TopicGrammarPattern(
          {@JsonKey(name: 'pattern_en') required final String patternEn,
          @JsonKey(name: 'example_en') final String exampleEn,
          @JsonKey(name: 'note_mm') final String noteMm}) =
      _$TopicGrammarPatternImpl;

  factory _TopicGrammarPattern.fromJson(Map<String, dynamic> json) =
      _$TopicGrammarPatternImpl.fromJson;

  @override
  @JsonKey(name: 'pattern_en')
  String get patternEn;
  @override
  @JsonKey(name: 'example_en')
  String get exampleEn;
  @override
  @JsonKey(name: 'note_mm')
  String get noteMm;

  /// Create a copy of TopicGrammarPattern
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicGrammarPatternImplCopyWith<_$TopicGrammarPatternImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopicCommonMistake _$TopicCommonMistakeFromJson(Map<String, dynamic> json) {
  return _TopicCommonMistake.fromJson(json);
}

/// @nodoc
mixin _$TopicCommonMistake {
  @JsonKey(name: 'avoid_en')
  String get avoidEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'use_en')
  String get useEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'note_mm')
  String get noteMm => throw _privateConstructorUsedError;

  /// Serializes this TopicCommonMistake to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopicCommonMistake
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopicCommonMistakeCopyWith<TopicCommonMistake> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicCommonMistakeCopyWith<$Res> {
  factory $TopicCommonMistakeCopyWith(
          TopicCommonMistake value, $Res Function(TopicCommonMistake) then) =
      _$TopicCommonMistakeCopyWithImpl<$Res, TopicCommonMistake>;
  @useResult
  $Res call(
      {@JsonKey(name: 'avoid_en') String avoidEn,
      @JsonKey(name: 'use_en') String useEn,
      @JsonKey(name: 'note_mm') String noteMm});
}

/// @nodoc
class _$TopicCommonMistakeCopyWithImpl<$Res, $Val extends TopicCommonMistake>
    implements $TopicCommonMistakeCopyWith<$Res> {
  _$TopicCommonMistakeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopicCommonMistake
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avoidEn = null,
    Object? useEn = null,
    Object? noteMm = null,
  }) {
    return _then(_value.copyWith(
      avoidEn: null == avoidEn
          ? _value.avoidEn
          : avoidEn // ignore: cast_nullable_to_non_nullable
              as String,
      useEn: null == useEn
          ? _value.useEn
          : useEn // ignore: cast_nullable_to_non_nullable
              as String,
      noteMm: null == noteMm
          ? _value.noteMm
          : noteMm // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopicCommonMistakeImplCopyWith<$Res>
    implements $TopicCommonMistakeCopyWith<$Res> {
  factory _$$TopicCommonMistakeImplCopyWith(_$TopicCommonMistakeImpl value,
          $Res Function(_$TopicCommonMistakeImpl) then) =
      __$$TopicCommonMistakeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'avoid_en') String avoidEn,
      @JsonKey(name: 'use_en') String useEn,
      @JsonKey(name: 'note_mm') String noteMm});
}

/// @nodoc
class __$$TopicCommonMistakeImplCopyWithImpl<$Res>
    extends _$TopicCommonMistakeCopyWithImpl<$Res, _$TopicCommonMistakeImpl>
    implements _$$TopicCommonMistakeImplCopyWith<$Res> {
  __$$TopicCommonMistakeImplCopyWithImpl(_$TopicCommonMistakeImpl _value,
      $Res Function(_$TopicCommonMistakeImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopicCommonMistake
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avoidEn = null,
    Object? useEn = null,
    Object? noteMm = null,
  }) {
    return _then(_$TopicCommonMistakeImpl(
      avoidEn: null == avoidEn
          ? _value.avoidEn
          : avoidEn // ignore: cast_nullable_to_non_nullable
              as String,
      useEn: null == useEn
          ? _value.useEn
          : useEn // ignore: cast_nullable_to_non_nullable
              as String,
      noteMm: null == noteMm
          ? _value.noteMm
          : noteMm // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopicCommonMistakeImpl implements _TopicCommonMistake {
  const _$TopicCommonMistakeImpl(
      {@JsonKey(name: 'avoid_en') required this.avoidEn,
      @JsonKey(name: 'use_en') required this.useEn,
      @JsonKey(name: 'note_mm') this.noteMm = ''});

  factory _$TopicCommonMistakeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopicCommonMistakeImplFromJson(json);

  @override
  @JsonKey(name: 'avoid_en')
  final String avoidEn;
  @override
  @JsonKey(name: 'use_en')
  final String useEn;
  @override
  @JsonKey(name: 'note_mm')
  final String noteMm;

  @override
  String toString() {
    return 'TopicCommonMistake(avoidEn: $avoidEn, useEn: $useEn, noteMm: $noteMm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicCommonMistakeImpl &&
            (identical(other.avoidEn, avoidEn) || other.avoidEn == avoidEn) &&
            (identical(other.useEn, useEn) || other.useEn == useEn) &&
            (identical(other.noteMm, noteMm) || other.noteMm == noteMm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, avoidEn, useEn, noteMm);

  /// Create a copy of TopicCommonMistake
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicCommonMistakeImplCopyWith<_$TopicCommonMistakeImpl> get copyWith =>
      __$$TopicCommonMistakeImplCopyWithImpl<_$TopicCommonMistakeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopicCommonMistakeImplToJson(
      this,
    );
  }
}

abstract class _TopicCommonMistake implements TopicCommonMistake {
  const factory _TopicCommonMistake(
          {@JsonKey(name: 'avoid_en') required final String avoidEn,
          @JsonKey(name: 'use_en') required final String useEn,
          @JsonKey(name: 'note_mm') final String noteMm}) =
      _$TopicCommonMistakeImpl;

  factory _TopicCommonMistake.fromJson(Map<String, dynamic> json) =
      _$TopicCommonMistakeImpl.fromJson;

  @override
  @JsonKey(name: 'avoid_en')
  String get avoidEn;
  @override
  @JsonKey(name: 'use_en')
  String get useEn;
  @override
  @JsonKey(name: 'note_mm')
  String get noteMm;

  /// Create a copy of TopicCommonMistake
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicCommonMistakeImplCopyWith<_$TopicCommonMistakeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopicTargetPhrase _$TopicTargetPhraseFromJson(Map<String, dynamic> json) {
  return _TopicTargetPhrase.fromJson(json);
}

/// @nodoc
mixin _$TopicTargetPhrase {
  @JsonKey(name: 'phrase_en')
  String get phraseEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'translation_mm')
  String get translationMm => throw _privateConstructorUsedError;

  /// Serializes this TopicTargetPhrase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopicTargetPhrase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopicTargetPhraseCopyWith<TopicTargetPhrase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicTargetPhraseCopyWith<$Res> {
  factory $TopicTargetPhraseCopyWith(
          TopicTargetPhrase value, $Res Function(TopicTargetPhrase) then) =
      _$TopicTargetPhraseCopyWithImpl<$Res, TopicTargetPhrase>;
  @useResult
  $Res call(
      {@JsonKey(name: 'phrase_en') String phraseEn,
      @JsonKey(name: 'translation_mm') String translationMm});
}

/// @nodoc
class _$TopicTargetPhraseCopyWithImpl<$Res, $Val extends TopicTargetPhrase>
    implements $TopicTargetPhraseCopyWith<$Res> {
  _$TopicTargetPhraseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopicTargetPhrase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phraseEn = null,
    Object? translationMm = null,
  }) {
    return _then(_value.copyWith(
      phraseEn: null == phraseEn
          ? _value.phraseEn
          : phraseEn // ignore: cast_nullable_to_non_nullable
              as String,
      translationMm: null == translationMm
          ? _value.translationMm
          : translationMm // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopicTargetPhraseImplCopyWith<$Res>
    implements $TopicTargetPhraseCopyWith<$Res> {
  factory _$$TopicTargetPhraseImplCopyWith(_$TopicTargetPhraseImpl value,
          $Res Function(_$TopicTargetPhraseImpl) then) =
      __$$TopicTargetPhraseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'phrase_en') String phraseEn,
      @JsonKey(name: 'translation_mm') String translationMm});
}

/// @nodoc
class __$$TopicTargetPhraseImplCopyWithImpl<$Res>
    extends _$TopicTargetPhraseCopyWithImpl<$Res, _$TopicTargetPhraseImpl>
    implements _$$TopicTargetPhraseImplCopyWith<$Res> {
  __$$TopicTargetPhraseImplCopyWithImpl(_$TopicTargetPhraseImpl _value,
      $Res Function(_$TopicTargetPhraseImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopicTargetPhrase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phraseEn = null,
    Object? translationMm = null,
  }) {
    return _then(_$TopicTargetPhraseImpl(
      phraseEn: null == phraseEn
          ? _value.phraseEn
          : phraseEn // ignore: cast_nullable_to_non_nullable
              as String,
      translationMm: null == translationMm
          ? _value.translationMm
          : translationMm // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopicTargetPhraseImpl implements _TopicTargetPhrase {
  const _$TopicTargetPhraseImpl(
      {@JsonKey(name: 'phrase_en') required this.phraseEn,
      @JsonKey(name: 'translation_mm') required this.translationMm});

  factory _$TopicTargetPhraseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopicTargetPhraseImplFromJson(json);

  @override
  @JsonKey(name: 'phrase_en')
  final String phraseEn;
  @override
  @JsonKey(name: 'translation_mm')
  final String translationMm;

  @override
  String toString() {
    return 'TopicTargetPhrase(phraseEn: $phraseEn, translationMm: $translationMm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicTargetPhraseImpl &&
            (identical(other.phraseEn, phraseEn) ||
                other.phraseEn == phraseEn) &&
            (identical(other.translationMm, translationMm) ||
                other.translationMm == translationMm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phraseEn, translationMm);

  /// Create a copy of TopicTargetPhrase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicTargetPhraseImplCopyWith<_$TopicTargetPhraseImpl> get copyWith =>
      __$$TopicTargetPhraseImplCopyWithImpl<_$TopicTargetPhraseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopicTargetPhraseImplToJson(
      this,
    );
  }
}

abstract class _TopicTargetPhrase implements TopicTargetPhrase {
  const factory _TopicTargetPhrase(
      {@JsonKey(name: 'phrase_en') required final String phraseEn,
      @JsonKey(name: 'translation_mm')
      required final String translationMm}) = _$TopicTargetPhraseImpl;

  factory _TopicTargetPhrase.fromJson(Map<String, dynamic> json) =
      _$TopicTargetPhraseImpl.fromJson;

  @override
  @JsonKey(name: 'phrase_en')
  String get phraseEn;
  @override
  @JsonKey(name: 'translation_mm')
  String get translationMm;

  /// Create a copy of TopicTargetPhrase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicTargetPhraseImplCopyWith<_$TopicTargetPhraseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
