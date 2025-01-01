// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_user_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TranslationUserAnswer _$TranslationUserAnswerFromJson(
    Map<String, dynamic> json) {
  return _TranslationUserAnswer.fromJson(json);
}

/// @nodoc
mixin _$TranslationUserAnswer {
  int get id => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'translation_id')
  int get translationId => throw _privateConstructorUsedError;

  /// Serializes this TranslationUserAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TranslationUserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TranslationUserAnswerCopyWith<TranslationUserAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TranslationUserAnswerCopyWith<$Res> {
  factory $TranslationUserAnswerCopyWith(TranslationUserAnswer value,
          $Res Function(TranslationUserAnswer) then) =
      _$TranslationUserAnswerCopyWithImpl<$Res, TranslationUserAnswer>;
  @useResult
  $Res call(
      {int id,
      String answer,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'translation_id') int translationId});
}

/// @nodoc
class _$TranslationUserAnswerCopyWithImpl<$Res,
        $Val extends TranslationUserAnswer>
    implements $TranslationUserAnswerCopyWith<$Res> {
  _$TranslationUserAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TranslationUserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? answer = null,
    Object? userId = null,
    Object? translationId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      translationId: null == translationId
          ? _value.translationId
          : translationId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TranslationUserAnswerImplCopyWith<$Res>
    implements $TranslationUserAnswerCopyWith<$Res> {
  factory _$$TranslationUserAnswerImplCopyWith(
          _$TranslationUserAnswerImpl value,
          $Res Function(_$TranslationUserAnswerImpl) then) =
      __$$TranslationUserAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String answer,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'translation_id') int translationId});
}

/// @nodoc
class __$$TranslationUserAnswerImplCopyWithImpl<$Res>
    extends _$TranslationUserAnswerCopyWithImpl<$Res,
        _$TranslationUserAnswerImpl>
    implements _$$TranslationUserAnswerImplCopyWith<$Res> {
  __$$TranslationUserAnswerImplCopyWithImpl(_$TranslationUserAnswerImpl _value,
      $Res Function(_$TranslationUserAnswerImpl) _then)
      : super(_value, _then);

  /// Create a copy of TranslationUserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? answer = null,
    Object? userId = null,
    Object? translationId = null,
  }) {
    return _then(_$TranslationUserAnswerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      translationId: null == translationId
          ? _value.translationId
          : translationId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TranslationUserAnswerImpl implements _TranslationUserAnswer {
  const _$TranslationUserAnswerImpl(
      {required this.id,
      required this.answer,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'translation_id') required this.translationId});

  factory _$TranslationUserAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$TranslationUserAnswerImplFromJson(json);

  @override
  final int id;
  @override
  final String answer;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'translation_id')
  final int translationId;

  @override
  String toString() {
    return 'TranslationUserAnswer(id: $id, answer: $answer, userId: $userId, translationId: $translationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TranslationUserAnswerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.translationId, translationId) ||
                other.translationId == translationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, answer, userId, translationId);

  /// Create a copy of TranslationUserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TranslationUserAnswerImplCopyWith<_$TranslationUserAnswerImpl>
      get copyWith => __$$TranslationUserAnswerImplCopyWithImpl<
          _$TranslationUserAnswerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TranslationUserAnswerImplToJson(
      this,
    );
  }
}

abstract class _TranslationUserAnswer implements TranslationUserAnswer {
  const factory _TranslationUserAnswer(
          {required final int id,
          required final String answer,
          @JsonKey(name: 'user_id') required final int userId,
          @JsonKey(name: 'translation_id') required final int translationId}) =
      _$TranslationUserAnswerImpl;

  factory _TranslationUserAnswer.fromJson(Map<String, dynamic> json) =
      _$TranslationUserAnswerImpl.fromJson;

  @override
  int get id;
  @override
  String get answer;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'translation_id')
  int get translationId;

  /// Create a copy of TranslationUserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TranslationUserAnswerImplCopyWith<_$TranslationUserAnswerImpl>
      get copyWith => throw _privateConstructorUsedError;
}
