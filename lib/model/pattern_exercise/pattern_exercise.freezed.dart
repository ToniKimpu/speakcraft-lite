// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pattern_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PatternExercise _$PatternExerciseFromJson(Map<String, dynamic> json) {
  return _PatternExercise.fromJson(json);
}

/// @nodoc
mixin _$PatternExercise {
  @JsonKey(name: 'pattern_exercise_id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'burmese_text')
  String get burmeseText => throw _privateConstructorUsedError;
  @JsonKey(name: 'english_text')
  String get englishText => throw _privateConstructorUsedError;
  @JsonKey(name: 'audio_path')
  String? get audioPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'pattern_id')
  int? get patternId => throw _privateConstructorUsedError;
  String? get pattern => throw _privateConstructorUsedError;
  @JsonKey(name: 'vocabularies')
  List<PatternVocabulary> get vocabularies =>
      throw _privateConstructorUsedError;
  String? get words => throw _privateConstructorUsedError;
  String? get userAnswer => throw _privateConstructorUsedError;

  /// Serializes this PatternExercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatternExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatternExerciseCopyWith<PatternExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatternExerciseCopyWith<$Res> {
  factory $PatternExerciseCopyWith(
          PatternExercise value, $Res Function(PatternExercise) then) =
      _$PatternExerciseCopyWithImpl<$Res, PatternExercise>;
  @useResult
  $Res call(
      {@JsonKey(name: 'pattern_exercise_id') int id,
      @JsonKey(name: 'burmese_text') String burmeseText,
      @JsonKey(name: 'english_text') String englishText,
      @JsonKey(name: 'audio_path') String? audioPath,
      @JsonKey(name: 'pattern_id') int? patternId,
      String? pattern,
      @JsonKey(name: 'vocabularies') List<PatternVocabulary> vocabularies,
      String? words,
      String? userAnswer});
}

/// @nodoc
class _$PatternExerciseCopyWithImpl<$Res, $Val extends PatternExercise>
    implements $PatternExerciseCopyWith<$Res> {
  _$PatternExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatternExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? burmeseText = null,
    Object? englishText = null,
    Object? audioPath = freezed,
    Object? patternId = freezed,
    Object? pattern = freezed,
    Object? vocabularies = null,
    Object? words = freezed,
    Object? userAnswer = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      burmeseText: null == burmeseText
          ? _value.burmeseText
          : burmeseText // ignore: cast_nullable_to_non_nullable
              as String,
      englishText: null == englishText
          ? _value.englishText
          : englishText // ignore: cast_nullable_to_non_nullable
              as String,
      audioPath: freezed == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String?,
      patternId: freezed == patternId
          ? _value.patternId
          : patternId // ignore: cast_nullable_to_non_nullable
              as int?,
      pattern: freezed == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String?,
      vocabularies: null == vocabularies
          ? _value.vocabularies
          : vocabularies // ignore: cast_nullable_to_non_nullable
              as List<PatternVocabulary>,
      words: freezed == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as String?,
      userAnswer: freezed == userAnswer
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatternExerciseImplCopyWith<$Res>
    implements $PatternExerciseCopyWith<$Res> {
  factory _$$PatternExerciseImplCopyWith(_$PatternExerciseImpl value,
          $Res Function(_$PatternExerciseImpl) then) =
      __$$PatternExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'pattern_exercise_id') int id,
      @JsonKey(name: 'burmese_text') String burmeseText,
      @JsonKey(name: 'english_text') String englishText,
      @JsonKey(name: 'audio_path') String? audioPath,
      @JsonKey(name: 'pattern_id') int? patternId,
      String? pattern,
      @JsonKey(name: 'vocabularies') List<PatternVocabulary> vocabularies,
      String? words,
      String? userAnswer});
}

/// @nodoc
class __$$PatternExerciseImplCopyWithImpl<$Res>
    extends _$PatternExerciseCopyWithImpl<$Res, _$PatternExerciseImpl>
    implements _$$PatternExerciseImplCopyWith<$Res> {
  __$$PatternExerciseImplCopyWithImpl(
      _$PatternExerciseImpl _value, $Res Function(_$PatternExerciseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? burmeseText = null,
    Object? englishText = null,
    Object? audioPath = freezed,
    Object? patternId = freezed,
    Object? pattern = freezed,
    Object? vocabularies = null,
    Object? words = freezed,
    Object? userAnswer = freezed,
  }) {
    return _then(_$PatternExerciseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      burmeseText: null == burmeseText
          ? _value.burmeseText
          : burmeseText // ignore: cast_nullable_to_non_nullable
              as String,
      englishText: null == englishText
          ? _value.englishText
          : englishText // ignore: cast_nullable_to_non_nullable
              as String,
      audioPath: freezed == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String?,
      patternId: freezed == patternId
          ? _value.patternId
          : patternId // ignore: cast_nullable_to_non_nullable
              as int?,
      pattern: freezed == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String?,
      vocabularies: null == vocabularies
          ? _value._vocabularies
          : vocabularies // ignore: cast_nullable_to_non_nullable
              as List<PatternVocabulary>,
      words: freezed == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as String?,
      userAnswer: freezed == userAnswer
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatternExerciseImpl implements _PatternExercise {
  const _$PatternExerciseImpl(
      {@JsonKey(name: 'pattern_exercise_id') required this.id,
      @JsonKey(name: 'burmese_text') required this.burmeseText,
      @JsonKey(name: 'english_text') required this.englishText,
      @JsonKey(name: 'audio_path') this.audioPath,
      @JsonKey(name: 'pattern_id') this.patternId,
      this.pattern,
      @JsonKey(name: 'vocabularies')
      required final List<PatternVocabulary> vocabularies,
      this.words,
      this.userAnswer})
      : _vocabularies = vocabularies;

  factory _$PatternExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatternExerciseImplFromJson(json);

  @override
  @JsonKey(name: 'pattern_exercise_id')
  final int id;
  @override
  @JsonKey(name: 'burmese_text')
  final String burmeseText;
  @override
  @JsonKey(name: 'english_text')
  final String englishText;
  @override
  @JsonKey(name: 'audio_path')
  final String? audioPath;
  @override
  @JsonKey(name: 'pattern_id')
  final int? patternId;
  @override
  final String? pattern;
  final List<PatternVocabulary> _vocabularies;
  @override
  @JsonKey(name: 'vocabularies')
  List<PatternVocabulary> get vocabularies {
    if (_vocabularies is EqualUnmodifiableListView) return _vocabularies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_vocabularies);
  }

  @override
  final String? words;
  @override
  final String? userAnswer;

  @override
  String toString() {
    return 'PatternExercise(id: $id, burmeseText: $burmeseText, englishText: $englishText, audioPath: $audioPath, patternId: $patternId, pattern: $pattern, vocabularies: $vocabularies, words: $words, userAnswer: $userAnswer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatternExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.burmeseText, burmeseText) ||
                other.burmeseText == burmeseText) &&
            (identical(other.englishText, englishText) ||
                other.englishText == englishText) &&
            (identical(other.audioPath, audioPath) ||
                other.audioPath == audioPath) &&
            (identical(other.patternId, patternId) ||
                other.patternId == patternId) &&
            (identical(other.pattern, pattern) || other.pattern == pattern) &&
            const DeepCollectionEquality()
                .equals(other._vocabularies, _vocabularies) &&
            (identical(other.words, words) || other.words == words) &&
            (identical(other.userAnswer, userAnswer) ||
                other.userAnswer == userAnswer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      burmeseText,
      englishText,
      audioPath,
      patternId,
      pattern,
      const DeepCollectionEquality().hash(_vocabularies),
      words,
      userAnswer);

  /// Create a copy of PatternExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatternExerciseImplCopyWith<_$PatternExerciseImpl> get copyWith =>
      __$$PatternExerciseImplCopyWithImpl<_$PatternExerciseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatternExerciseImplToJson(
      this,
    );
  }
}

abstract class _PatternExercise implements PatternExercise {
  const factory _PatternExercise(
      {@JsonKey(name: 'pattern_exercise_id') required final int id,
      @JsonKey(name: 'burmese_text') required final String burmeseText,
      @JsonKey(name: 'english_text') required final String englishText,
      @JsonKey(name: 'audio_path') final String? audioPath,
      @JsonKey(name: 'pattern_id') final int? patternId,
      final String? pattern,
      @JsonKey(name: 'vocabularies')
      required final List<PatternVocabulary> vocabularies,
      final String? words,
      final String? userAnswer}) = _$PatternExerciseImpl;

  factory _PatternExercise.fromJson(Map<String, dynamic> json) =
      _$PatternExerciseImpl.fromJson;

  @override
  @JsonKey(name: 'pattern_exercise_id')
  int get id;
  @override
  @JsonKey(name: 'burmese_text')
  String get burmeseText;
  @override
  @JsonKey(name: 'english_text')
  String get englishText;
  @override
  @JsonKey(name: 'audio_path')
  String? get audioPath;
  @override
  @JsonKey(name: 'pattern_id')
  int? get patternId;
  @override
  String? get pattern;
  @override
  @JsonKey(name: 'vocabularies')
  List<PatternVocabulary> get vocabularies;
  @override
  String? get words;
  @override
  String? get userAnswer;

  /// Create a copy of PatternExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatternExerciseImplCopyWith<_$PatternExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
