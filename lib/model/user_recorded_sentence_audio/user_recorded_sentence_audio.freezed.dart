// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_recorded_sentence_audio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserRecordedSentenceAudio _$UserRecordedSentenceAudioFromJson(
    Map<String, dynamic> json) {
  return _UserRecordedSentenceAudio.fromJson(json);
}

/// @nodoc
mixin _$UserRecordedSentenceAudio {
  int? get id => throw _privateConstructorUsedError;
  String get sentenceId => throw _privateConstructorUsedError;
  String get youtubeId => throw _privateConstructorUsedError;
  String get audioPath => throw _privateConstructorUsedError;
  String get audioName => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this UserRecordedSentenceAudio to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserRecordedSentenceAudio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserRecordedSentenceAudioCopyWith<UserRecordedSentenceAudio> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRecordedSentenceAudioCopyWith<$Res> {
  factory $UserRecordedSentenceAudioCopyWith(UserRecordedSentenceAudio value,
          $Res Function(UserRecordedSentenceAudio) then) =
      _$UserRecordedSentenceAudioCopyWithImpl<$Res, UserRecordedSentenceAudio>;
  @useResult
  $Res call(
      {int? id,
      String sentenceId,
      String youtubeId,
      String audioPath,
      String audioName,
      @JsonKey(name: "created_at") DateTime? createdAt});
}

/// @nodoc
class _$UserRecordedSentenceAudioCopyWithImpl<$Res,
        $Val extends UserRecordedSentenceAudio>
    implements $UserRecordedSentenceAudioCopyWith<$Res> {
  _$UserRecordedSentenceAudioCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserRecordedSentenceAudio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sentenceId = null,
    Object? youtubeId = null,
    Object? audioPath = null,
    Object? audioName = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sentenceId: null == sentenceId
          ? _value.sentenceId
          : sentenceId // ignore: cast_nullable_to_non_nullable
              as String,
      youtubeId: null == youtubeId
          ? _value.youtubeId
          : youtubeId // ignore: cast_nullable_to_non_nullable
              as String,
      audioPath: null == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String,
      audioName: null == audioName
          ? _value.audioName
          : audioName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserRecordedSentenceAudioImplCopyWith<$Res>
    implements $UserRecordedSentenceAudioCopyWith<$Res> {
  factory _$$UserRecordedSentenceAudioImplCopyWith(
          _$UserRecordedSentenceAudioImpl value,
          $Res Function(_$UserRecordedSentenceAudioImpl) then) =
      __$$UserRecordedSentenceAudioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String sentenceId,
      String youtubeId,
      String audioPath,
      String audioName,
      @JsonKey(name: "created_at") DateTime? createdAt});
}

/// @nodoc
class __$$UserRecordedSentenceAudioImplCopyWithImpl<$Res>
    extends _$UserRecordedSentenceAudioCopyWithImpl<$Res,
        _$UserRecordedSentenceAudioImpl>
    implements _$$UserRecordedSentenceAudioImplCopyWith<$Res> {
  __$$UserRecordedSentenceAudioImplCopyWithImpl(
      _$UserRecordedSentenceAudioImpl _value,
      $Res Function(_$UserRecordedSentenceAudioImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRecordedSentenceAudio
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? sentenceId = null,
    Object? youtubeId = null,
    Object? audioPath = null,
    Object? audioName = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$UserRecordedSentenceAudioImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      sentenceId: null == sentenceId
          ? _value.sentenceId
          : sentenceId // ignore: cast_nullable_to_non_nullable
              as String,
      youtubeId: null == youtubeId
          ? _value.youtubeId
          : youtubeId // ignore: cast_nullable_to_non_nullable
              as String,
      audioPath: null == audioPath
          ? _value.audioPath
          : audioPath // ignore: cast_nullable_to_non_nullable
              as String,
      audioName: null == audioName
          ? _value.audioName
          : audioName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserRecordedSentenceAudioImpl implements _UserRecordedSentenceAudio {
  const _$UserRecordedSentenceAudioImpl(
      {this.id,
      required this.sentenceId,
      required this.youtubeId,
      required this.audioPath,
      required this.audioName,
      @JsonKey(name: "created_at") this.createdAt});

  factory _$UserRecordedSentenceAudioImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserRecordedSentenceAudioImplFromJson(json);

  @override
  final int? id;
  @override
  final String sentenceId;
  @override
  final String youtubeId;
  @override
  final String audioPath;
  @override
  final String audioName;
  @override
  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @override
  String toString() {
    return 'UserRecordedSentenceAudio(id: $id, sentenceId: $sentenceId, youtubeId: $youtubeId, audioPath: $audioPath, audioName: $audioName, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRecordedSentenceAudioImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sentenceId, sentenceId) ||
                other.sentenceId == sentenceId) &&
            (identical(other.youtubeId, youtubeId) ||
                other.youtubeId == youtubeId) &&
            (identical(other.audioPath, audioPath) ||
                other.audioPath == audioPath) &&
            (identical(other.audioName, audioName) ||
                other.audioName == audioName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, sentenceId, youtubeId, audioPath, audioName, createdAt);

  /// Create a copy of UserRecordedSentenceAudio
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRecordedSentenceAudioImplCopyWith<_$UserRecordedSentenceAudioImpl>
      get copyWith => __$$UserRecordedSentenceAudioImplCopyWithImpl<
          _$UserRecordedSentenceAudioImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserRecordedSentenceAudioImplToJson(
      this,
    );
  }
}

abstract class _UserRecordedSentenceAudio implements UserRecordedSentenceAudio {
  const factory _UserRecordedSentenceAudio(
          {final int? id,
          required final String sentenceId,
          required final String youtubeId,
          required final String audioPath,
          required final String audioName,
          @JsonKey(name: "created_at") final DateTime? createdAt}) =
      _$UserRecordedSentenceAudioImpl;

  factory _UserRecordedSentenceAudio.fromJson(Map<String, dynamic> json) =
      _$UserRecordedSentenceAudioImpl.fromJson;

  @override
  int? get id;
  @override
  String get sentenceId;
  @override
  String get youtubeId;
  @override
  String get audioPath;
  @override
  String get audioName;
  @override
  @JsonKey(name: "created_at")
  DateTime? get createdAt;

  /// Create a copy of UserRecordedSentenceAudio
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRecordedSentenceAudioImplCopyWith<_$UserRecordedSentenceAudioImpl>
      get copyWith => throw _privateConstructorUsedError;
}
