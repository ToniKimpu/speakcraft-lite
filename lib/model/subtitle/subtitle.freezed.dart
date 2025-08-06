// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtitle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Subtitle _$SubtitleFromJson(Map<String, dynamic> json) {
  return _Subtitle.fromJson(json);
}

/// @nodoc
mixin _$Subtitle {
  int? get id => throw _privateConstructorUsedError;
  String get english => throw _privateConstructorUsedError;
  String? get burmese => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get audioName => throw _privateConstructorUsedError;
  Duration get start => throw _privateConstructorUsedError;
  Duration get end => throw _privateConstructorUsedError;
  double get widgetHeight => throw _privateConstructorUsedError;
  double get scrollPosition => throw _privateConstructorUsedError;
  List<SubtitleVocabulary>? get vocabularies =>
      throw _privateConstructorUsedError;

  /// Serializes this Subtitle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubtitleCopyWith<Subtitle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubtitleCopyWith<$Res> {
  factory $SubtitleCopyWith(Subtitle value, $Res Function(Subtitle) then) =
      _$SubtitleCopyWithImpl<$Res, Subtitle>;
  @useResult
  $Res call(
      {int? id,
      String english,
      String? burmese,
      String? description,
      String audioName,
      Duration start,
      Duration end,
      double widgetHeight,
      double scrollPosition,
      List<SubtitleVocabulary>? vocabularies});
}

/// @nodoc
class _$SubtitleCopyWithImpl<$Res, $Val extends Subtitle>
    implements $SubtitleCopyWith<$Res> {
  _$SubtitleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? english = null,
    Object? burmese = freezed,
    Object? description = freezed,
    Object? audioName = null,
    Object? start = null,
    Object? end = null,
    Object? widgetHeight = null,
    Object? scrollPosition = null,
    Object? vocabularies = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      english: null == english
          ? _value.english
          : english // ignore: cast_nullable_to_non_nullable
              as String,
      burmese: freezed == burmese
          ? _value.burmese
          : burmese // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      audioName: null == audioName
          ? _value.audioName
          : audioName // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as Duration,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as Duration,
      widgetHeight: null == widgetHeight
          ? _value.widgetHeight
          : widgetHeight // ignore: cast_nullable_to_non_nullable
              as double,
      scrollPosition: null == scrollPosition
          ? _value.scrollPosition
          : scrollPosition // ignore: cast_nullable_to_non_nullable
              as double,
      vocabularies: freezed == vocabularies
          ? _value.vocabularies
          : vocabularies // ignore: cast_nullable_to_non_nullable
              as List<SubtitleVocabulary>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubtitleImplCopyWith<$Res>
    implements $SubtitleCopyWith<$Res> {
  factory _$$SubtitleImplCopyWith(
          _$SubtitleImpl value, $Res Function(_$SubtitleImpl) then) =
      __$$SubtitleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String english,
      String? burmese,
      String? description,
      String audioName,
      Duration start,
      Duration end,
      double widgetHeight,
      double scrollPosition,
      List<SubtitleVocabulary>? vocabularies});
}

/// @nodoc
class __$$SubtitleImplCopyWithImpl<$Res>
    extends _$SubtitleCopyWithImpl<$Res, _$SubtitleImpl>
    implements _$$SubtitleImplCopyWith<$Res> {
  __$$SubtitleImplCopyWithImpl(
      _$SubtitleImpl _value, $Res Function(_$SubtitleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? english = null,
    Object? burmese = freezed,
    Object? description = freezed,
    Object? audioName = null,
    Object? start = null,
    Object? end = null,
    Object? widgetHeight = null,
    Object? scrollPosition = null,
    Object? vocabularies = freezed,
  }) {
    return _then(_$SubtitleImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      english: null == english
          ? _value.english
          : english // ignore: cast_nullable_to_non_nullable
              as String,
      burmese: freezed == burmese
          ? _value.burmese
          : burmese // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      audioName: null == audioName
          ? _value.audioName
          : audioName // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as Duration,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as Duration,
      widgetHeight: null == widgetHeight
          ? _value.widgetHeight
          : widgetHeight // ignore: cast_nullable_to_non_nullable
              as double,
      scrollPosition: null == scrollPosition
          ? _value.scrollPosition
          : scrollPosition // ignore: cast_nullable_to_non_nullable
              as double,
      vocabularies: freezed == vocabularies
          ? _value._vocabularies
          : vocabularies // ignore: cast_nullable_to_non_nullable
              as List<SubtitleVocabulary>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubtitleImpl implements _Subtitle {
  const _$SubtitleImpl(
      {this.id,
      required this.english,
      this.burmese,
      this.description,
      required this.audioName,
      required this.start,
      required this.end,
      required this.widgetHeight,
      required this.scrollPosition,
      final List<SubtitleVocabulary>? vocabularies =
          const <SubtitleVocabulary>[]})
      : _vocabularies = vocabularies;

  factory _$SubtitleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubtitleImplFromJson(json);

  @override
  final int? id;
  @override
  final String english;
  @override
  final String? burmese;
  @override
  final String? description;
  @override
  final String audioName;
  @override
  final Duration start;
  @override
  final Duration end;
  @override
  final double widgetHeight;
  @override
  final double scrollPosition;
  final List<SubtitleVocabulary>? _vocabularies;
  @override
  @JsonKey()
  List<SubtitleVocabulary>? get vocabularies {
    final value = _vocabularies;
    if (value == null) return null;
    if (_vocabularies is EqualUnmodifiableListView) return _vocabularies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Subtitle(id: $id, english: $english, burmese: $burmese, description: $description, audioName: $audioName, start: $start, end: $end, widgetHeight: $widgetHeight, scrollPosition: $scrollPosition, vocabularies: $vocabularies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubtitleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.english, english) || other.english == english) &&
            (identical(other.burmese, burmese) || other.burmese == burmese) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.audioName, audioName) ||
                other.audioName == audioName) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.widgetHeight, widgetHeight) ||
                other.widgetHeight == widgetHeight) &&
            (identical(other.scrollPosition, scrollPosition) ||
                other.scrollPosition == scrollPosition) &&
            const DeepCollectionEquality()
                .equals(other._vocabularies, _vocabularies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      english,
      burmese,
      description,
      audioName,
      start,
      end,
      widgetHeight,
      scrollPosition,
      const DeepCollectionEquality().hash(_vocabularies));

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubtitleImplCopyWith<_$SubtitleImpl> get copyWith =>
      __$$SubtitleImplCopyWithImpl<_$SubtitleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubtitleImplToJson(
      this,
    );
  }
}

abstract class _Subtitle implements Subtitle {
  const factory _Subtitle(
      {final int? id,
      required final String english,
      final String? burmese,
      final String? description,
      required final String audioName,
      required final Duration start,
      required final Duration end,
      required final double widgetHeight,
      required final double scrollPosition,
      final List<SubtitleVocabulary>? vocabularies}) = _$SubtitleImpl;

  factory _Subtitle.fromJson(Map<String, dynamic> json) =
      _$SubtitleImpl.fromJson;

  @override
  int? get id;
  @override
  String get english;
  @override
  String? get burmese;
  @override
  String? get description;
  @override
  String get audioName;
  @override
  Duration get start;
  @override
  Duration get end;
  @override
  double get widgetHeight;
  @override
  double get scrollPosition;
  @override
  List<SubtitleVocabulary>? get vocabularies;

  /// Create a copy of Subtitle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubtitleImplCopyWith<_$SubtitleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubtitleVocabulary _$SubtitleVocabularyFromJson(Map<String, dynamic> json) {
  return _SubtitleVocabulary.fromJson(json);
}

/// @nodoc
mixin _$SubtitleVocabulary {
  int? get id => throw _privateConstructorUsedError;
  String get english => throw _privateConstructorUsedError;
  String get burmese => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;

  /// Serializes this SubtitleVocabulary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubtitleVocabulary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubtitleVocabularyCopyWith<SubtitleVocabulary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubtitleVocabularyCopyWith<$Res> {
  factory $SubtitleVocabularyCopyWith(
          SubtitleVocabulary value, $Res Function(SubtitleVocabulary) then) =
      _$SubtitleVocabularyCopyWithImpl<$Res, SubtitleVocabulary>;
  @useResult
  $Res call({int? id, String english, String burmese, String? explanation});
}

/// @nodoc
class _$SubtitleVocabularyCopyWithImpl<$Res, $Val extends SubtitleVocabulary>
    implements $SubtitleVocabularyCopyWith<$Res> {
  _$SubtitleVocabularyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubtitleVocabulary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? english = null,
    Object? burmese = null,
    Object? explanation = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      english: null == english
          ? _value.english
          : english // ignore: cast_nullable_to_non_nullable
              as String,
      burmese: null == burmese
          ? _value.burmese
          : burmese // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubtitleVocabularyImplCopyWith<$Res>
    implements $SubtitleVocabularyCopyWith<$Res> {
  factory _$$SubtitleVocabularyImplCopyWith(_$SubtitleVocabularyImpl value,
          $Res Function(_$SubtitleVocabularyImpl) then) =
      __$$SubtitleVocabularyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String english, String burmese, String? explanation});
}

/// @nodoc
class __$$SubtitleVocabularyImplCopyWithImpl<$Res>
    extends _$SubtitleVocabularyCopyWithImpl<$Res, _$SubtitleVocabularyImpl>
    implements _$$SubtitleVocabularyImplCopyWith<$Res> {
  __$$SubtitleVocabularyImplCopyWithImpl(_$SubtitleVocabularyImpl _value,
      $Res Function(_$SubtitleVocabularyImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubtitleVocabulary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? english = null,
    Object? burmese = null,
    Object? explanation = freezed,
  }) {
    return _then(_$SubtitleVocabularyImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      english: null == english
          ? _value.english
          : english // ignore: cast_nullable_to_non_nullable
              as String,
      burmese: null == burmese
          ? _value.burmese
          : burmese // ignore: cast_nullable_to_non_nullable
              as String,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubtitleVocabularyImpl implements _SubtitleVocabulary {
  const _$SubtitleVocabularyImpl(
      {this.id,
      required this.english,
      required this.burmese,
      this.explanation});

  factory _$SubtitleVocabularyImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubtitleVocabularyImplFromJson(json);

  @override
  final int? id;
  @override
  final String english;
  @override
  final String burmese;
  @override
  final String? explanation;

  @override
  String toString() {
    return 'SubtitleVocabulary(id: $id, english: $english, burmese: $burmese, explanation: $explanation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubtitleVocabularyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.english, english) || other.english == english) &&
            (identical(other.burmese, burmese) || other.burmese == burmese) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, english, burmese, explanation);

  /// Create a copy of SubtitleVocabulary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubtitleVocabularyImplCopyWith<_$SubtitleVocabularyImpl> get copyWith =>
      __$$SubtitleVocabularyImplCopyWithImpl<_$SubtitleVocabularyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubtitleVocabularyImplToJson(
      this,
    );
  }
}

abstract class _SubtitleVocabulary implements SubtitleVocabulary {
  const factory _SubtitleVocabulary(
      {final int? id,
      required final String english,
      required final String burmese,
      final String? explanation}) = _$SubtitleVocabularyImpl;

  factory _SubtitleVocabulary.fromJson(Map<String, dynamic> json) =
      _$SubtitleVocabularyImpl.fromJson;

  @override
  int? get id;
  @override
  String get english;
  @override
  String get burmese;
  @override
  String? get explanation;

  /// Create a copy of SubtitleVocabulary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubtitleVocabularyImplCopyWith<_$SubtitleVocabularyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
