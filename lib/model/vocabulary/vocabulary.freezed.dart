// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vocabulary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SentenceVocabulary _$SentenceVocabularyFromJson(Map<String, dynamic> json) {
  return _SentenceVocabulary.fromJson(json);
}

/// @nodoc
mixin _$SentenceVocabulary {
  @JsonKey(name: 'sentence_id')
  int get sentenceId => throw _privateConstructorUsedError;
  List<VocabularyWord> get words => throw _privateConstructorUsedError;

  /// Serializes this SentenceVocabulary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SentenceVocabulary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SentenceVocabularyCopyWith<SentenceVocabulary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SentenceVocabularyCopyWith<$Res> {
  factory $SentenceVocabularyCopyWith(
          SentenceVocabulary value, $Res Function(SentenceVocabulary) then) =
      _$SentenceVocabularyCopyWithImpl<$Res, SentenceVocabulary>;
  @useResult
  $Res call(
      {@JsonKey(name: 'sentence_id') int sentenceId,
      List<VocabularyWord> words});
}

/// @nodoc
class _$SentenceVocabularyCopyWithImpl<$Res, $Val extends SentenceVocabulary>
    implements $SentenceVocabularyCopyWith<$Res> {
  _$SentenceVocabularyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SentenceVocabulary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sentenceId = null,
    Object? words = null,
  }) {
    return _then(_value.copyWith(
      sentenceId: null == sentenceId
          ? _value.sentenceId
          : sentenceId // ignore: cast_nullable_to_non_nullable
              as int,
      words: null == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as List<VocabularyWord>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SentenceVocabularyImplCopyWith<$Res>
    implements $SentenceVocabularyCopyWith<$Res> {
  factory _$$SentenceVocabularyImplCopyWith(_$SentenceVocabularyImpl value,
          $Res Function(_$SentenceVocabularyImpl) then) =
      __$$SentenceVocabularyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'sentence_id') int sentenceId,
      List<VocabularyWord> words});
}

/// @nodoc
class __$$SentenceVocabularyImplCopyWithImpl<$Res>
    extends _$SentenceVocabularyCopyWithImpl<$Res, _$SentenceVocabularyImpl>
    implements _$$SentenceVocabularyImplCopyWith<$Res> {
  __$$SentenceVocabularyImplCopyWithImpl(_$SentenceVocabularyImpl _value,
      $Res Function(_$SentenceVocabularyImpl) _then)
      : super(_value, _then);

  /// Create a copy of SentenceVocabulary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sentenceId = null,
    Object? words = null,
  }) {
    return _then(_$SentenceVocabularyImpl(
      sentenceId: null == sentenceId
          ? _value.sentenceId
          : sentenceId // ignore: cast_nullable_to_non_nullable
              as int,
      words: null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<VocabularyWord>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SentenceVocabularyImpl implements _SentenceVocabulary {
  const _$SentenceVocabularyImpl(
      {@JsonKey(name: 'sentence_id') required this.sentenceId,
      final List<VocabularyWord> words = const <VocabularyWord>[]})
      : _words = words;

  factory _$SentenceVocabularyImpl.fromJson(Map<String, dynamic> json) =>
      _$$SentenceVocabularyImplFromJson(json);

  @override
  @JsonKey(name: 'sentence_id')
  final int sentenceId;
  final List<VocabularyWord> _words;
  @override
  @JsonKey()
  List<VocabularyWord> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  @override
  String toString() {
    return 'SentenceVocabulary(sentenceId: $sentenceId, words: $words)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentenceVocabularyImpl &&
            (identical(other.sentenceId, sentenceId) ||
                other.sentenceId == sentenceId) &&
            const DeepCollectionEquality().equals(other._words, _words));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, sentenceId, const DeepCollectionEquality().hash(_words));

  /// Create a copy of SentenceVocabulary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SentenceVocabularyImplCopyWith<_$SentenceVocabularyImpl> get copyWith =>
      __$$SentenceVocabularyImplCopyWithImpl<_$SentenceVocabularyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SentenceVocabularyImplToJson(
      this,
    );
  }
}

abstract class _SentenceVocabulary implements SentenceVocabulary {
  const factory _SentenceVocabulary(
      {@JsonKey(name: 'sentence_id') required final int sentenceId,
      final List<VocabularyWord> words}) = _$SentenceVocabularyImpl;

  factory _SentenceVocabulary.fromJson(Map<String, dynamic> json) =
      _$SentenceVocabularyImpl.fromJson;

  @override
  @JsonKey(name: 'sentence_id')
  int get sentenceId;
  @override
  List<VocabularyWord> get words;

  /// Create a copy of SentenceVocabulary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SentenceVocabularyImplCopyWith<_$SentenceVocabularyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VocabularyWord _$VocabularyWordFromJson(Map<String, dynamic> json) {
  return _VocabularyWord.fromJson(json);
}

/// @nodoc
mixin _$VocabularyWord {
  String get word => throw _privateConstructorUsedError;
  String get pos => throw _privateConstructorUsedError;
  String get ipa => throw _privateConstructorUsedError;
  @JsonKey(name: 'definition_en')
  String get definitionEn => throw _privateConstructorUsedError;
  @JsonKey(name: 'definition_my')
  String get definitionMy => throw _privateConstructorUsedError;
  List<VocabularyExample> get examples => throw _privateConstructorUsedError;

  /// Serializes this VocabularyWord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VocabularyWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VocabularyWordCopyWith<VocabularyWord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VocabularyWordCopyWith<$Res> {
  factory $VocabularyWordCopyWith(
          VocabularyWord value, $Res Function(VocabularyWord) then) =
      _$VocabularyWordCopyWithImpl<$Res, VocabularyWord>;
  @useResult
  $Res call(
      {String word,
      String pos,
      String ipa,
      @JsonKey(name: 'definition_en') String definitionEn,
      @JsonKey(name: 'definition_my') String definitionMy,
      List<VocabularyExample> examples});
}

/// @nodoc
class _$VocabularyWordCopyWithImpl<$Res, $Val extends VocabularyWord>
    implements $VocabularyWordCopyWith<$Res> {
  _$VocabularyWordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VocabularyWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? pos = null,
    Object? ipa = null,
    Object? definitionEn = null,
    Object? definitionMy = null,
    Object? examples = null,
  }) {
    return _then(_value.copyWith(
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      pos: null == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as String,
      ipa: null == ipa
          ? _value.ipa
          : ipa // ignore: cast_nullable_to_non_nullable
              as String,
      definitionEn: null == definitionEn
          ? _value.definitionEn
          : definitionEn // ignore: cast_nullable_to_non_nullable
              as String,
      definitionMy: null == definitionMy
          ? _value.definitionMy
          : definitionMy // ignore: cast_nullable_to_non_nullable
              as String,
      examples: null == examples
          ? _value.examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<VocabularyExample>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VocabularyWordImplCopyWith<$Res>
    implements $VocabularyWordCopyWith<$Res> {
  factory _$$VocabularyWordImplCopyWith(_$VocabularyWordImpl value,
          $Res Function(_$VocabularyWordImpl) then) =
      __$$VocabularyWordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String word,
      String pos,
      String ipa,
      @JsonKey(name: 'definition_en') String definitionEn,
      @JsonKey(name: 'definition_my') String definitionMy,
      List<VocabularyExample> examples});
}

/// @nodoc
class __$$VocabularyWordImplCopyWithImpl<$Res>
    extends _$VocabularyWordCopyWithImpl<$Res, _$VocabularyWordImpl>
    implements _$$VocabularyWordImplCopyWith<$Res> {
  __$$VocabularyWordImplCopyWithImpl(
      _$VocabularyWordImpl _value, $Res Function(_$VocabularyWordImpl) _then)
      : super(_value, _then);

  /// Create a copy of VocabularyWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? word = null,
    Object? pos = null,
    Object? ipa = null,
    Object? definitionEn = null,
    Object? definitionMy = null,
    Object? examples = null,
  }) {
    return _then(_$VocabularyWordImpl(
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
      pos: null == pos
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as String,
      ipa: null == ipa
          ? _value.ipa
          : ipa // ignore: cast_nullable_to_non_nullable
              as String,
      definitionEn: null == definitionEn
          ? _value.definitionEn
          : definitionEn // ignore: cast_nullable_to_non_nullable
              as String,
      definitionMy: null == definitionMy
          ? _value.definitionMy
          : definitionMy // ignore: cast_nullable_to_non_nullable
              as String,
      examples: null == examples
          ? _value._examples
          : examples // ignore: cast_nullable_to_non_nullable
              as List<VocabularyExample>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VocabularyWordImpl implements _VocabularyWord {
  const _$VocabularyWordImpl(
      {required this.word,
      this.pos = '',
      this.ipa = '',
      @JsonKey(name: 'definition_en') this.definitionEn = '',
      @JsonKey(name: 'definition_my') this.definitionMy = '',
      final List<VocabularyExample> examples = const <VocabularyExample>[]})
      : _examples = examples;

  factory _$VocabularyWordImpl.fromJson(Map<String, dynamic> json) =>
      _$$VocabularyWordImplFromJson(json);

  @override
  final String word;
  @override
  @JsonKey()
  final String pos;
  @override
  @JsonKey()
  final String ipa;
  @override
  @JsonKey(name: 'definition_en')
  final String definitionEn;
  @override
  @JsonKey(name: 'definition_my')
  final String definitionMy;
  final List<VocabularyExample> _examples;
  @override
  @JsonKey()
  List<VocabularyExample> get examples {
    if (_examples is EqualUnmodifiableListView) return _examples;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_examples);
  }

  @override
  String toString() {
    return 'VocabularyWord(word: $word, pos: $pos, ipa: $ipa, definitionEn: $definitionEn, definitionMy: $definitionMy, examples: $examples)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VocabularyWordImpl &&
            (identical(other.word, word) || other.word == word) &&
            (identical(other.pos, pos) || other.pos == pos) &&
            (identical(other.ipa, ipa) || other.ipa == ipa) &&
            (identical(other.definitionEn, definitionEn) ||
                other.definitionEn == definitionEn) &&
            (identical(other.definitionMy, definitionMy) ||
                other.definitionMy == definitionMy) &&
            const DeepCollectionEquality().equals(other._examples, _examples));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, word, pos, ipa, definitionEn,
      definitionMy, const DeepCollectionEquality().hash(_examples));

  /// Create a copy of VocabularyWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VocabularyWordImplCopyWith<_$VocabularyWordImpl> get copyWith =>
      __$$VocabularyWordImplCopyWithImpl<_$VocabularyWordImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VocabularyWordImplToJson(
      this,
    );
  }
}

abstract class _VocabularyWord implements VocabularyWord {
  const factory _VocabularyWord(
      {required final String word,
      final String pos,
      final String ipa,
      @JsonKey(name: 'definition_en') final String definitionEn,
      @JsonKey(name: 'definition_my') final String definitionMy,
      final List<VocabularyExample> examples}) = _$VocabularyWordImpl;

  factory _VocabularyWord.fromJson(Map<String, dynamic> json) =
      _$VocabularyWordImpl.fromJson;

  @override
  String get word;
  @override
  String get pos;
  @override
  String get ipa;
  @override
  @JsonKey(name: 'definition_en')
  String get definitionEn;
  @override
  @JsonKey(name: 'definition_my')
  String get definitionMy;
  @override
  List<VocabularyExample> get examples;

  /// Create a copy of VocabularyWord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VocabularyWordImplCopyWith<_$VocabularyWordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VocabularyExample _$VocabularyExampleFromJson(Map<String, dynamic> json) {
  return _VocabularyExample.fromJson(json);
}

/// @nodoc
mixin _$VocabularyExample {
  String get english => throw _privateConstructorUsedError;
  String get burmese => throw _privateConstructorUsedError;

  /// Serializes this VocabularyExample to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VocabularyExample
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VocabularyExampleCopyWith<VocabularyExample> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VocabularyExampleCopyWith<$Res> {
  factory $VocabularyExampleCopyWith(
          VocabularyExample value, $Res Function(VocabularyExample) then) =
      _$VocabularyExampleCopyWithImpl<$Res, VocabularyExample>;
  @useResult
  $Res call({String english, String burmese});
}

/// @nodoc
class _$VocabularyExampleCopyWithImpl<$Res, $Val extends VocabularyExample>
    implements $VocabularyExampleCopyWith<$Res> {
  _$VocabularyExampleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VocabularyExample
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? english = null,
    Object? burmese = null,
  }) {
    return _then(_value.copyWith(
      english: null == english
          ? _value.english
          : english // ignore: cast_nullable_to_non_nullable
              as String,
      burmese: null == burmese
          ? _value.burmese
          : burmese // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VocabularyExampleImplCopyWith<$Res>
    implements $VocabularyExampleCopyWith<$Res> {
  factory _$$VocabularyExampleImplCopyWith(_$VocabularyExampleImpl value,
          $Res Function(_$VocabularyExampleImpl) then) =
      __$$VocabularyExampleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String english, String burmese});
}

/// @nodoc
class __$$VocabularyExampleImplCopyWithImpl<$Res>
    extends _$VocabularyExampleCopyWithImpl<$Res, _$VocabularyExampleImpl>
    implements _$$VocabularyExampleImplCopyWith<$Res> {
  __$$VocabularyExampleImplCopyWithImpl(_$VocabularyExampleImpl _value,
      $Res Function(_$VocabularyExampleImpl) _then)
      : super(_value, _then);

  /// Create a copy of VocabularyExample
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? english = null,
    Object? burmese = null,
  }) {
    return _then(_$VocabularyExampleImpl(
      english: null == english
          ? _value.english
          : english // ignore: cast_nullable_to_non_nullable
              as String,
      burmese: null == burmese
          ? _value.burmese
          : burmese // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VocabularyExampleImpl implements _VocabularyExample {
  const _$VocabularyExampleImpl({this.english = '', this.burmese = ''});

  factory _$VocabularyExampleImpl.fromJson(Map<String, dynamic> json) =>
      _$$VocabularyExampleImplFromJson(json);

  @override
  @JsonKey()
  final String english;
  @override
  @JsonKey()
  final String burmese;

  @override
  String toString() {
    return 'VocabularyExample(english: $english, burmese: $burmese)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VocabularyExampleImpl &&
            (identical(other.english, english) || other.english == english) &&
            (identical(other.burmese, burmese) || other.burmese == burmese));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, english, burmese);

  /// Create a copy of VocabularyExample
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VocabularyExampleImplCopyWith<_$VocabularyExampleImpl> get copyWith =>
      __$$VocabularyExampleImplCopyWithImpl<_$VocabularyExampleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VocabularyExampleImplToJson(
      this,
    );
  }
}

abstract class _VocabularyExample implements VocabularyExample {
  const factory _VocabularyExample(
      {final String english, final String burmese}) = _$VocabularyExampleImpl;

  factory _VocabularyExample.fromJson(Map<String, dynamic> json) =
      _$VocabularyExampleImpl.fromJson;

  @override
  String get english;
  @override
  String get burmese;

  /// Create a copy of VocabularyExample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VocabularyExampleImplCopyWith<_$VocabularyExampleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
