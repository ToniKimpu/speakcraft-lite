// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listening_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ListeningQuestion _$ListeningQuestionFromJson(Map<String, dynamic> json) {
  return _ListeningQuestion.fromJson(json);
}

/// @nodoc
mixin _$ListeningQuestion {
  double get start => throw _privateConstructorUsedError;
  double get end => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  List<AnswerOption> get answers => throw _privateConstructorUsedError;
  List<ListeningPracticeAnswer>? get userAnswers =>
      throw _privateConstructorUsedError;

  /// Serializes this ListeningQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListeningQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListeningQuestionCopyWith<ListeningQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListeningQuestionCopyWith<$Res> {
  factory $ListeningQuestionCopyWith(
          ListeningQuestion value, $Res Function(ListeningQuestion) then) =
      _$ListeningQuestionCopyWithImpl<$Res, ListeningQuestion>;
  @useResult
  $Res call(
      {double start,
      double end,
      String text,
      String question,
      List<AnswerOption> answers,
      List<ListeningPracticeAnswer>? userAnswers});
}

/// @nodoc
class _$ListeningQuestionCopyWithImpl<$Res, $Val extends ListeningQuestion>
    implements $ListeningQuestionCopyWith<$Res> {
  _$ListeningQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListeningQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? text = null,
    Object? question = null,
    Object? answers = null,
    Object? userAnswers = freezed,
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
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<AnswerOption>,
      userAnswers: freezed == userAnswers
          ? _value.userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<ListeningPracticeAnswer>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListeningQuestionImplCopyWith<$Res>
    implements $ListeningQuestionCopyWith<$Res> {
  factory _$$ListeningQuestionImplCopyWith(_$ListeningQuestionImpl value,
          $Res Function(_$ListeningQuestionImpl) then) =
      __$$ListeningQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double start,
      double end,
      String text,
      String question,
      List<AnswerOption> answers,
      List<ListeningPracticeAnswer>? userAnswers});
}

/// @nodoc
class __$$ListeningQuestionImplCopyWithImpl<$Res>
    extends _$ListeningQuestionCopyWithImpl<$Res, _$ListeningQuestionImpl>
    implements _$$ListeningQuestionImplCopyWith<$Res> {
  __$$ListeningQuestionImplCopyWithImpl(_$ListeningQuestionImpl _value,
      $Res Function(_$ListeningQuestionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ListeningQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? text = null,
    Object? question = null,
    Object? answers = null,
    Object? userAnswers = freezed,
  }) {
    return _then(_$ListeningQuestionImpl(
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
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<AnswerOption>,
      userAnswers: freezed == userAnswers
          ? _value._userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<ListeningPracticeAnswer>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListeningQuestionImpl implements _ListeningQuestion {
  const _$ListeningQuestionImpl(
      {required this.start,
      required this.end,
      required this.text,
      required this.question,
      required final List<AnswerOption> answers,
      final List<ListeningPracticeAnswer>? userAnswers})
      : _answers = answers,
        _userAnswers = userAnswers;

  factory _$ListeningQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListeningQuestionImplFromJson(json);

  @override
  final double start;
  @override
  final double end;
  @override
  final String text;
  @override
  final String question;
  final List<AnswerOption> _answers;
  @override
  List<AnswerOption> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  final List<ListeningPracticeAnswer>? _userAnswers;
  @override
  List<ListeningPracticeAnswer>? get userAnswers {
    final value = _userAnswers;
    if (value == null) return null;
    if (_userAnswers is EqualUnmodifiableListView) return _userAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ListeningQuestion(start: $start, end: $end, text: $text, question: $question, answers: $answers, userAnswers: $userAnswers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListeningQuestionImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            const DeepCollectionEquality()
                .equals(other._userAnswers, _userAnswers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      start,
      end,
      text,
      question,
      const DeepCollectionEquality().hash(_answers),
      const DeepCollectionEquality().hash(_userAnswers));

  /// Create a copy of ListeningQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListeningQuestionImplCopyWith<_$ListeningQuestionImpl> get copyWith =>
      __$$ListeningQuestionImplCopyWithImpl<_$ListeningQuestionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListeningQuestionImplToJson(
      this,
    );
  }
}

abstract class _ListeningQuestion implements ListeningQuestion {
  const factory _ListeningQuestion(
          {required final double start,
          required final double end,
          required final String text,
          required final String question,
          required final List<AnswerOption> answers,
          final List<ListeningPracticeAnswer>? userAnswers}) =
      _$ListeningQuestionImpl;

  factory _ListeningQuestion.fromJson(Map<String, dynamic> json) =
      _$ListeningQuestionImpl.fromJson;

  @override
  double get start;
  @override
  double get end;
  @override
  String get text;
  @override
  String get question;
  @override
  List<AnswerOption> get answers;
  @override
  List<ListeningPracticeAnswer>? get userAnswers;

  /// Create a copy of ListeningQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListeningQuestionImplCopyWith<_$ListeningQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnswerOption _$AnswerOptionFromJson(Map<String, dynamic> json) {
  return _AnswerOption.fromJson(json);
}

/// @nodoc
mixin _$AnswerOption {
  String get answer => throw _privateConstructorUsedError;
  bool get correct => throw _privateConstructorUsedError;

  /// Serializes this AnswerOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnswerOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnswerOptionCopyWith<AnswerOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnswerOptionCopyWith<$Res> {
  factory $AnswerOptionCopyWith(
          AnswerOption value, $Res Function(AnswerOption) then) =
      _$AnswerOptionCopyWithImpl<$Res, AnswerOption>;
  @useResult
  $Res call({String answer, bool correct});
}

/// @nodoc
class _$AnswerOptionCopyWithImpl<$Res, $Val extends AnswerOption>
    implements $AnswerOptionCopyWith<$Res> {
  _$AnswerOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnswerOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answer = null,
    Object? correct = null,
  }) {
    return _then(_value.copyWith(
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      correct: null == correct
          ? _value.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnswerOptionImplCopyWith<$Res>
    implements $AnswerOptionCopyWith<$Res> {
  factory _$$AnswerOptionImplCopyWith(
          _$AnswerOptionImpl value, $Res Function(_$AnswerOptionImpl) then) =
      __$$AnswerOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String answer, bool correct});
}

/// @nodoc
class __$$AnswerOptionImplCopyWithImpl<$Res>
    extends _$AnswerOptionCopyWithImpl<$Res, _$AnswerOptionImpl>
    implements _$$AnswerOptionImplCopyWith<$Res> {
  __$$AnswerOptionImplCopyWithImpl(
      _$AnswerOptionImpl _value, $Res Function(_$AnswerOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnswerOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? answer = null,
    Object? correct = null,
  }) {
    return _then(_$AnswerOptionImpl(
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      correct: null == correct
          ? _value.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnswerOptionImpl implements _AnswerOption {
  const _$AnswerOptionImpl({required this.answer, required this.correct});

  factory _$AnswerOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnswerOptionImplFromJson(json);

  @override
  final String answer;
  @override
  final bool correct;

  @override
  String toString() {
    return 'AnswerOption(answer: $answer, correct: $correct)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnswerOptionImpl &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.correct, correct) || other.correct == correct));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, answer, correct);

  /// Create a copy of AnswerOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnswerOptionImplCopyWith<_$AnswerOptionImpl> get copyWith =>
      __$$AnswerOptionImplCopyWithImpl<_$AnswerOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnswerOptionImplToJson(
      this,
    );
  }
}

abstract class _AnswerOption implements AnswerOption {
  const factory _AnswerOption(
      {required final String answer,
      required final bool correct}) = _$AnswerOptionImpl;

  factory _AnswerOption.fromJson(Map<String, dynamic> json) =
      _$AnswerOptionImpl.fromJson;

  @override
  String get answer;
  @override
  bool get correct;

  /// Create a copy of AnswerOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnswerOptionImplCopyWith<_$AnswerOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
