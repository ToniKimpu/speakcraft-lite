// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sentence_explanation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SentenceExplanation _$SentenceExplanationFromJson(Map<String, dynamic> json) {
  return _SentenceExplanation.fromJson(json);
}

/// @nodoc
mixin _$SentenceExplanation {
  int get id => throw _privateConstructorUsedError;
  double get start => throw _privateConstructorUsedError;
  double? get end => throw _privateConstructorUsedError;
  String get english => throw _privateConstructorUsedError;
  String get burmese => throw _privateConstructorUsedError;
  @JsonKey(name: 'explanation_url')
  String get explanationUrl => throw _privateConstructorUsedError;

  /// Serializes this SentenceExplanation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SentenceExplanation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SentenceExplanationCopyWith<SentenceExplanation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SentenceExplanationCopyWith<$Res> {
  factory $SentenceExplanationCopyWith(
          SentenceExplanation value, $Res Function(SentenceExplanation) then) =
      _$SentenceExplanationCopyWithImpl<$Res, SentenceExplanation>;
  @useResult
  $Res call(
      {int id,
      double start,
      double? end,
      String english,
      String burmese,
      @JsonKey(name: 'explanation_url') String explanationUrl});
}

/// @nodoc
class _$SentenceExplanationCopyWithImpl<$Res, $Val extends SentenceExplanation>
    implements $SentenceExplanationCopyWith<$Res> {
  _$SentenceExplanationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SentenceExplanation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = freezed,
    Object? english = null,
    Object? burmese = null,
    Object? explanationUrl = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as double,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as double?,
      english: null == english
          ? _value.english
          : english // ignore: cast_nullable_to_non_nullable
              as String,
      burmese: null == burmese
          ? _value.burmese
          : burmese // ignore: cast_nullable_to_non_nullable
              as String,
      explanationUrl: null == explanationUrl
          ? _value.explanationUrl
          : explanationUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SentenceExplanationImplCopyWith<$Res>
    implements $SentenceExplanationCopyWith<$Res> {
  factory _$$SentenceExplanationImplCopyWith(_$SentenceExplanationImpl value,
          $Res Function(_$SentenceExplanationImpl) then) =
      __$$SentenceExplanationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      double start,
      double? end,
      String english,
      String burmese,
      @JsonKey(name: 'explanation_url') String explanationUrl});
}

/// @nodoc
class __$$SentenceExplanationImplCopyWithImpl<$Res>
    extends _$SentenceExplanationCopyWithImpl<$Res, _$SentenceExplanationImpl>
    implements _$$SentenceExplanationImplCopyWith<$Res> {
  __$$SentenceExplanationImplCopyWithImpl(_$SentenceExplanationImpl _value,
      $Res Function(_$SentenceExplanationImpl) _then)
      : super(_value, _then);

  /// Create a copy of SentenceExplanation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = freezed,
    Object? english = null,
    Object? burmese = null,
    Object? explanationUrl = null,
  }) {
    return _then(_$SentenceExplanationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as double,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as double?,
      english: null == english
          ? _value.english
          : english // ignore: cast_nullable_to_non_nullable
              as String,
      burmese: null == burmese
          ? _value.burmese
          : burmese // ignore: cast_nullable_to_non_nullable
              as String,
      explanationUrl: null == explanationUrl
          ? _value.explanationUrl
          : explanationUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SentenceExplanationImpl implements _SentenceExplanation {
  const _$SentenceExplanationImpl(
      {required this.id,
      required this.start,
      this.end,
      required this.english,
      required this.burmese,
      @JsonKey(name: 'explanation_url') required this.explanationUrl});

  factory _$SentenceExplanationImpl.fromJson(Map<String, dynamic> json) =>
      _$$SentenceExplanationImplFromJson(json);

  @override
  final int id;
  @override
  final double start;
  @override
  final double? end;
  @override
  final String english;
  @override
  final String burmese;
  @override
  @JsonKey(name: 'explanation_url')
  final String explanationUrl;

  @override
  String toString() {
    return 'SentenceExplanation(id: $id, start: $start, end: $end, english: $english, burmese: $burmese, explanationUrl: $explanationUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentenceExplanationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.english, english) || other.english == english) &&
            (identical(other.burmese, burmese) || other.burmese == burmese) &&
            (identical(other.explanationUrl, explanationUrl) ||
                other.explanationUrl == explanationUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, start, end, english, burmese, explanationUrl);

  /// Create a copy of SentenceExplanation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SentenceExplanationImplCopyWith<_$SentenceExplanationImpl> get copyWith =>
      __$$SentenceExplanationImplCopyWithImpl<_$SentenceExplanationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SentenceExplanationImplToJson(
      this,
    );
  }
}

abstract class _SentenceExplanation implements SentenceExplanation {
  const factory _SentenceExplanation(
      {required final int id,
      required final double start,
      final double? end,
      required final String english,
      required final String burmese,
      @JsonKey(name: 'explanation_url')
      required final String explanationUrl}) = _$SentenceExplanationImpl;

  factory _SentenceExplanation.fromJson(Map<String, dynamic> json) =
      _$SentenceExplanationImpl.fromJson;

  @override
  int get id;
  @override
  double get start;
  @override
  double? get end;
  @override
  String get english;
  @override
  String get burmese;
  @override
  @JsonKey(name: 'explanation_url')
  String get explanationUrl;

  /// Create a copy of SentenceExplanation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SentenceExplanationImplCopyWith<_$SentenceExplanationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
