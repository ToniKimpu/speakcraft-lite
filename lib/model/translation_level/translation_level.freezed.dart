// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_level.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TranslationLevel _$TranslationLevelFromJson(Map<String, dynamic> json) {
  return _TranslationLevel.fromJson(json);
}

/// @nodoc
mixin _$TranslationLevel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'level_name')
  String get levelName => throw _privateConstructorUsedError;

  /// Serializes this TranslationLevel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TranslationLevel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TranslationLevelCopyWith<TranslationLevel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationLevelCopyWith<$Res> {
  factory $TranslationLevelCopyWith(
          TranslationLevel value, $Res Function(TranslationLevel) then) =
      _$TranslationLevelCopyWithImpl<$Res, TranslationLevel>;
  @useResult
  $Res call({int id, @JsonKey(name: 'level_name') String levelName});
}

/// @nodoc
class _$TranslationLevelCopyWithImpl<$Res, $Val extends TranslationLevel>
    implements $TranslationLevelCopyWith<$Res> {
  _$TranslationLevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranslationLevel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? levelName = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      levelName: null == levelName
          ? _value.levelName
          : levelName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TranslationLevelImplCopyWith<$Res>
    implements $TranslationLevelCopyWith<$Res> {
  factory _$$TranslationLevelImplCopyWith(_$TranslationLevelImpl value,
          $Res Function(_$TranslationLevelImpl) then) =
      __$$TranslationLevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, @JsonKey(name: 'level_name') String levelName});
}

/// @nodoc
class __$$TranslationLevelImplCopyWithImpl<$Res>
    extends _$TranslationLevelCopyWithImpl<$Res, _$TranslationLevelImpl>
    implements _$$TranslationLevelImplCopyWith<$Res> {
  __$$TranslationLevelImplCopyWithImpl(_$TranslationLevelImpl _value,
      $Res Function(_$TranslationLevelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationLevel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? levelName = null,
  }) {
    return _then(_$TranslationLevelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      levelName: null == levelName
          ? _value.levelName
          : levelName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TranslationLevelImpl implements _TranslationLevel {
  const _$TranslationLevelImpl(
      {required this.id, @JsonKey(name: 'level_name') required this.levelName});

  factory _$TranslationLevelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TranslationLevelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'level_name')
  final String levelName;

  @override
  String toString() {
    return 'TranslationLevel(id: $id, levelName: $levelName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationLevelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.levelName, levelName) ||
                other.levelName == levelName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, levelName);

  /// Create a copy of TranslationLevel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationLevelImplCopyWith<_$TranslationLevelImpl> get copyWith =>
      __$$TranslationLevelImplCopyWithImpl<_$TranslationLevelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TranslationLevelImplToJson(
      this,
    );
  }
}

abstract class _TranslationLevel implements TranslationLevel {
  const factory _TranslationLevel(
          {required final int id,
          @JsonKey(name: 'level_name') required final String levelName}) =
      _$TranslationLevelImpl;

  factory _TranslationLevel.fromJson(Map<String, dynamic> json) =
      _$TranslationLevelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'level_name')
  String get levelName;

  /// Create a copy of TranslationLevel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TranslationLevelImplCopyWith<_$TranslationLevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
