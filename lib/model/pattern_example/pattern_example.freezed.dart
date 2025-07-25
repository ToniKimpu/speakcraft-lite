// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pattern_example.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PatternExample _$PatternExampleFromJson(Map<String, dynamic> json) {
  return _PatternExample.fromJson(json);
}

/// @nodoc
mixin _$PatternExample {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'english_text')
  String get englishText => throw _privateConstructorUsedError;
  @JsonKey(name: 'burmese_text')
  String? get burmeseText => throw _privateConstructorUsedError;
  @JsonKey(name: 'pattern_id')
  int get patternId => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_at')
  int get startAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PatternExample to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatternExample
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatternExampleCopyWith<PatternExample> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatternExampleCopyWith<$Res> {
  factory $PatternExampleCopyWith(
          PatternExample value, $Res Function(PatternExample) then) =
      _$PatternExampleCopyWithImpl<$Res, PatternExample>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'english_text') String englishText,
      @JsonKey(name: 'burmese_text') String? burmeseText,
      @JsonKey(name: 'pattern_id') int patternId,
      @JsonKey(name: 'start_at') int startAt,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class _$PatternExampleCopyWithImpl<$Res, $Val extends PatternExample>
    implements $PatternExampleCopyWith<$Res> {
  _$PatternExampleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatternExample
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? englishText = null,
    Object? burmeseText = freezed,
    Object? patternId = null,
    Object? startAt = null,
    Object? createdAt = freezed,
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
      burmeseText: freezed == burmeseText
          ? _value.burmeseText
          : burmeseText // ignore: cast_nullable_to_non_nullable
              as String?,
      patternId: null == patternId
          ? _value.patternId
          : patternId // ignore: cast_nullable_to_non_nullable
              as int,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatternExampleImplCopyWith<$Res>
    implements $PatternExampleCopyWith<$Res> {
  factory _$$PatternExampleImplCopyWith(_$PatternExampleImpl value,
          $Res Function(_$PatternExampleImpl) then) =
      __$$PatternExampleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'english_text') String englishText,
      @JsonKey(name: 'burmese_text') String? burmeseText,
      @JsonKey(name: 'pattern_id') int patternId,
      @JsonKey(name: 'start_at') int startAt,
      @JsonKey(name: 'created_at') DateTime? createdAt});
}

/// @nodoc
class __$$PatternExampleImplCopyWithImpl<$Res>
    extends _$PatternExampleCopyWithImpl<$Res, _$PatternExampleImpl>
    implements _$$PatternExampleImplCopyWith<$Res> {
  __$$PatternExampleImplCopyWithImpl(
      _$PatternExampleImpl _value, $Res Function(_$PatternExampleImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternExample
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? englishText = null,
    Object? burmeseText = freezed,
    Object? patternId = null,
    Object? startAt = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$PatternExampleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      englishText: null == englishText
          ? _value.englishText
          : englishText // ignore: cast_nullable_to_non_nullable
              as String,
      burmeseText: freezed == burmeseText
          ? _value.burmeseText
          : burmeseText // ignore: cast_nullable_to_non_nullable
              as String?,
      patternId: null == patternId
          ? _value.patternId
          : patternId // ignore: cast_nullable_to_non_nullable
              as int,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatternExampleImpl implements _PatternExample {
  const _$PatternExampleImpl(
      {required this.id,
      @JsonKey(name: 'english_text') required this.englishText,
      @JsonKey(name: 'burmese_text') this.burmeseText,
      @JsonKey(name: 'pattern_id') required this.patternId,
      @JsonKey(name: 'start_at') required this.startAt,
      @JsonKey(name: 'created_at') this.createdAt});

  factory _$PatternExampleImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatternExampleImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'english_text')
  final String englishText;
  @override
  @JsonKey(name: 'burmese_text')
  final String? burmeseText;
  @override
  @JsonKey(name: 'pattern_id')
  final int patternId;
  @override
  @JsonKey(name: 'start_at')
  final int startAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'PatternExample(id: $id, englishText: $englishText, burmeseText: $burmeseText, patternId: $patternId, startAt: $startAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatternExampleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.englishText, englishText) ||
                other.englishText == englishText) &&
            (identical(other.burmeseText, burmeseText) ||
                other.burmeseText == burmeseText) &&
            (identical(other.patternId, patternId) ||
                other.patternId == patternId) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, englishText, burmeseText, patternId, startAt, createdAt);

  /// Create a copy of PatternExample
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatternExampleImplCopyWith<_$PatternExampleImpl> get copyWith =>
      __$$PatternExampleImplCopyWithImpl<_$PatternExampleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatternExampleImplToJson(
      this,
    );
  }
}

abstract class _PatternExample implements PatternExample {
  const factory _PatternExample(
          {required final int id,
          @JsonKey(name: 'english_text') required final String englishText,
          @JsonKey(name: 'burmese_text') final String? burmeseText,
          @JsonKey(name: 'pattern_id') required final int patternId,
          @JsonKey(name: 'start_at') required final int startAt,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$PatternExampleImpl;

  factory _PatternExample.fromJson(Map<String, dynamic> json) =
      _$PatternExampleImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'english_text')
  String get englishText;
  @override
  @JsonKey(name: 'burmese_text')
  String? get burmeseText;
  @override
  @JsonKey(name: 'pattern_id')
  int get patternId;
  @override
  @JsonKey(name: 'start_at')
  int get startAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of PatternExample
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatternExampleImplCopyWith<_$PatternExampleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
