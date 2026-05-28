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
  @JsonKey(name: 'warmup_questions')
  List<String> get warmupQuestions => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'warmup_questions') List<String> warmupQuestions,
      List<String> tags});
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
    Object? warmupQuestions = null,
    Object? tags = null,
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
      warmupQuestions: null == warmupQuestions
          ? _value.warmupQuestions
          : warmupQuestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      @JsonKey(name: 'warmup_questions') List<String> warmupQuestions,
      List<String> tags});
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
    Object? warmupQuestions = null,
    Object? tags = null,
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
      warmupQuestions: null == warmupQuestions
          ? _value._warmupQuestions
          : warmupQuestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      @JsonKey(name: 'warmup_questions')
      final List<String> warmupQuestions = const <String>[],
      final List<String> tags = const <String>[]})
      : _vocabulary = vocabulary,
        _targetPhrases = targetPhrases,
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
  String toString() {
    return 'DailySpeakingTopic(id: $id, title: $title, promptEn: $promptEn, promptMm: $promptMm, difficulty: $difficulty, durationTargetSeconds: $durationTargetSeconds, vocabulary: $vocabulary, targetPhrases: $targetPhrases, warmupQuestions: $warmupQuestions, tags: $tags)';
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
            const DeepCollectionEquality()
                .equals(other._warmupQuestions, _warmupQuestions) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
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
      const DeepCollectionEquality().hash(_warmupQuestions),
      const DeepCollectionEquality().hash(_tags));

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
      @JsonKey(name: 'warmup_questions') final List<String> warmupQuestions,
      final List<String> tags}) = _$DailySpeakingTopicImpl;

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
  @override
  @JsonKey(name: 'warmup_questions')
  List<String> get warmupQuestions;
  @override
  List<String> get tags;

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
      @JsonKey(name: 'example_en') String exampleEn});
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
      @JsonKey(name: 'example_en') String exampleEn});
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopicVocabItemImpl implements _TopicVocabItem {
  const _$TopicVocabItemImpl(
      {required this.term,
      @JsonKey(name: 'definition_mm') required this.definitionMm,
      @JsonKey(name: 'example_en') required this.exampleEn});

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

  @override
  String toString() {
    return 'TopicVocabItem(term: $term, definitionMm: $definitionMm, exampleEn: $exampleEn)';
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
                other.exampleEn == exampleEn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, term, definitionMm, exampleEn);

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
          @JsonKey(name: 'example_en') required final String exampleEn}) =
      _$TopicVocabItemImpl;

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

  /// Create a copy of TopicVocabItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicVocabItemImplCopyWith<_$TopicVocabItemImpl> get copyWith =>
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
