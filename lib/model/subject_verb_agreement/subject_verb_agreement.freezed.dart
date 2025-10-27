// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject_verb_agreement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubjectVerbAgreement _$SubjectVerbAgreementFromJson(Map<String, dynamic> json) {
  return _SubjectVerbAgreement.fromJson(json);
}

/// @nodoc
mixin _$SubjectVerbAgreement {
  int? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'svg_data')
  List<dynamic> get svgData => throw _privateConstructorUsedError;

  /// Serializes this SubjectVerbAgreement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubjectVerbAgreement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubjectVerbAgreementCopyWith<SubjectVerbAgreement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubjectVerbAgreementCopyWith<$Res> {
  factory $SubjectVerbAgreementCopyWith(SubjectVerbAgreement value,
          $Res Function(SubjectVerbAgreement) then) =
      _$SubjectVerbAgreementCopyWithImpl<$Res, SubjectVerbAgreement>;
  @useResult
  $Res call(
      {int? id,
      String title,
      @JsonKey(name: 'svg_data') List<dynamic> svgData});
}

/// @nodoc
class _$SubjectVerbAgreementCopyWithImpl<$Res,
        $Val extends SubjectVerbAgreement>
    implements $SubjectVerbAgreementCopyWith<$Res> {
  _$SubjectVerbAgreementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubjectVerbAgreement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? svgData = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      svgData: null == svgData
          ? _value.svgData
          : svgData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubjectVerbAgreementImplCopyWith<$Res>
    implements $SubjectVerbAgreementCopyWith<$Res> {
  factory _$$SubjectVerbAgreementImplCopyWith(_$SubjectVerbAgreementImpl value,
          $Res Function(_$SubjectVerbAgreementImpl) then) =
      __$$SubjectVerbAgreementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String title,
      @JsonKey(name: 'svg_data') List<dynamic> svgData});
}

/// @nodoc
class __$$SubjectVerbAgreementImplCopyWithImpl<$Res>
    extends _$SubjectVerbAgreementCopyWithImpl<$Res, _$SubjectVerbAgreementImpl>
    implements _$$SubjectVerbAgreementImplCopyWith<$Res> {
  __$$SubjectVerbAgreementImplCopyWithImpl(_$SubjectVerbAgreementImpl _value,
      $Res Function(_$SubjectVerbAgreementImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubjectVerbAgreement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? svgData = null,
  }) {
    return _then(_$SubjectVerbAgreementImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      svgData: null == svgData
          ? _value._svgData
          : svgData // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubjectVerbAgreementImpl implements _SubjectVerbAgreement {
  const _$SubjectVerbAgreementImpl(
      {this.id,
      required this.title,
      @JsonKey(name: 'svg_data') required final List<dynamic> svgData})
      : _svgData = svgData;

  factory _$SubjectVerbAgreementImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubjectVerbAgreementImplFromJson(json);

  @override
  final int? id;
  @override
  final String title;
  final List<dynamic> _svgData;
  @override
  @JsonKey(name: 'svg_data')
  List<dynamic> get svgData {
    if (_svgData is EqualUnmodifiableListView) return _svgData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_svgData);
  }

  @override
  String toString() {
    return 'SubjectVerbAgreement(id: $id, title: $title, svgData: $svgData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubjectVerbAgreementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._svgData, _svgData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, const DeepCollectionEquality().hash(_svgData));

  /// Create a copy of SubjectVerbAgreement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubjectVerbAgreementImplCopyWith<_$SubjectVerbAgreementImpl>
      get copyWith =>
          __$$SubjectVerbAgreementImplCopyWithImpl<_$SubjectVerbAgreementImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubjectVerbAgreementImplToJson(
      this,
    );
  }
}

abstract class _SubjectVerbAgreement implements SubjectVerbAgreement {
  const factory _SubjectVerbAgreement(
          {final int? id,
          required final String title,
          @JsonKey(name: 'svg_data') required final List<dynamic> svgData}) =
      _$SubjectVerbAgreementImpl;

  factory _SubjectVerbAgreement.fromJson(Map<String, dynamic> json) =
      _$SubjectVerbAgreementImpl.fromJson;

  @override
  int? get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'svg_data')
  List<dynamic> get svgData;

  /// Create a copy of SubjectVerbAgreement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubjectVerbAgreementImplCopyWith<_$SubjectVerbAgreementImpl>
      get copyWith => throw _privateConstructorUsedError;
}
