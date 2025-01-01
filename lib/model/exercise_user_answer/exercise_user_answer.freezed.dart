// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_user_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExerciseUserAnswer _$ExerciseUserAnswerFromJson(Map<String, dynamic> json) {
  return _ExerciseUserAnswer.fromJson(json);
}

/// @nodoc
mixin _$ExerciseUserAnswer {
  String get userAnswer => throw _privateConstructorUsedError;
  int get patternExerciseId => throw _privateConstructorUsedError;

  /// Serializes this ExerciseUserAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExerciseUserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseUserAnswerCopyWith<ExerciseUserAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseUserAnswerCopyWith<$Res> {
  factory $ExerciseUserAnswerCopyWith(
          ExerciseUserAnswer value, $Res Function(ExerciseUserAnswer) then) =
      _$ExerciseUserAnswerCopyWithImpl<$Res, ExerciseUserAnswer>;
  @useResult
  $Res call({String userAnswer, int patternExerciseId});
}

/// @nodoc
class _$ExerciseUserAnswerCopyWithImpl<$Res, $Val extends ExerciseUserAnswer>
    implements $ExerciseUserAnswerCopyWith<$Res> {
  _$ExerciseUserAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExerciseUserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userAnswer = null,
    Object? patternExerciseId = null,
  }) {
    return _then(_value.copyWith(
      userAnswer: null == userAnswer
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      patternExerciseId: null == patternExerciseId
          ? _value.patternExerciseId
          : patternExerciseId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExerciseUserAnswerImplCopyWith<$Res>
    implements $ExerciseUserAnswerCopyWith<$Res> {
  factory _$$ExerciseUserAnswerImplCopyWith(_$ExerciseUserAnswerImpl value,
          $Res Function(_$ExerciseUserAnswerImpl) then) =
      __$$ExerciseUserAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userAnswer, int patternExerciseId});
}

/// @nodoc
class __$$ExerciseUserAnswerImplCopyWithImpl<$Res>
    extends _$ExerciseUserAnswerCopyWithImpl<$Res, _$ExerciseUserAnswerImpl>
    implements _$$ExerciseUserAnswerImplCopyWith<$Res> {
  __$$ExerciseUserAnswerImplCopyWithImpl(_$ExerciseUserAnswerImpl _value,
      $Res Function(_$ExerciseUserAnswerImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExerciseUserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userAnswer = null,
    Object? patternExerciseId = null,
  }) {
    return _then(_$ExerciseUserAnswerImpl(
      userAnswer: null == userAnswer
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      patternExerciseId: null == patternExerciseId
          ? _value.patternExerciseId
          : patternExerciseId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseUserAnswerImpl implements _ExerciseUserAnswer {
  const _$ExerciseUserAnswerImpl(
      {required this.userAnswer, required this.patternExerciseId});

  factory _$ExerciseUserAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseUserAnswerImplFromJson(json);

  @override
  final String userAnswer;
  @override
  final int patternExerciseId;

  @override
  String toString() {
    return 'ExerciseUserAnswer(userAnswer: $userAnswer, patternExerciseId: $patternExerciseId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseUserAnswerImpl &&
            (identical(other.userAnswer, userAnswer) ||
                other.userAnswer == userAnswer) &&
            (identical(other.patternExerciseId, patternExerciseId) ||
                other.patternExerciseId == patternExerciseId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userAnswer, patternExerciseId);

  /// Create a copy of ExerciseUserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseUserAnswerImplCopyWith<_$ExerciseUserAnswerImpl> get copyWith =>
      __$$ExerciseUserAnswerImplCopyWithImpl<_$ExerciseUserAnswerImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseUserAnswerImplToJson(
      this,
    );
  }
}

abstract class _ExerciseUserAnswer implements ExerciseUserAnswer {
  const factory _ExerciseUserAnswer(
      {required final String userAnswer,
      required final int patternExerciseId}) = _$ExerciseUserAnswerImpl;

  factory _ExerciseUserAnswer.fromJson(Map<String, dynamic> json) =
      _$ExerciseUserAnswerImpl.fromJson;

  @override
  String get userAnswer;
  @override
  int get patternExerciseId;

  /// Create a copy of ExerciseUserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseUserAnswerImplCopyWith<_$ExerciseUserAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
