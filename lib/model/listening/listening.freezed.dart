// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listening.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Listening _$ListeningFromJson(Map<String, dynamic> json) {
  return _Listening.fromJson(json);
}

/// @nodoc
mixin _$Listening {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get thumbnail => throw _privateConstructorUsedError;
  int get start => throw _privateConstructorUsedError;
  int get end => throw _privateConstructorUsedError;
  @JsonKey(name: 'mm_subtitle')
  bool get hasMMSubtitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_vocabularies')
  bool get hasVocabularies => throw _privateConstructorUsedError;
  @JsonKey(name: 'youtube_id')
  String get youtubeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'subtitle_path')
  String get subtitlePath => throw _privateConstructorUsedError;
  @JsonKey(name: 'multiple_choice_path')
  String get multipleChoicePath => throw _privateConstructorUsedError;
  @JsonKey(name: 'shadowing_path')
  String get shadowingPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'record_subtitle_path')
  String get recordSubtitlePath => throw _privateConstructorUsedError;
  @JsonKey(name: 'sentence_explanation_path')
  String get sentenceExplanationPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'vocabulary_path')
  String get vocabularyPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'listening_category_id')
  int? get listeningCategoryId => throw _privateConstructorUsedError;

  /// Serializes this Listening to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Listening
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListeningCopyWith<Listening> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListeningCopyWith<$Res> {
  factory $ListeningCopyWith(Listening value, $Res Function(Listening) then) =
      _$ListeningCopyWithImpl<$Res, Listening>;
  @useResult
  $Res call(
      {int id,
      String title,
      String thumbnail,
      int start,
      int end,
      @JsonKey(name: 'mm_subtitle') bool hasMMSubtitle,
      @JsonKey(name: 'has_vocabularies') bool hasVocabularies,
      @JsonKey(name: 'youtube_id') String youtubeId,
      @JsonKey(name: 'subtitle_path') String subtitlePath,
      @JsonKey(name: 'multiple_choice_path') String multipleChoicePath,
      @JsonKey(name: 'shadowing_path') String shadowingPath,
      @JsonKey(name: 'record_subtitle_path') String recordSubtitlePath,
      @JsonKey(name: 'sentence_explanation_path')
      String sentenceExplanationPath,
      @JsonKey(name: 'vocabulary_path') String vocabularyPath,
      @JsonKey(name: 'listening_category_id') int? listeningCategoryId});
}

/// @nodoc
class _$ListeningCopyWithImpl<$Res, $Val extends Listening>
    implements $ListeningCopyWith<$Res> {
  _$ListeningCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Listening
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? thumbnail = null,
    Object? start = null,
    Object? end = null,
    Object? hasMMSubtitle = null,
    Object? hasVocabularies = null,
    Object? youtubeId = null,
    Object? subtitlePath = null,
    Object? multipleChoicePath = null,
    Object? shadowingPath = null,
    Object? recordSubtitlePath = null,
    Object? sentenceExplanationPath = null,
    Object? vocabularyPath = null,
    Object? listeningCategoryId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
      hasMMSubtitle: null == hasMMSubtitle
          ? _value.hasMMSubtitle
          : hasMMSubtitle // ignore: cast_nullable_to_non_nullable
              as bool,
      hasVocabularies: null == hasVocabularies
          ? _value.hasVocabularies
          : hasVocabularies // ignore: cast_nullable_to_non_nullable
              as bool,
      youtubeId: null == youtubeId
          ? _value.youtubeId
          : youtubeId // ignore: cast_nullable_to_non_nullable
              as String,
      subtitlePath: null == subtitlePath
          ? _value.subtitlePath
          : subtitlePath // ignore: cast_nullable_to_non_nullable
              as String,
      multipleChoicePath: null == multipleChoicePath
          ? _value.multipleChoicePath
          : multipleChoicePath // ignore: cast_nullable_to_non_nullable
              as String,
      shadowingPath: null == shadowingPath
          ? _value.shadowingPath
          : shadowingPath // ignore: cast_nullable_to_non_nullable
              as String,
      recordSubtitlePath: null == recordSubtitlePath
          ? _value.recordSubtitlePath
          : recordSubtitlePath // ignore: cast_nullable_to_non_nullable
              as String,
      sentenceExplanationPath: null == sentenceExplanationPath
          ? _value.sentenceExplanationPath
          : sentenceExplanationPath // ignore: cast_nullable_to_non_nullable
              as String,
      vocabularyPath: null == vocabularyPath
          ? _value.vocabularyPath
          : vocabularyPath // ignore: cast_nullable_to_non_nullable
              as String,
      listeningCategoryId: freezed == listeningCategoryId
          ? _value.listeningCategoryId
          : listeningCategoryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListeningImplCopyWith<$Res>
    implements $ListeningCopyWith<$Res> {
  factory _$$ListeningImplCopyWith(
          _$ListeningImpl value, $Res Function(_$ListeningImpl) then) =
      __$$ListeningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String thumbnail,
      int start,
      int end,
      @JsonKey(name: 'mm_subtitle') bool hasMMSubtitle,
      @JsonKey(name: 'has_vocabularies') bool hasVocabularies,
      @JsonKey(name: 'youtube_id') String youtubeId,
      @JsonKey(name: 'subtitle_path') String subtitlePath,
      @JsonKey(name: 'multiple_choice_path') String multipleChoicePath,
      @JsonKey(name: 'shadowing_path') String shadowingPath,
      @JsonKey(name: 'record_subtitle_path') String recordSubtitlePath,
      @JsonKey(name: 'sentence_explanation_path')
      String sentenceExplanationPath,
      @JsonKey(name: 'vocabulary_path') String vocabularyPath,
      @JsonKey(name: 'listening_category_id') int? listeningCategoryId});
}

/// @nodoc
class __$$ListeningImplCopyWithImpl<$Res>
    extends _$ListeningCopyWithImpl<$Res, _$ListeningImpl>
    implements _$$ListeningImplCopyWith<$Res> {
  __$$ListeningImplCopyWithImpl(
      _$ListeningImpl _value, $Res Function(_$ListeningImpl) _then)
      : super(_value, _then);

  /// Create a copy of Listening
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? thumbnail = null,
    Object? start = null,
    Object? end = null,
    Object? hasMMSubtitle = null,
    Object? hasVocabularies = null,
    Object? youtubeId = null,
    Object? subtitlePath = null,
    Object? multipleChoicePath = null,
    Object? shadowingPath = null,
    Object? recordSubtitlePath = null,
    Object? sentenceExplanationPath = null,
    Object? vocabularyPath = null,
    Object? listeningCategoryId = freezed,
  }) {
    return _then(_$ListeningImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
      hasMMSubtitle: null == hasMMSubtitle
          ? _value.hasMMSubtitle
          : hasMMSubtitle // ignore: cast_nullable_to_non_nullable
              as bool,
      hasVocabularies: null == hasVocabularies
          ? _value.hasVocabularies
          : hasVocabularies // ignore: cast_nullable_to_non_nullable
              as bool,
      youtubeId: null == youtubeId
          ? _value.youtubeId
          : youtubeId // ignore: cast_nullable_to_non_nullable
              as String,
      subtitlePath: null == subtitlePath
          ? _value.subtitlePath
          : subtitlePath // ignore: cast_nullable_to_non_nullable
              as String,
      multipleChoicePath: null == multipleChoicePath
          ? _value.multipleChoicePath
          : multipleChoicePath // ignore: cast_nullable_to_non_nullable
              as String,
      shadowingPath: null == shadowingPath
          ? _value.shadowingPath
          : shadowingPath // ignore: cast_nullable_to_non_nullable
              as String,
      recordSubtitlePath: null == recordSubtitlePath
          ? _value.recordSubtitlePath
          : recordSubtitlePath // ignore: cast_nullable_to_non_nullable
              as String,
      sentenceExplanationPath: null == sentenceExplanationPath
          ? _value.sentenceExplanationPath
          : sentenceExplanationPath // ignore: cast_nullable_to_non_nullable
              as String,
      vocabularyPath: null == vocabularyPath
          ? _value.vocabularyPath
          : vocabularyPath // ignore: cast_nullable_to_non_nullable
              as String,
      listeningCategoryId: freezed == listeningCategoryId
          ? _value.listeningCategoryId
          : listeningCategoryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListeningImpl implements _Listening {
  const _$ListeningImpl(
      {required this.id,
      required this.title,
      required this.thumbnail,
      required this.start,
      required this.end,
      @JsonKey(name: 'mm_subtitle') required this.hasMMSubtitle,
      @JsonKey(name: 'has_vocabularies') required this.hasVocabularies,
      @JsonKey(name: 'youtube_id') required this.youtubeId,
      @JsonKey(name: 'subtitle_path') this.subtitlePath = '',
      @JsonKey(name: 'multiple_choice_path') this.multipleChoicePath = '',
      @JsonKey(name: 'shadowing_path') this.shadowingPath = '',
      @JsonKey(name: 'record_subtitle_path') this.recordSubtitlePath = '',
      @JsonKey(name: 'sentence_explanation_path')
      this.sentenceExplanationPath = '',
      @JsonKey(name: 'vocabulary_path') this.vocabularyPath = '',
      @JsonKey(name: 'listening_category_id') this.listeningCategoryId});

  factory _$ListeningImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListeningImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String thumbnail;
  @override
  final int start;
  @override
  final int end;
  @override
  @JsonKey(name: 'mm_subtitle')
  final bool hasMMSubtitle;
  @override
  @JsonKey(name: 'has_vocabularies')
  final bool hasVocabularies;
  @override
  @JsonKey(name: 'youtube_id')
  final String youtubeId;
  @override
  @JsonKey(name: 'subtitle_path')
  final String subtitlePath;
  @override
  @JsonKey(name: 'multiple_choice_path')
  final String multipleChoicePath;
  @override
  @JsonKey(name: 'shadowing_path')
  final String shadowingPath;
  @override
  @JsonKey(name: 'record_subtitle_path')
  final String recordSubtitlePath;
  @override
  @JsonKey(name: 'sentence_explanation_path')
  final String sentenceExplanationPath;
  @override
  @JsonKey(name: 'vocabulary_path')
  final String vocabularyPath;
  @override
  @JsonKey(name: 'listening_category_id')
  final int? listeningCategoryId;

  @override
  String toString() {
    return 'Listening(id: $id, title: $title, thumbnail: $thumbnail, start: $start, end: $end, hasMMSubtitle: $hasMMSubtitle, hasVocabularies: $hasVocabularies, youtubeId: $youtubeId, subtitlePath: $subtitlePath, multipleChoicePath: $multipleChoicePath, shadowingPath: $shadowingPath, recordSubtitlePath: $recordSubtitlePath, sentenceExplanationPath: $sentenceExplanationPath, vocabularyPath: $vocabularyPath, listeningCategoryId: $listeningCategoryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListeningImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.hasMMSubtitle, hasMMSubtitle) ||
                other.hasMMSubtitle == hasMMSubtitle) &&
            (identical(other.hasVocabularies, hasVocabularies) ||
                other.hasVocabularies == hasVocabularies) &&
            (identical(other.youtubeId, youtubeId) ||
                other.youtubeId == youtubeId) &&
            (identical(other.subtitlePath, subtitlePath) ||
                other.subtitlePath == subtitlePath) &&
            (identical(other.multipleChoicePath, multipleChoicePath) ||
                other.multipleChoicePath == multipleChoicePath) &&
            (identical(other.shadowingPath, shadowingPath) ||
                other.shadowingPath == shadowingPath) &&
            (identical(other.recordSubtitlePath, recordSubtitlePath) ||
                other.recordSubtitlePath == recordSubtitlePath) &&
            (identical(
                    other.sentenceExplanationPath, sentenceExplanationPath) ||
                other.sentenceExplanationPath == sentenceExplanationPath) &&
            (identical(other.vocabularyPath, vocabularyPath) ||
                other.vocabularyPath == vocabularyPath) &&
            (identical(other.listeningCategoryId, listeningCategoryId) ||
                other.listeningCategoryId == listeningCategoryId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      thumbnail,
      start,
      end,
      hasMMSubtitle,
      hasVocabularies,
      youtubeId,
      subtitlePath,
      multipleChoicePath,
      shadowingPath,
      recordSubtitlePath,
      sentenceExplanationPath,
      vocabularyPath,
      listeningCategoryId);

  /// Create a copy of Listening
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListeningImplCopyWith<_$ListeningImpl> get copyWith =>
      __$$ListeningImplCopyWithImpl<_$ListeningImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListeningImplToJson(
      this,
    );
  }
}

abstract class _Listening implements Listening {
  const factory _Listening(
      {required final int id,
      required final String title,
      required final String thumbnail,
      required final int start,
      required final int end,
      @JsonKey(name: 'mm_subtitle') required final bool hasMMSubtitle,
      @JsonKey(name: 'has_vocabularies') required final bool hasVocabularies,
      @JsonKey(name: 'youtube_id') required final String youtubeId,
      @JsonKey(name: 'subtitle_path') final String subtitlePath,
      @JsonKey(name: 'multiple_choice_path') final String multipleChoicePath,
      @JsonKey(name: 'shadowing_path') final String shadowingPath,
      @JsonKey(name: 'record_subtitle_path') final String recordSubtitlePath,
      @JsonKey(name: 'sentence_explanation_path')
      final String sentenceExplanationPath,
      @JsonKey(name: 'vocabulary_path') final String vocabularyPath,
      @JsonKey(name: 'listening_category_id')
      final int? listeningCategoryId}) = _$ListeningImpl;

  factory _Listening.fromJson(Map<String, dynamic> json) =
      _$ListeningImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get thumbnail;
  @override
  int get start;
  @override
  int get end;
  @override
  @JsonKey(name: 'mm_subtitle')
  bool get hasMMSubtitle;
  @override
  @JsonKey(name: 'has_vocabularies')
  bool get hasVocabularies;
  @override
  @JsonKey(name: 'youtube_id')
  String get youtubeId;
  @override
  @JsonKey(name: 'subtitle_path')
  String get subtitlePath;
  @override
  @JsonKey(name: 'multiple_choice_path')
  String get multipleChoicePath;
  @override
  @JsonKey(name: 'shadowing_path')
  String get shadowingPath;
  @override
  @JsonKey(name: 'record_subtitle_path')
  String get recordSubtitlePath;
  @override
  @JsonKey(name: 'sentence_explanation_path')
  String get sentenceExplanationPath;
  @override
  @JsonKey(name: 'vocabulary_path')
  String get vocabularyPath;
  @override
  @JsonKey(name: 'listening_category_id')
  int? get listeningCategoryId;

  /// Create a copy of Listening
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListeningImplCopyWith<_$ListeningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
