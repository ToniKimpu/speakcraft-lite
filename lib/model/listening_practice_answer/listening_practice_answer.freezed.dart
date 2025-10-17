// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listening_practice_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ListeningPracticeAnswer _$ListeningPracticeAnswerFromJson(
    Map<String, dynamic> json) {
  return _ListeningPracticeAnswer.fromJson(json);
}

/// @nodoc
mixin _$ListeningPracticeAnswer {
  int? get id => throw _privateConstructorUsedError;
  String get groupId => throw _privateConstructorUsedError;
  int get questionId => throw _privateConstructorUsedError;
  String? get userAnswer => throw _privateConstructorUsedError;
  int get timeSpent => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;

  /// Serializes this ListeningPracticeAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListeningPracticeAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListeningPracticeAnswerCopyWith<ListeningPracticeAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListeningPracticeAnswerCopyWith<$Res> {
  factory $ListeningPracticeAnswerCopyWith(ListeningPracticeAnswer value,
          $Res Function(ListeningPracticeAnswer) then) =
      _$ListeningPracticeAnswerCopyWithImpl<$Res, ListeningPracticeAnswer>;
  @useResult
  $Res call(
      {int? id,
      String groupId,
      int questionId,
      String? userAnswer,
      int timeSpent,
      bool isCorrect});
}

/// @nodoc
class _$ListeningPracticeAnswerCopyWithImpl<$Res,
        $Val extends ListeningPracticeAnswer>
    implements $ListeningPracticeAnswerCopyWith<$Res> {
  _$ListeningPracticeAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListeningPracticeAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? groupId = null,
    Object? questionId = null,
    Object? userAnswer = freezed,
    Object? timeSpent = null,
    Object? isCorrect = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      userAnswer: freezed == userAnswer
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      timeSpent: null == timeSpent
          ? _value.timeSpent
          : timeSpent // ignore: cast_nullable_to_non_nullable
              as int,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListeningPracticeAnswerImplCopyWith<$Res>
    implements $ListeningPracticeAnswerCopyWith<$Res> {
  factory _$$ListeningPracticeAnswerImplCopyWith(
          _$ListeningPracticeAnswerImpl value,
          $Res Function(_$ListeningPracticeAnswerImpl) then) =
      __$$ListeningPracticeAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String groupId,
      int questionId,
      String? userAnswer,
      int timeSpent,
      bool isCorrect});
}

/// @nodoc
class __$$ListeningPracticeAnswerImplCopyWithImpl<$Res>
    extends _$ListeningPracticeAnswerCopyWithImpl<$Res,
        _$ListeningPracticeAnswerImpl>
    implements _$$ListeningPracticeAnswerImplCopyWith<$Res> {
  __$$ListeningPracticeAnswerImplCopyWithImpl(
      _$ListeningPracticeAnswerImpl _value,
      $Res Function(_$ListeningPracticeAnswerImpl) _then)
      : super(_value, _then);

  /// Create a copy of ListeningPracticeAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? groupId = null,
    Object? questionId = null,
    Object? userAnswer = freezed,
    Object? timeSpent = null,
    Object? isCorrect = null,
  }) {
    return _then(_$ListeningPracticeAnswerImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String,
      questionId: null == questionId
          ? _value.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      userAnswer: freezed == userAnswer
          ? _value.userAnswer
          : userAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      timeSpent: null == timeSpent
          ? _value.timeSpent
          : timeSpent // ignore: cast_nullable_to_non_nullable
              as int,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListeningPracticeAnswerImpl implements _ListeningPracticeAnswer {
  const _$ListeningPracticeAnswerImpl(
      {this.id,
      required this.groupId,
      required this.questionId,
      this.userAnswer,
      required this.timeSpent,
      required this.isCorrect});

  factory _$ListeningPracticeAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListeningPracticeAnswerImplFromJson(json);

  @override
  final int? id;
  @override
  final String groupId;
  @override
  final int questionId;
  @override
  final String? userAnswer;
  @override
  final int timeSpent;
  @override
  final bool isCorrect;

  @override
  String toString() {
    return 'ListeningPracticeAnswer(id: $id, groupId: $groupId, questionId: $questionId, userAnswer: $userAnswer, timeSpent: $timeSpent, isCorrect: $isCorrect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListeningPracticeAnswerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.userAnswer, userAnswer) ||
                other.userAnswer == userAnswer) &&
            (identical(other.timeSpent, timeSpent) ||
                other.timeSpent == timeSpent) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, groupId, questionId, userAnswer, timeSpent, isCorrect);

  /// Create a copy of ListeningPracticeAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListeningPracticeAnswerImplCopyWith<_$ListeningPracticeAnswerImpl>
      get copyWith => __$$ListeningPracticeAnswerImplCopyWithImpl<
          _$ListeningPracticeAnswerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListeningPracticeAnswerImplToJson(
      this,
    );
  }
}

abstract class _ListeningPracticeAnswer implements ListeningPracticeAnswer {
  const factory _ListeningPracticeAnswer(
      {final int? id,
      required final String groupId,
      required final int questionId,
      final String? userAnswer,
      required final int timeSpent,
      required final bool isCorrect}) = _$ListeningPracticeAnswerImpl;

  factory _ListeningPracticeAnswer.fromJson(Map<String, dynamic> json) =
      _$ListeningPracticeAnswerImpl.fromJson;

  @override
  int? get id;
  @override
  String get groupId;
  @override
  int get questionId;
  @override
  String? get userAnswer;
  @override
  int get timeSpent;
  @override
  bool get isCorrect;

  /// Create a copy of ListeningPracticeAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListeningPracticeAnswerImplCopyWith<_$ListeningPracticeAnswerImpl>
      get copyWith => throw _privateConstructorUsedError;
}
