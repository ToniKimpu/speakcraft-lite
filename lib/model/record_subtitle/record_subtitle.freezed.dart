// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_subtitle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecordSubtitle _$RecordSubtitleFromJson(Map<String, dynamic> json) {
  return _RecordSubtitle.fromJson(json);
}

/// @nodoc
mixin _$RecordSubtitle {
  String get id => throw _privateConstructorUsedError;
  double get start => throw _privateConstructorUsedError;
  double get end => throw _privateConstructorUsedError;
  List<RecordSubtitleItem> get data => throw _privateConstructorUsedError;

  /// Serializes this RecordSubtitle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecordSubtitle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordSubtitleCopyWith<RecordSubtitle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordSubtitleCopyWith<$Res> {
  factory $RecordSubtitleCopyWith(
          RecordSubtitle value, $Res Function(RecordSubtitle) then) =
      _$RecordSubtitleCopyWithImpl<$Res, RecordSubtitle>;
  @useResult
  $Res call(
      {String id, double start, double end, List<RecordSubtitleItem> data});
}

/// @nodoc
class _$RecordSubtitleCopyWithImpl<$Res, $Val extends RecordSubtitle>
    implements $RecordSubtitleCopyWith<$Res> {
  _$RecordSubtitleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordSubtitle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as double,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as double,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<RecordSubtitleItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecordSubtitleImplCopyWith<$Res>
    implements $RecordSubtitleCopyWith<$Res> {
  factory _$$RecordSubtitleImplCopyWith(_$RecordSubtitleImpl value,
          $Res Function(_$RecordSubtitleImpl) then) =
      __$$RecordSubtitleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, double start, double end, List<RecordSubtitleItem> data});
}

/// @nodoc
class __$$RecordSubtitleImplCopyWithImpl<$Res>
    extends _$RecordSubtitleCopyWithImpl<$Res, _$RecordSubtitleImpl>
    implements _$$RecordSubtitleImplCopyWith<$Res> {
  __$$RecordSubtitleImplCopyWithImpl(
      _$RecordSubtitleImpl _value, $Res Function(_$RecordSubtitleImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordSubtitle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = null,
    Object? data = null,
  }) {
    return _then(_$RecordSubtitleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as double,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as double,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<RecordSubtitleItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordSubtitleImpl implements _RecordSubtitle {
  const _$RecordSubtitleImpl(
      {required this.id,
      required this.start,
      required this.end,
      required final List<RecordSubtitleItem> data})
      : _data = data;

  factory _$RecordSubtitleImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordSubtitleImplFromJson(json);

  @override
  final String id;
  @override
  final double start;
  @override
  final double end;
  final List<RecordSubtitleItem> _data;
  @override
  List<RecordSubtitleItem> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'RecordSubtitle(id: $id, start: $start, end: $end, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordSubtitleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, start, end, const DeepCollectionEquality().hash(_data));

  /// Create a copy of RecordSubtitle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordSubtitleImplCopyWith<_$RecordSubtitleImpl> get copyWith =>
      __$$RecordSubtitleImplCopyWithImpl<_$RecordSubtitleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordSubtitleImplToJson(
      this,
    );
  }
}

abstract class _RecordSubtitle implements RecordSubtitle {
  const factory _RecordSubtitle(
      {required final String id,
      required final double start,
      required final double end,
      required final List<RecordSubtitleItem> data}) = _$RecordSubtitleImpl;

  factory _RecordSubtitle.fromJson(Map<String, dynamic> json) =
      _$RecordSubtitleImpl.fromJson;

  @override
  String get id;
  @override
  double get start;
  @override
  double get end;
  @override
  List<RecordSubtitleItem> get data;

  /// Create a copy of RecordSubtitle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordSubtitleImplCopyWith<_$RecordSubtitleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecordSubtitleItem _$RecordSubtitleItemFromJson(Map<String, dynamic> json) {
  return _RecordSubtitleItem.fromJson(json);
}

/// @nodoc
mixin _$RecordSubtitleItem {
  double get start => throw _privateConstructorUsedError;
  double get end => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;

  /// Serializes this RecordSubtitleItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecordSubtitleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecordSubtitleItemCopyWith<RecordSubtitleItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordSubtitleItemCopyWith<$Res> {
  factory $RecordSubtitleItemCopyWith(
          RecordSubtitleItem value, $Res Function(RecordSubtitleItem) then) =
      _$RecordSubtitleItemCopyWithImpl<$Res, RecordSubtitleItem>;
  @useResult
  $Res call({double start, double end, String text});
}

/// @nodoc
class _$RecordSubtitleItemCopyWithImpl<$Res, $Val extends RecordSubtitleItem>
    implements $RecordSubtitleItemCopyWith<$Res> {
  _$RecordSubtitleItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecordSubtitleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? text = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as double,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as double,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecordSubtitleItemImplCopyWith<$Res>
    implements $RecordSubtitleItemCopyWith<$Res> {
  factory _$$RecordSubtitleItemImplCopyWith(_$RecordSubtitleItemImpl value,
          $Res Function(_$RecordSubtitleItemImpl) then) =
      __$$RecordSubtitleItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double start, double end, String text});
}

/// @nodoc
class __$$RecordSubtitleItemImplCopyWithImpl<$Res>
    extends _$RecordSubtitleItemCopyWithImpl<$Res, _$RecordSubtitleItemImpl>
    implements _$$RecordSubtitleItemImplCopyWith<$Res> {
  __$$RecordSubtitleItemImplCopyWithImpl(_$RecordSubtitleItemImpl _value,
      $Res Function(_$RecordSubtitleItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecordSubtitleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? text = null,
  }) {
    return _then(_$RecordSubtitleItemImpl(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as double,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as double,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordSubtitleItemImpl implements _RecordSubtitleItem {
  const _$RecordSubtitleItemImpl(
      {required this.start, required this.end, required this.text});

  factory _$RecordSubtitleItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordSubtitleItemImplFromJson(json);

  @override
  final double start;
  @override
  final double end;
  @override
  final String text;

  @override
  String toString() {
    return 'RecordSubtitleItem(start: $start, end: $end, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordSubtitleItemImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, start, end, text);

  /// Create a copy of RecordSubtitleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordSubtitleItemImplCopyWith<_$RecordSubtitleItemImpl> get copyWith =>
      __$$RecordSubtitleItemImplCopyWithImpl<_$RecordSubtitleItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordSubtitleItemImplToJson(
      this,
    );
  }
}

abstract class _RecordSubtitleItem implements RecordSubtitleItem {
  const factory _RecordSubtitleItem(
      {required final double start,
      required final double end,
      required final String text}) = _$RecordSubtitleItemImpl;

  factory _RecordSubtitleItem.fromJson(Map<String, dynamic> json) =
      _$RecordSubtitleItemImpl.fromJson;

  @override
  double get start;
  @override
  double get end;
  @override
  String get text;

  /// Create a copy of RecordSubtitleItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecordSubtitleItemImplCopyWith<_$RecordSubtitleItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
