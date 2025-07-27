// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_sentence_practice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AiSentencePractice _$AiSentencePracticeFromJson(Map<String, dynamic> json) {
  return _AiSentencePractice.fromJson(json);
}

/// @nodoc
mixin _$AiSentencePractice {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'input_sentence')
  String get inputSentence => throw _privateConstructorUsedError;
  @JsonKey(name: 'corrected_sentence')
  String? get correctedSentence => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;
  @JsonKey(name: "total_tokens_used")
  int get totalTokensUsed => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AiSentencePractice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiSentencePractice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiSentencePracticeCopyWith<AiSentencePractice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiSentencePracticeCopyWith<$Res> {
  factory $AiSentencePracticeCopyWith(
          AiSentencePractice value, $Res Function(AiSentencePractice) then) =
      _$AiSentencePracticeCopyWithImpl<$Res, AiSentencePractice>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'input_sentence') String inputSentence,
      @JsonKey(name: 'corrected_sentence') String? correctedSentence,
      String? explanation,
      @JsonKey(name: "total_tokens_used") int totalTokensUsed,
      @JsonKey(name: "created_at") DateTime? createdAt});
}

/// @nodoc
class _$AiSentencePracticeCopyWithImpl<$Res, $Val extends AiSentencePractice>
    implements $AiSentencePracticeCopyWith<$Res> {
  _$AiSentencePracticeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiSentencePractice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? inputSentence = null,
    Object? correctedSentence = freezed,
    Object? explanation = freezed,
    Object? totalTokensUsed = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      inputSentence: null == inputSentence
          ? _value.inputSentence
          : inputSentence // ignore: cast_nullable_to_non_nullable
              as String,
      correctedSentence: freezed == correctedSentence
          ? _value.correctedSentence
          : correctedSentence // ignore: cast_nullable_to_non_nullable
              as String?,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      totalTokensUsed: null == totalTokensUsed
          ? _value.totalTokensUsed
          : totalTokensUsed // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AiSentencePracticeImplCopyWith<$Res>
    implements $AiSentencePracticeCopyWith<$Res> {
  factory _$$AiSentencePracticeImplCopyWith(_$AiSentencePracticeImpl value,
          $Res Function(_$AiSentencePracticeImpl) then) =
      __$$AiSentencePracticeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'input_sentence') String inputSentence,
      @JsonKey(name: 'corrected_sentence') String? correctedSentence,
      String? explanation,
      @JsonKey(name: "total_tokens_used") int totalTokensUsed,
      @JsonKey(name: "created_at") DateTime? createdAt});
}

/// @nodoc
class __$$AiSentencePracticeImplCopyWithImpl<$Res>
    extends _$AiSentencePracticeCopyWithImpl<$Res, _$AiSentencePracticeImpl>
    implements _$$AiSentencePracticeImplCopyWith<$Res> {
  __$$AiSentencePracticeImplCopyWithImpl(_$AiSentencePracticeImpl _value,
      $Res Function(_$AiSentencePracticeImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiSentencePractice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? inputSentence = null,
    Object? correctedSentence = freezed,
    Object? explanation = freezed,
    Object? totalTokensUsed = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$AiSentencePracticeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      inputSentence: null == inputSentence
          ? _value.inputSentence
          : inputSentence // ignore: cast_nullable_to_non_nullable
              as String,
      correctedSentence: freezed == correctedSentence
          ? _value.correctedSentence
          : correctedSentence // ignore: cast_nullable_to_non_nullable
              as String?,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      totalTokensUsed: null == totalTokensUsed
          ? _value.totalTokensUsed
          : totalTokensUsed // ignore: cast_nullable_to_non_nullable
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
class _$AiSentencePracticeImpl implements _AiSentencePractice {
  const _$AiSentencePracticeImpl(
      {required this.id,
      @JsonKey(name: 'input_sentence') required this.inputSentence,
      @JsonKey(name: 'corrected_sentence') this.correctedSentence,
      this.explanation,
      @JsonKey(name: "total_tokens_used") required this.totalTokensUsed,
      @JsonKey(name: "created_at") this.createdAt});

  factory _$AiSentencePracticeImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiSentencePracticeImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'input_sentence')
  final String inputSentence;
  @override
  @JsonKey(name: 'corrected_sentence')
  final String? correctedSentence;
  @override
  final String? explanation;
  @override
  @JsonKey(name: "total_tokens_used")
  final int totalTokensUsed;
  @override
  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AiSentencePractice(id: $id, inputSentence: $inputSentence, correctedSentence: $correctedSentence, explanation: $explanation, totalTokensUsed: $totalTokensUsed, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiSentencePracticeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.inputSentence, inputSentence) ||
                other.inputSentence == inputSentence) &&
            (identical(other.correctedSentence, correctedSentence) ||
                other.correctedSentence == correctedSentence) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.totalTokensUsed, totalTokensUsed) ||
                other.totalTokensUsed == totalTokensUsed) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, inputSentence,
      correctedSentence, explanation, totalTokensUsed, createdAt);

  /// Create a copy of AiSentencePractice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiSentencePracticeImplCopyWith<_$AiSentencePracticeImpl> get copyWith =>
      __$$AiSentencePracticeImplCopyWithImpl<_$AiSentencePracticeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiSentencePracticeImplToJson(
      this,
    );
  }
}

abstract class _AiSentencePractice implements AiSentencePractice {
  const factory _AiSentencePractice(
      {required final int id,
      @JsonKey(name: 'input_sentence') required final String inputSentence,
      @JsonKey(name: 'corrected_sentence') final String? correctedSentence,
      final String? explanation,
      @JsonKey(name: "total_tokens_used") required final int totalTokensUsed,
      @JsonKey(name: "created_at")
      final DateTime? createdAt}) = _$AiSentencePracticeImpl;

  factory _AiSentencePractice.fromJson(Map<String, dynamic> json) =
      _$AiSentencePracticeImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'input_sentence')
  String get inputSentence;
  @override
  @JsonKey(name: 'corrected_sentence')
  String? get correctedSentence;
  @override
  String? get explanation;
  @override
  @JsonKey(name: "total_tokens_used")
  int get totalTokensUsed;
  @override
  @JsonKey(name: "created_at")
  DateTime? get createdAt;

  /// Create a copy of AiSentencePractice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiSentencePracticeImplCopyWith<_$AiSentencePracticeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
