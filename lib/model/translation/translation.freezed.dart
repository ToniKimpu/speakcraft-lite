// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Translation _$TranslationFromJson(Map<String, dynamic> json) {
  return _Translation.fromJson(json);
}

/// @nodoc
mixin _$Translation {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'english_text')
  String get englishText => throw _privateConstructorUsedError;
  @JsonKey(name: 'burmese_text')
  String get burmeseText => throw _privateConstructorUsedError;
  @JsonKey(name: 'words')
  String? get words => throw _privateConstructorUsedError;
  @JsonKey(name: 'audio_path')
  String? get audioPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'vocabularies')
  List<PatternVocabulary>? get vocabularies =>
      throw _privateConstructorUsedError;
  String? get userAnswer => throw _privateConstructorUsedError;

  /// Serializes this Translation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Translation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TranslationCopyWith<Translation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationCopyWith<$Res> {
  factory $TranslationCopyWith(
          Translation value, $Res Function(Translation) then) =
      _$TranslationCopyWithImpl<$Res, Translation>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'english_text') String englishText,
      @JsonKey(name: 'burmese_text') String burmeseText,
      @JsonKey(name: 'words') String? words,
      @JsonKey(name: 'audio_path') String? audioPath,
      @JsonKey(name: 'vocabularies') List<PatternVocabulary>? vocabularies,
      String? userAnswer});
}

/// @nodoc
class _$TranslationCopyWithImpl<$Res, $Val extends Translation>
    implements $TranslationCopyWith<$Res> {
  _$TranslationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Translation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? englishText = null,
    Object? burmeseText = null,
    Object? words = freezed,
    Object? audioPath = freezed,
    Object? vocabularies = freezed,
    Object? userAnswer = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      englishText: null == englishText
          ? _value.englishText
          : englishText // ignore: cast_nullable_to_non_nullable
              as String,
      burmeseText: null == burmeseText
          ? _value.burmeseText
          : burmeseText // ignore: cast_nullable_to_non_nullable
              as String,
      words: freezed == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as String?,
      audioPath: freezed == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String?,
      vocabularies: freezed == vocabularies
          ? _value.vocabularies
          : vocabularies // ignore: cast_nullable_to_non_nullable
              as List<PatternVocabulary>?,
      userAnswer: freezed == userAnswer
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TranslationImplCopyWith<$Res>
    implements $TranslationCopyWith<$Res> {
  factory _$$TranslationImplCopyWith(
          _$TranslationImpl value, $Res Function(_$TranslationImpl) then) =
      __$$TranslationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'english_text') String englishText,
      @JsonKey(name: 'burmese_text') String burmeseText,
      @JsonKey(name: 'words') String? words,
      @JsonKey(name: 'audio_path') String? audioPath,
      @JsonKey(name: 'vocabularies') List<PatternVocabulary>? vocabularies,
      String? userAnswer});
}

/// @nodoc
class __$$TranslationImplCopyWithImpl<$Res>
    extends _$TranslationCopyWithImpl<$Res, _$TranslationImpl>
    implements _$$TranslationImplCopyWith<$Res> {
  __$$TranslationImplCopyWithImpl(
      _$TranslationImpl _value, $Res Function(_$TranslationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Translation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? englishText = null,
    Object? burmeseText = null,
    Object? words = freezed,
    Object? audioPath = freezed,
    Object? vocabularies = freezed,
    Object? userAnswer = freezed,
  }) {
    return _then(_$TranslationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      englishText: null == englishText
          ? _value.englishText
          : englishText // ignore: cast_nullable_to_non_nullable
              as String,
      burmeseText: null == burmeseText
          ? _value.burmeseText
          : burmeseText // ignore: cast_nullable_to_non_nullable
              as String,
      words: freezed == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as String?,
      audioPath: freezed == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String?,
      vocabularies: freezed == vocabularies
          ? _value._vocabularies
          : vocabularies // ignore: cast_nullable_to_non_nullable
              as List<PatternVocabulary>?,
      userAnswer: freezed == userAnswer
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TranslationImpl implements _Translation {
  const _$TranslationImpl(
      {required this.id,
      @JsonKey(name: 'english_text') required this.englishText,
      @JsonKey(name: 'burmese_text') required this.burmeseText,
      @JsonKey(name: 'words') this.words,
      @JsonKey(name: 'audio_path') this.audioPath,
      @JsonKey(name: 'vocabularies')
      final List<PatternVocabulary>? vocabularies,
      this.userAnswer})
      : _vocabularies = vocabularies;

  factory _$TranslationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TranslationImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'english_text')
  final String englishText;
  @override
  @JsonKey(name: 'burmese_text')
  final String burmeseText;
  @override
  @JsonKey(name: 'words')
  final String? words;
  @override
  @JsonKey(name: 'audio_path')
  final String? audioPath;
  final List<PatternVocabulary>? _vocabularies;
  @override
  @JsonKey(name: 'vocabularies')
  List<PatternVocabulary>? get vocabularies {
    final value = _vocabularies;
    if (value == null) return null;
    if (_vocabularies is EqualUnmodifiableListView) return _vocabularies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? userAnswer;

  @override
  String toString() {
    return 'Translation(id: $id, englishText: $englishText, burmeseText: $burmeseText, words: $words, audioPath: $audioPath, vocabularies: $vocabularies, userAnswer: $userAnswer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.englishText, englishText) ||
                other.englishText == englishText) &&
            (identical(other.burmeseText, burmeseText) ||
                other.burmeseText == burmeseText) &&
            (identical(other.words, words) || other.words == words) &&
            (identical(other.audioPath, audioPath) ||
                other.audioPath == audioPath) &&
            const DeepCollectionEquality()
                .equals(other._vocabularies, _vocabularies) &&
            (identical(other.userAnswer, userAnswer) ||
                other.userAnswer == userAnswer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      englishText,
      burmeseText,
      words,
      audioPath,
      const DeepCollectionEquality().hash(_vocabularies),
      userAnswer);

  /// Create a copy of Translation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationImplCopyWith<_$TranslationImpl> get copyWith =>
      __$$TranslationImplCopyWithImpl<_$TranslationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TranslationImplToJson(
      this,
    );
  }
}

abstract class _Translation implements Translation {
  const factory _Translation(
      {required final int id,
      @JsonKey(name: 'english_text') required final String englishText,
      @JsonKey(name: 'burmese_text') required final String burmeseText,
      @JsonKey(name: 'words') final String? words,
      @JsonKey(name: 'audio_path') final String? audioPath,
      @JsonKey(name: 'vocabularies')
      final List<PatternVocabulary>? vocabularies,
      final String? userAnswer}) = _$TranslationImpl;

  factory _Translation.fromJson(Map<String, dynamic> json) =
      _$TranslationImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'english_text')
  String get englishText;
  @override
  @JsonKey(name: 'burmese_text')
  String get burmeseText;
  @override
  @JsonKey(name: 'words')
  String? get words;
  @override
  @JsonKey(name: 'audio_path')
  String? get audioPath;
  @override
  @JsonKey(name: 'vocabularies')
  List<PatternVocabulary>? get vocabularies;
  @override
  String? get userAnswer;

  /// Create a copy of Translation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TranslationImplCopyWith<_$TranslationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
