// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spoken_pattern.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SpokenPattern _$SpokenPatternFromJson(Map<String, dynamic> json) {
  return _SpokenPattern.fromJson(json);
}

/// @nodoc
mixin _$SpokenPattern {
  int? get id => throw _privateConstructorUsedError;
  String get pattern => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: "")
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'audio_path')
  String? get audioPath => throw _privateConstructorUsedError;
  @JsonKey(name: 'lesson_id')
  int? get lessonId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'pattern_examples')
  List<PatternExample>? get patternExamples =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'pattern_user_comments', fromJson: _hasCommentByUser)
  bool? get hasComment => throw _privateConstructorUsedError;
  @JsonKey(name: "subject_verb_agreements")
  SubjectVerbAgreement? get subjectVerbAgreement =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'file_path')
  String? get filePath => throw _privateConstructorUsedError;

  /// Serializes this SpokenPattern to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpokenPattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpokenPatternCopyWith<SpokenPattern> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpokenPatternCopyWith<$Res> {
  factory $SpokenPatternCopyWith(
          SpokenPattern value, $Res Function(SpokenPattern) then) =
      _$SpokenPatternCopyWithImpl<$Res, SpokenPattern>;
  @useResult
  $Res call(
      {int? id,
      String pattern,
      String? title,
      @JsonKey(defaultValue: "") String description,
      @JsonKey(name: 'audio_path') String? audioPath,
      @JsonKey(name: 'lesson_id') int? lessonId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'pattern_examples') List<PatternExample>? patternExamples,
      @JsonKey(name: 'pattern_user_comments', fromJson: _hasCommentByUser)
      bool? hasComment,
      @JsonKey(name: "subject_verb_agreements")
      SubjectVerbAgreement? subjectVerbAgreement,
      @JsonKey(name: 'file_path') String? filePath});

  $SubjectVerbAgreementCopyWith<$Res>? get subjectVerbAgreement;
}

/// @nodoc
class _$SpokenPatternCopyWithImpl<$Res, $Val extends SpokenPattern>
    implements $SpokenPatternCopyWith<$Res> {
  _$SpokenPatternCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpokenPattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? pattern = null,
    Object? title = freezed,
    Object? description = null,
    Object? audioPath = freezed,
    Object? lessonId = freezed,
    Object? createdAt = freezed,
    Object? patternExamples = freezed,
    Object? hasComment = freezed,
    Object? subjectVerbAgreement = freezed,
    Object? filePath = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      pattern: null == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      audioPath: freezed == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String?,
      lessonId: freezed == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      patternExamples: freezed == patternExamples
          ? _value.patternExamples
          : patternExamples // ignore: cast_nullable_to_non_nullable
              as List<PatternExample>?,
      hasComment: freezed == hasComment
          ? _value.hasComment
          : hasComment // ignore: cast_nullable_to_non_nullable
              as bool?,
      subjectVerbAgreement: freezed == subjectVerbAgreement
          ? _value.subjectVerbAgreement
          : subjectVerbAgreement // ignore: cast_nullable_to_non_nullable
              as SubjectVerbAgreement?,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of SpokenPattern
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SubjectVerbAgreementCopyWith<$Res>? get subjectVerbAgreement {
    if (_value.subjectVerbAgreement == null) {
      return null;
    }

    return $SubjectVerbAgreementCopyWith<$Res>(_value.subjectVerbAgreement!,
        (value) {
      return _then(_value.copyWith(subjectVerbAgreement: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SpokenPatternImplCopyWith<$Res>
    implements $SpokenPatternCopyWith<$Res> {
  factory _$$SpokenPatternImplCopyWith(
          _$SpokenPatternImpl value, $Res Function(_$SpokenPatternImpl) then) =
      __$$SpokenPatternImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String pattern,
      String? title,
      @JsonKey(defaultValue: "") String description,
      @JsonKey(name: 'audio_path') String? audioPath,
      @JsonKey(name: 'lesson_id') int? lessonId,
      @JsonKey(name: 'created_at') DateTime? createdAt,
      @JsonKey(name: 'pattern_examples') List<PatternExample>? patternExamples,
      @JsonKey(name: 'pattern_user_comments', fromJson: _hasCommentByUser)
      bool? hasComment,
      @JsonKey(name: "subject_verb_agreements")
      SubjectVerbAgreement? subjectVerbAgreement,
      @JsonKey(name: 'file_path') String? filePath});

  @override
  $SubjectVerbAgreementCopyWith<$Res>? get subjectVerbAgreement;
}

/// @nodoc
class __$$SpokenPatternImplCopyWithImpl<$Res>
    extends _$SpokenPatternCopyWithImpl<$Res, _$SpokenPatternImpl>
    implements _$$SpokenPatternImplCopyWith<$Res> {
  __$$SpokenPatternImplCopyWithImpl(
      _$SpokenPatternImpl _value, $Res Function(_$SpokenPatternImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpokenPattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? pattern = null,
    Object? title = freezed,
    Object? description = null,
    Object? audioPath = freezed,
    Object? lessonId = freezed,
    Object? createdAt = freezed,
    Object? patternExamples = freezed,
    Object? hasComment = freezed,
    Object? subjectVerbAgreement = freezed,
    Object? filePath = freezed,
  }) {
    return _then(_$SpokenPatternImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      pattern: null == pattern
          ? _value.pattern
          : pattern // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      audioPath: freezed == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String?,
      lessonId: freezed == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      patternExamples: freezed == patternExamples
          ? _value._patternExamples
          : patternExamples // ignore: cast_nullable_to_non_nullable
              as List<PatternExample>?,
      hasComment: freezed == hasComment
          ? _value.hasComment
          : hasComment // ignore: cast_nullable_to_non_nullable
              as bool?,
      subjectVerbAgreement: freezed == subjectVerbAgreement
          ? _value.subjectVerbAgreement
          : subjectVerbAgreement // ignore: cast_nullable_to_non_nullable
              as SubjectVerbAgreement?,
      filePath: freezed == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpokenPatternImpl implements _SpokenPattern {
  const _$SpokenPatternImpl(
      {this.id,
      required this.pattern,
      this.title,
      @JsonKey(defaultValue: "") required this.description,
      @JsonKey(name: 'audio_path') this.audioPath,
      @JsonKey(name: 'lesson_id') this.lessonId,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'pattern_examples')
      required final List<PatternExample>? patternExamples,
      @JsonKey(name: 'pattern_user_comments', fromJson: _hasCommentByUser)
      this.hasComment,
      @JsonKey(name: "subject_verb_agreements") this.subjectVerbAgreement,
      @JsonKey(name: 'file_path') this.filePath})
      : _patternExamples = patternExamples;

  factory _$SpokenPatternImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpokenPatternImplFromJson(json);

  @override
  final int? id;
  @override
  final String pattern;
  @override
  final String? title;
  @override
  @JsonKey(defaultValue: "")
  final String description;
  @override
  @JsonKey(name: 'audio_path')
  final String? audioPath;
  @override
  @JsonKey(name: 'lesson_id')
  final int? lessonId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  final List<PatternExample>? _patternExamples;
  @override
  @JsonKey(name: 'pattern_examples')
  List<PatternExample>? get patternExamples {
    final value = _patternExamples;
    if (value == null) return null;
    if (_patternExamples is EqualUnmodifiableListView) return _patternExamples;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'pattern_user_comments', fromJson: _hasCommentByUser)
  final bool? hasComment;
  @override
  @JsonKey(name: "subject_verb_agreements")
  final SubjectVerbAgreement? subjectVerbAgreement;
  @override
  @JsonKey(name: 'file_path')
  final String? filePath;

  @override
  String toString() {
    return 'SpokenPattern(id: $id, pattern: $pattern, title: $title, description: $description, audioPath: $audioPath, lessonId: $lessonId, createdAt: $createdAt, patternExamples: $patternExamples, hasComment: $hasComment, subjectVerbAgreement: $subjectVerbAgreement, filePath: $filePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpokenPatternImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pattern, pattern) || other.pattern == pattern) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.audioPath, audioPath) ||
                other.audioPath == audioPath) &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._patternExamples, _patternExamples) &&
            (identical(other.hasComment, hasComment) ||
                other.hasComment == hasComment) &&
            (identical(other.subjectVerbAgreement, subjectVerbAgreement) ||
                other.subjectVerbAgreement == subjectVerbAgreement) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      pattern,
      title,
      description,
      audioPath,
      lessonId,
      createdAt,
      const DeepCollectionEquality().hash(_patternExamples),
      hasComment,
      subjectVerbAgreement,
      filePath);

  /// Create a copy of SpokenPattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpokenPatternImplCopyWith<_$SpokenPatternImpl> get copyWith =>
      __$$SpokenPatternImplCopyWithImpl<_$SpokenPatternImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpokenPatternImplToJson(
      this,
    );
  }
}

abstract class _SpokenPattern implements SpokenPattern {
  const factory _SpokenPattern(
          {final int? id,
          required final String pattern,
          final String? title,
          @JsonKey(defaultValue: "") required final String description,
          @JsonKey(name: 'audio_path') final String? audioPath,
          @JsonKey(name: 'lesson_id') final int? lessonId,
          @JsonKey(name: 'created_at') final DateTime? createdAt,
          @JsonKey(name: 'pattern_examples')
          required final List<PatternExample>? patternExamples,
          @JsonKey(name: 'pattern_user_comments', fromJson: _hasCommentByUser)
          final bool? hasComment,
          @JsonKey(name: "subject_verb_agreements")
          final SubjectVerbAgreement? subjectVerbAgreement,
          @JsonKey(name: 'file_path') final String? filePath}) =
      _$SpokenPatternImpl;

  factory _SpokenPattern.fromJson(Map<String, dynamic> json) =
      _$SpokenPatternImpl.fromJson;

  @override
  int? get id;
  @override
  String get pattern;
  @override
  String? get title;
  @override
  @JsonKey(defaultValue: "")
  String get description;
  @override
  @JsonKey(name: 'audio_path')
  String? get audioPath;
  @override
  @JsonKey(name: 'lesson_id')
  int? get lessonId;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'pattern_examples')
  List<PatternExample>? get patternExamples;
  @override
  @JsonKey(name: 'pattern_user_comments', fromJson: _hasCommentByUser)
  bool? get hasComment;
  @override
  @JsonKey(name: "subject_verb_agreements")
  SubjectVerbAgreement? get subjectVerbAgreement;
  @override
  @JsonKey(name: 'file_path')
  String? get filePath;

  /// Create a copy of SpokenPattern
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpokenPatternImplCopyWith<_$SpokenPatternImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
