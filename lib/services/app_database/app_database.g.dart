// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AiSentencePracticeTableTable extends AiSentencePracticeTable
    with TableInfo<$AiSentencePracticeTableTable, AiSentencePractice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiSentencePracticeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _inputSentenceMeta =
      const VerificationMeta('inputSentence');
  @override
  late final GeneratedColumn<String> inputSentence = GeneratedColumn<String>(
      'input_sentence', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _correctedSentenceMeta =
      const VerificationMeta('correctedSentence');
  @override
  late final GeneratedColumn<String> correctedSentence =
      GeneratedColumn<String>('corrected_sentence', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _explanationMeta =
      const VerificationMeta('explanation');
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
      'explanation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalTokensUsedMeta =
      const VerificationMeta('totalTokensUsed');
  @override
  late final GeneratedColumn<int> totalTokensUsed = GeneratedColumn<int>(
      'total_tokens_used', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        inputSentence,
        correctedSentence,
        explanation,
        totalTokensUsed,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_sentence_practice_table';
  @override
  VerificationContext validateIntegrity(Insertable<AiSentencePractice> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('input_sentence')) {
      context.handle(
          _inputSentenceMeta,
          inputSentence.isAcceptableOrUnknown(
              data['input_sentence']!, _inputSentenceMeta));
    } else if (isInserting) {
      context.missing(_inputSentenceMeta);
    }
    if (data.containsKey('corrected_sentence')) {
      context.handle(
          _correctedSentenceMeta,
          correctedSentence.isAcceptableOrUnknown(
              data['corrected_sentence']!, _correctedSentenceMeta));
    }
    if (data.containsKey('explanation')) {
      context.handle(
          _explanationMeta,
          explanation.isAcceptableOrUnknown(
              data['explanation']!, _explanationMeta));
    }
    if (data.containsKey('total_tokens_used')) {
      context.handle(
          _totalTokensUsedMeta,
          totalTokensUsed.isAcceptableOrUnknown(
              data['total_tokens_used']!, _totalTokensUsedMeta));
    } else if (isInserting) {
      context.missing(_totalTokensUsedMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiSentencePractice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiSentencePractice.new(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      inputSentence: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}input_sentence'])!,
      correctedSentence: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}corrected_sentence']),
      explanation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}explanation']),
      totalTokensUsed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_tokens_used'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AiSentencePracticeTableTable createAlias(String alias) {
    return $AiSentencePracticeTableTable(attachedDatabase, alias);
  }
}

class AiSentencePracticeTableCompanion
    extends UpdateCompanion<AiSentencePractice> {
  final Value<int> id;
  final Value<String> inputSentence;
  final Value<String?> correctedSentence;
  final Value<String?> explanation;
  final Value<int> totalTokensUsed;
  final Value<DateTime> createdAt;
  const AiSentencePracticeTableCompanion({
    this.id = const Value.absent(),
    this.inputSentence = const Value.absent(),
    this.correctedSentence = const Value.absent(),
    this.explanation = const Value.absent(),
    this.totalTokensUsed = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AiSentencePracticeTableCompanion.insert({
    this.id = const Value.absent(),
    required String inputSentence,
    this.correctedSentence = const Value.absent(),
    this.explanation = const Value.absent(),
    required int totalTokensUsed,
    this.createdAt = const Value.absent(),
  })  : inputSentence = Value(inputSentence),
        totalTokensUsed = Value(totalTokensUsed);
  static Insertable<AiSentencePractice> custom({
    Expression<int>? id,
    Expression<String>? inputSentence,
    Expression<String>? correctedSentence,
    Expression<String>? explanation,
    Expression<int>? totalTokensUsed,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (inputSentence != null) 'input_sentence': inputSentence,
      if (correctedSentence != null) 'corrected_sentence': correctedSentence,
      if (explanation != null) 'explanation': explanation,
      if (totalTokensUsed != null) 'total_tokens_used': totalTokensUsed,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AiSentencePracticeTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? inputSentence,
      Value<String?>? correctedSentence,
      Value<String?>? explanation,
      Value<int>? totalTokensUsed,
      Value<DateTime>? createdAt}) {
    return AiSentencePracticeTableCompanion(
      id: id ?? this.id,
      inputSentence: inputSentence ?? this.inputSentence,
      correctedSentence: correctedSentence ?? this.correctedSentence,
      explanation: explanation ?? this.explanation,
      totalTokensUsed: totalTokensUsed ?? this.totalTokensUsed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (inputSentence.present) {
      map['input_sentence'] = Variable<String>(inputSentence.value);
    }
    if (correctedSentence.present) {
      map['corrected_sentence'] = Variable<String>(correctedSentence.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (totalTokensUsed.present) {
      map['total_tokens_used'] = Variable<int>(totalTokensUsed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiSentencePracticeTableCompanion(')
          ..write('id: $id, ')
          ..write('inputSentence: $inputSentence, ')
          ..write('correctedSentence: $correctedSentence, ')
          ..write('explanation: $explanation, ')
          ..write('totalTokensUsed: $totalTokensUsed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $UserExampleAnswerTableTable extends UserExampleAnswerTable
    with TableInfo<$UserExampleAnswerTableTable, UserExampleAnswerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserExampleAnswerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _exampleIdMeta =
      const VerificationMeta('exampleId');
  @override
  late final GeneratedColumn<int> exampleId = GeneratedColumn<int>(
      'example_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _userAnswerMeta =
      const VerificationMeta('userAnswer');
  @override
  late final GeneratedColumn<String> userAnswer = GeneratedColumn<String>(
      'user_answer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, exampleId, userAnswer];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_example_answer_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserExampleAnswerTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('example_id')) {
      context.handle(_exampleIdMeta,
          exampleId.isAcceptableOrUnknown(data['example_id']!, _exampleIdMeta));
    } else if (isInserting) {
      context.missing(_exampleIdMeta);
    }
    if (data.containsKey('user_answer')) {
      context.handle(
          _userAnswerMeta,
          userAnswer.isAcceptableOrUnknown(
              data['user_answer']!, _userAnswerMeta));
    } else if (isInserting) {
      context.missing(_userAnswerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserExampleAnswerTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserExampleAnswerTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      exampleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}example_id'])!,
      userAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_answer'])!,
    );
  }

  @override
  $UserExampleAnswerTableTable createAlias(String alias) {
    return $UserExampleAnswerTableTable(attachedDatabase, alias);
  }
}

class UserExampleAnswerTableData extends DataClass
    implements Insertable<UserExampleAnswerTableData> {
  final int id;
  final int exampleId;
  final String userAnswer;
  const UserExampleAnswerTableData(
      {required this.id, required this.exampleId, required this.userAnswer});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['example_id'] = Variable<int>(exampleId);
    map['user_answer'] = Variable<String>(userAnswer);
    return map;
  }

  UserExampleAnswerTableCompanion toCompanion(bool nullToAbsent) {
    return UserExampleAnswerTableCompanion(
      id: Value(id),
      exampleId: Value(exampleId),
      userAnswer: Value(userAnswer),
    );
  }

  factory UserExampleAnswerTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserExampleAnswerTableData(
      id: serializer.fromJson<int>(json['id']),
      exampleId: serializer.fromJson<int>(json['exampleId']),
      userAnswer: serializer.fromJson<String>(json['userAnswer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exampleId': serializer.toJson<int>(exampleId),
      'userAnswer': serializer.toJson<String>(userAnswer),
    };
  }

  UserExampleAnswerTableData copyWith(
          {int? id, int? exampleId, String? userAnswer}) =>
      UserExampleAnswerTableData(
        id: id ?? this.id,
        exampleId: exampleId ?? this.exampleId,
        userAnswer: userAnswer ?? this.userAnswer,
      );
  UserExampleAnswerTableData copyWithCompanion(
      UserExampleAnswerTableCompanion data) {
    return UserExampleAnswerTableData(
      id: data.id.present ? data.id.value : this.id,
      exampleId: data.exampleId.present ? data.exampleId.value : this.exampleId,
      userAnswer:
          data.userAnswer.present ? data.userAnswer.value : this.userAnswer,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserExampleAnswerTableData(')
          ..write('id: $id, ')
          ..write('exampleId: $exampleId, ')
          ..write('userAnswer: $userAnswer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exampleId, userAnswer);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserExampleAnswerTableData &&
          other.id == this.id &&
          other.exampleId == this.exampleId &&
          other.userAnswer == this.userAnswer);
}

class UserExampleAnswerTableCompanion
    extends UpdateCompanion<UserExampleAnswerTableData> {
  final Value<int> id;
  final Value<int> exampleId;
  final Value<String> userAnswer;
  const UserExampleAnswerTableCompanion({
    this.id = const Value.absent(),
    this.exampleId = const Value.absent(),
    this.userAnswer = const Value.absent(),
  });
  UserExampleAnswerTableCompanion.insert({
    this.id = const Value.absent(),
    required int exampleId,
    required String userAnswer,
  })  : exampleId = Value(exampleId),
        userAnswer = Value(userAnswer);
  static Insertable<UserExampleAnswerTableData> custom({
    Expression<int>? id,
    Expression<int>? exampleId,
    Expression<String>? userAnswer,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exampleId != null) 'example_id': exampleId,
      if (userAnswer != null) 'user_answer': userAnswer,
    });
  }

  UserExampleAnswerTableCompanion copyWith(
      {Value<int>? id, Value<int>? exampleId, Value<String>? userAnswer}) {
    return UserExampleAnswerTableCompanion(
      id: id ?? this.id,
      exampleId: exampleId ?? this.exampleId,
      userAnswer: userAnswer ?? this.userAnswer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exampleId.present) {
      map['example_id'] = Variable<int>(exampleId.value);
    }
    if (userAnswer.present) {
      map['user_answer'] = Variable<String>(userAnswer.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserExampleAnswerTableCompanion(')
          ..write('id: $id, ')
          ..write('exampleId: $exampleId, ')
          ..write('userAnswer: $userAnswer')
          ..write(')'))
        .toString();
  }
}

class $ListeningPracticeAnswerTableTable extends ListeningPracticeAnswerTable
    with
        TableInfo<$ListeningPracticeAnswerTableTable, ListeningPracticeAnswer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListeningPracticeAnswerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _youtubeIdMeta =
      const VerificationMeta('youtubeId');
  @override
  late final GeneratedColumn<String> youtubeId = GeneratedColumn<String>(
      'youtube_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
      'question_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _userAnswerMeta =
      const VerificationMeta('userAnswer');
  @override
  late final GeneratedColumn<String> userAnswer = GeneratedColumn<String>(
      'user_answer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _timeSpentMeta =
      const VerificationMeta('timeSpent');
  @override
  late final GeneratedColumn<int> timeSpent = GeneratedColumn<int>(
      'time_spent', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isCorrectMeta =
      const VerificationMeta('isCorrect');
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
      'is_correct', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_correct" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, youtubeId, groupId, questionId, userAnswer, timeSpent, isCorrect];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'listening_practice_answer_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ListeningPracticeAnswer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('youtube_id')) {
      context.handle(_youtubeIdMeta,
          youtubeId.isAcceptableOrUnknown(data['youtube_id']!, _youtubeIdMeta));
    } else if (isInserting) {
      context.missing(_youtubeIdMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('user_answer')) {
      context.handle(
          _userAnswerMeta,
          userAnswer.isAcceptableOrUnknown(
              data['user_answer']!, _userAnswerMeta));
    }
    if (data.containsKey('time_spent')) {
      context.handle(_timeSpentMeta,
          timeSpent.isAcceptableOrUnknown(data['time_spent']!, _timeSpentMeta));
    } else if (isInserting) {
      context.missing(_timeSpentMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(_isCorrectMeta,
          isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta));
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ListeningPracticeAnswer map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ListeningPracticeAnswer.new(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_id'])!,
      userAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_answer']),
      timeSpent: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}time_spent'])!,
      isCorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_correct'])!,
      youtubeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}youtube_id'])!,
    );
  }

  @override
  $ListeningPracticeAnswerTableTable createAlias(String alias) {
    return $ListeningPracticeAnswerTableTable(attachedDatabase, alias);
  }
}

class ListeningPracticeAnswerTableCompanion
    extends UpdateCompanion<ListeningPracticeAnswer> {
  final Value<int> id;
  final Value<String> youtubeId;
  final Value<String> groupId;
  final Value<int> questionId;
  final Value<String?> userAnswer;
  final Value<int> timeSpent;
  final Value<bool> isCorrect;
  const ListeningPracticeAnswerTableCompanion({
    this.id = const Value.absent(),
    this.youtubeId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.userAnswer = const Value.absent(),
    this.timeSpent = const Value.absent(),
    this.isCorrect = const Value.absent(),
  });
  ListeningPracticeAnswerTableCompanion.insert({
    this.id = const Value.absent(),
    required String youtubeId,
    required String groupId,
    required int questionId,
    this.userAnswer = const Value.absent(),
    required int timeSpent,
    required bool isCorrect,
  })  : youtubeId = Value(youtubeId),
        groupId = Value(groupId),
        questionId = Value(questionId),
        timeSpent = Value(timeSpent),
        isCorrect = Value(isCorrect);
  static Insertable<ListeningPracticeAnswer> custom({
    Expression<int>? id,
    Expression<String>? youtubeId,
    Expression<String>? groupId,
    Expression<int>? questionId,
    Expression<String>? userAnswer,
    Expression<int>? timeSpent,
    Expression<bool>? isCorrect,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (youtubeId != null) 'youtube_id': youtubeId,
      if (groupId != null) 'group_id': groupId,
      if (questionId != null) 'question_id': questionId,
      if (userAnswer != null) 'user_answer': userAnswer,
      if (timeSpent != null) 'time_spent': timeSpent,
      if (isCorrect != null) 'is_correct': isCorrect,
    });
  }

  ListeningPracticeAnswerTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? youtubeId,
      Value<String>? groupId,
      Value<int>? questionId,
      Value<String?>? userAnswer,
      Value<int>? timeSpent,
      Value<bool>? isCorrect}) {
    return ListeningPracticeAnswerTableCompanion(
      id: id ?? this.id,
      youtubeId: youtubeId ?? this.youtubeId,
      groupId: groupId ?? this.groupId,
      questionId: questionId ?? this.questionId,
      userAnswer: userAnswer ?? this.userAnswer,
      timeSpent: timeSpent ?? this.timeSpent,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (youtubeId.present) {
      map['youtube_id'] = Variable<String>(youtubeId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<int>(questionId.value);
    }
    if (userAnswer.present) {
      map['user_answer'] = Variable<String>(userAnswer.value);
    }
    if (timeSpent.present) {
      map['time_spent'] = Variable<int>(timeSpent.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListeningPracticeAnswerTableCompanion(')
          ..write('id: $id, ')
          ..write('youtubeId: $youtubeId, ')
          ..write('groupId: $groupId, ')
          ..write('questionId: $questionId, ')
          ..write('userAnswer: $userAnswer, ')
          ..write('timeSpent: $timeSpent, ')
          ..write('isCorrect: $isCorrect')
          ..write(')'))
        .toString();
  }
}

class $SpokenPatternExerciseAnswerTableTable
    extends SpokenPatternExerciseAnswerTable
    with TableInfo<$SpokenPatternExerciseAnswerTableTable, ExerciseUserAnswer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpokenPatternExerciseAnswerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _patternExerciseIdMeta =
      const VerificationMeta('patternExerciseId');
  @override
  late final GeneratedColumn<int> patternExerciseId = GeneratedColumn<int>(
      'pattern_exercise_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _userAnswerMeta =
      const VerificationMeta('userAnswer');
  @override
  late final GeneratedColumn<String> userAnswer = GeneratedColumn<String>(
      'user_answer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, patternExerciseId, userAnswer];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'spoken_pattern_exercise_answer_table';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseUserAnswer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pattern_exercise_id')) {
      context.handle(
          _patternExerciseIdMeta,
          patternExerciseId.isAcceptableOrUnknown(
              data['pattern_exercise_id']!, _patternExerciseIdMeta));
    } else if (isInserting) {
      context.missing(_patternExerciseIdMeta);
    }
    if (data.containsKey('user_answer')) {
      context.handle(
          _userAnswerMeta,
          userAnswer.isAcceptableOrUnknown(
              data['user_answer']!, _userAnswerMeta));
    } else if (isInserting) {
      context.missing(_userAnswerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseUserAnswer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseUserAnswer.new(
      userAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_answer'])!,
      patternExerciseId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}pattern_exercise_id'])!,
    );
  }

  @override
  $SpokenPatternExerciseAnswerTableTable createAlias(String alias) {
    return $SpokenPatternExerciseAnswerTableTable(attachedDatabase, alias);
  }
}

class SpokenPatternExerciseAnswerTableCompanion
    extends UpdateCompanion<ExerciseUserAnswer> {
  final Value<int> id;
  final Value<int> patternExerciseId;
  final Value<String> userAnswer;
  const SpokenPatternExerciseAnswerTableCompanion({
    this.id = const Value.absent(),
    this.patternExerciseId = const Value.absent(),
    this.userAnswer = const Value.absent(),
  });
  SpokenPatternExerciseAnswerTableCompanion.insert({
    this.id = const Value.absent(),
    required int patternExerciseId,
    required String userAnswer,
  })  : patternExerciseId = Value(patternExerciseId),
        userAnswer = Value(userAnswer);
  static Insertable<ExerciseUserAnswer> custom({
    Expression<int>? id,
    Expression<int>? patternExerciseId,
    Expression<String>? userAnswer,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patternExerciseId != null) 'pattern_exercise_id': patternExerciseId,
      if (userAnswer != null) 'user_answer': userAnswer,
    });
  }

  SpokenPatternExerciseAnswerTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? patternExerciseId,
      Value<String>? userAnswer}) {
    return SpokenPatternExerciseAnswerTableCompanion(
      id: id ?? this.id,
      patternExerciseId: patternExerciseId ?? this.patternExerciseId,
      userAnswer: userAnswer ?? this.userAnswer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patternExerciseId.present) {
      map['pattern_exercise_id'] = Variable<int>(patternExerciseId.value);
    }
    if (userAnswer.present) {
      map['user_answer'] = Variable<String>(userAnswer.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpokenPatternExerciseAnswerTableCompanion(')
          ..write('id: $id, ')
          ..write('patternExerciseId: $patternExerciseId, ')
          ..write('userAnswer: $userAnswer')
          ..write(')'))
        .toString();
  }
}

class $UserRecordedSentenceAudioTableTable
    extends UserRecordedSentenceAudioTable
    with
        TableInfo<$UserRecordedSentenceAudioTableTable,
            UserRecordedSentenceAudio> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserRecordedSentenceAudioTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sentenceIdMeta =
      const VerificationMeta('sentenceId');
  @override
  late final GeneratedColumn<String> sentenceId = GeneratedColumn<String>(
      'sentence_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _youtubeIdMeta =
      const VerificationMeta('youtubeId');
  @override
  late final GeneratedColumn<String> youtubeId = GeneratedColumn<String>(
      'youtube_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _audioPathMeta =
      const VerificationMeta('audioPath');
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
      'audio_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _audioNameMeta =
      const VerificationMeta('audioName');
  @override
  late final GeneratedColumn<String> audioName = GeneratedColumn<String>(
      'audio_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sentenceId, youtubeId, audioPath, audioName, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_recorded_sentence_audio_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserRecordedSentenceAudio> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sentence_id')) {
      context.handle(
          _sentenceIdMeta,
          sentenceId.isAcceptableOrUnknown(
              data['sentence_id']!, _sentenceIdMeta));
    } else if (isInserting) {
      context.missing(_sentenceIdMeta);
    }
    if (data.containsKey('youtube_id')) {
      context.handle(_youtubeIdMeta,
          youtubeId.isAcceptableOrUnknown(data['youtube_id']!, _youtubeIdMeta));
    } else if (isInserting) {
      context.missing(_youtubeIdMeta);
    }
    if (data.containsKey('audio_path')) {
      context.handle(_audioPathMeta,
          audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta));
    } else if (isInserting) {
      context.missing(_audioPathMeta);
    }
    if (data.containsKey('audio_name')) {
      context.handle(_audioNameMeta,
          audioName.isAcceptableOrUnknown(data['audio_name']!, _audioNameMeta));
    } else if (isInserting) {
      context.missing(_audioNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserRecordedSentenceAudio map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRecordedSentenceAudio.new(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sentenceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sentence_id'])!,
      youtubeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}youtube_id'])!,
      audioPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_path'])!,
      audioName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}audio_name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UserRecordedSentenceAudioTableTable createAlias(String alias) {
    return $UserRecordedSentenceAudioTableTable(attachedDatabase, alias);
  }
}

class UserRecordedSentenceAudioTableCompanion
    extends UpdateCompanion<UserRecordedSentenceAudio> {
  final Value<int> id;
  final Value<String> sentenceId;
  final Value<String> youtubeId;
  final Value<String> audioPath;
  final Value<String> audioName;
  final Value<DateTime> createdAt;
  const UserRecordedSentenceAudioTableCompanion({
    this.id = const Value.absent(),
    this.sentenceId = const Value.absent(),
    this.youtubeId = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.audioName = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UserRecordedSentenceAudioTableCompanion.insert({
    this.id = const Value.absent(),
    required String sentenceId,
    required String youtubeId,
    required String audioPath,
    required String audioName,
    this.createdAt = const Value.absent(),
  })  : sentenceId = Value(sentenceId),
        youtubeId = Value(youtubeId),
        audioPath = Value(audioPath),
        audioName = Value(audioName);
  static Insertable<UserRecordedSentenceAudio> custom({
    Expression<int>? id,
    Expression<String>? sentenceId,
    Expression<String>? youtubeId,
    Expression<String>? audioPath,
    Expression<String>? audioName,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sentenceId != null) 'sentence_id': sentenceId,
      if (youtubeId != null) 'youtube_id': youtubeId,
      if (audioPath != null) 'audio_path': audioPath,
      if (audioName != null) 'audio_name': audioName,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UserRecordedSentenceAudioTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? sentenceId,
      Value<String>? youtubeId,
      Value<String>? audioPath,
      Value<String>? audioName,
      Value<DateTime>? createdAt}) {
    return UserRecordedSentenceAudioTableCompanion(
      id: id ?? this.id,
      sentenceId: sentenceId ?? this.sentenceId,
      youtubeId: youtubeId ?? this.youtubeId,
      audioPath: audioPath ?? this.audioPath,
      audioName: audioName ?? this.audioName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sentenceId.present) {
      map['sentence_id'] = Variable<String>(sentenceId.value);
    }
    if (youtubeId.present) {
      map['youtube_id'] = Variable<String>(youtubeId.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    if (audioName.present) {
      map['audio_name'] = Variable<String>(audioName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserRecordedSentenceAudioTableCompanion(')
          ..write('id: $id, ')
          ..write('sentenceId: $sentenceId, ')
          ..write('youtubeId: $youtubeId, ')
          ..write('audioPath: $audioPath, ')
          ..write('audioName: $audioName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SavedTermTableTable extends SavedTermTable
    with TableInfo<$SavedTermTableTable, SavedTerm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedTermTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _termMeta = const VerificationMeta('term');
  @override
  late final GeneratedColumn<String> term = GeneratedColumn<String>(
      'term', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
      'kind', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _translationMyMeta =
      const VerificationMeta('translationMy');
  @override
  late final GeneratedColumn<String> translationMy = GeneratedColumn<String>(
      'translation_my', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _definitionMyMeta =
      const VerificationMeta('definitionMy');
  @override
  late final GeneratedColumn<String> definitionMy = GeneratedColumn<String>(
      'definition_my', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _examplesJsonMeta =
      const VerificationMeta('examplesJson');
  @override
  late final GeneratedColumn<String> examplesJson = GeneratedColumn<String>(
      'examples_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _sourceTitleMeta =
      const VerificationMeta('sourceTitle');
  @override
  late final GeneratedColumn<String> sourceTitle = GeneratedColumn<String>(
      'source_title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceSentenceMeta =
      const VerificationMeta('sourceSentence');
  @override
  late final GeneratedColumn<String> sourceSentence = GeneratedColumn<String>(
      'source_sentence', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _savedAtMeta =
      const VerificationMeta('savedAt');
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
      'saved_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        term,
        kind,
        translationMy,
        definitionMy,
        examplesJson,
        sourceTitle,
        sourceSentence,
        savedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_term_table';
  @override
  VerificationContext validateIntegrity(Insertable<SavedTerm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('term')) {
      context.handle(
          _termMeta, term.isAcceptableOrUnknown(data['term']!, _termMeta));
    } else if (isInserting) {
      context.missing(_termMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
          _kindMeta, kind.isAcceptableOrUnknown(data['kind']!, _kindMeta));
    }
    if (data.containsKey('translation_my')) {
      context.handle(
          _translationMyMeta,
          translationMy.isAcceptableOrUnknown(
              data['translation_my']!, _translationMyMeta));
    }
    if (data.containsKey('definition_my')) {
      context.handle(
          _definitionMyMeta,
          definitionMy.isAcceptableOrUnknown(
              data['definition_my']!, _definitionMyMeta));
    }
    if (data.containsKey('examples_json')) {
      context.handle(
          _examplesJsonMeta,
          examplesJson.isAcceptableOrUnknown(
              data['examples_json']!, _examplesJsonMeta));
    }
    if (data.containsKey('source_title')) {
      context.handle(
          _sourceTitleMeta,
          sourceTitle.isAcceptableOrUnknown(
              data['source_title']!, _sourceTitleMeta));
    }
    if (data.containsKey('source_sentence')) {
      context.handle(
          _sourceSentenceMeta,
          sourceSentence.isAcceptableOrUnknown(
              data['source_sentence']!, _sourceSentenceMeta));
    }
    if (data.containsKey('saved_at')) {
      context.handle(_savedAtMeta,
          savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedTerm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedTerm.new(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      term: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}term'])!,
      kind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kind'])!,
      translationMy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}translation_my']),
      definitionMy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}definition_my']),
      examplesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}examples_json'])!,
      sourceTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_title']),
      sourceSentence: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_sentence']),
      savedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}saved_at'])!,
    );
  }

  @override
  $SavedTermTableTable createAlias(String alias) {
    return $SavedTermTableTable(attachedDatabase, alias);
  }
}

class SavedTermTableCompanion extends UpdateCompanion<SavedTerm> {
  final Value<int> id;
  final Value<String> term;
  final Value<String> kind;
  final Value<String?> translationMy;
  final Value<String?> definitionMy;
  final Value<String> examplesJson;
  final Value<String?> sourceTitle;
  final Value<String?> sourceSentence;
  final Value<DateTime> savedAt;
  const SavedTermTableCompanion({
    this.id = const Value.absent(),
    this.term = const Value.absent(),
    this.kind = const Value.absent(),
    this.translationMy = const Value.absent(),
    this.definitionMy = const Value.absent(),
    this.examplesJson = const Value.absent(),
    this.sourceTitle = const Value.absent(),
    this.sourceSentence = const Value.absent(),
    this.savedAt = const Value.absent(),
  });
  SavedTermTableCompanion.insert({
    this.id = const Value.absent(),
    required String term,
    this.kind = const Value.absent(),
    this.translationMy = const Value.absent(),
    this.definitionMy = const Value.absent(),
    this.examplesJson = const Value.absent(),
    this.sourceTitle = const Value.absent(),
    this.sourceSentence = const Value.absent(),
    this.savedAt = const Value.absent(),
  }) : term = Value(term);
  static Insertable<SavedTerm> custom({
    Expression<int>? id,
    Expression<String>? term,
    Expression<String>? kind,
    Expression<String>? translationMy,
    Expression<String>? definitionMy,
    Expression<String>? examplesJson,
    Expression<String>? sourceTitle,
    Expression<String>? sourceSentence,
    Expression<DateTime>? savedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (term != null) 'term': term,
      if (kind != null) 'kind': kind,
      if (translationMy != null) 'translation_my': translationMy,
      if (definitionMy != null) 'definition_my': definitionMy,
      if (examplesJson != null) 'examples_json': examplesJson,
      if (sourceTitle != null) 'source_title': sourceTitle,
      if (sourceSentence != null) 'source_sentence': sourceSentence,
      if (savedAt != null) 'saved_at': savedAt,
    });
  }

  SavedTermTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? term,
      Value<String>? kind,
      Value<String?>? translationMy,
      Value<String?>? definitionMy,
      Value<String>? examplesJson,
      Value<String?>? sourceTitle,
      Value<String?>? sourceSentence,
      Value<DateTime>? savedAt}) {
    return SavedTermTableCompanion(
      id: id ?? this.id,
      term: term ?? this.term,
      kind: kind ?? this.kind,
      translationMy: translationMy ?? this.translationMy,
      definitionMy: definitionMy ?? this.definitionMy,
      examplesJson: examplesJson ?? this.examplesJson,
      sourceTitle: sourceTitle ?? this.sourceTitle,
      sourceSentence: sourceSentence ?? this.sourceSentence,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (term.present) {
      map['term'] = Variable<String>(term.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (translationMy.present) {
      map['translation_my'] = Variable<String>(translationMy.value);
    }
    if (definitionMy.present) {
      map['definition_my'] = Variable<String>(definitionMy.value);
    }
    if (examplesJson.present) {
      map['examples_json'] = Variable<String>(examplesJson.value);
    }
    if (sourceTitle.present) {
      map['source_title'] = Variable<String>(sourceTitle.value);
    }
    if (sourceSentence.present) {
      map['source_sentence'] = Variable<String>(sourceSentence.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedTermTableCompanion(')
          ..write('id: $id, ')
          ..write('term: $term, ')
          ..write('kind: $kind, ')
          ..write('translationMy: $translationMy, ')
          ..write('definitionMy: $definitionMy, ')
          ..write('examplesJson: $examplesJson, ')
          ..write('sourceTitle: $sourceTitle, ')
          ..write('sourceSentence: $sourceSentence, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }
}

class $VideoStepProgressTableTable extends VideoStepProgressTable
    with TableInfo<$VideoStepProgressTableTable, VideoStepProgress> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoStepProgressTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _youtubeIdMeta =
      const VerificationMeta('youtubeId');
  @override
  late final GeneratedColumn<String> youtubeId = GeneratedColumn<String>(
      'youtube_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stepKeyMeta =
      const VerificationMeta('stepKey');
  @override
  late final GeneratedColumn<String> stepKey = GeneratedColumn<String>(
      'step_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<int> state = GeneratedColumn<int>(
      'state', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastOpenedAtMeta =
      const VerificationMeta('lastOpenedAt');
  @override
  late final GeneratedColumn<DateTime> lastOpenedAt = GeneratedColumn<DateTime>(
      'last_opened_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _openCountMeta =
      const VerificationMeta('openCount');
  @override
  late final GeneratedColumn<int> openCount = GeneratedColumn<int>(
      'open_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [youtubeId, stepKey, state, lastOpenedAt, openCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_step_progress_table';
  @override
  VerificationContext validateIntegrity(Insertable<VideoStepProgress> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('youtube_id')) {
      context.handle(_youtubeIdMeta,
          youtubeId.isAcceptableOrUnknown(data['youtube_id']!, _youtubeIdMeta));
    } else if (isInserting) {
      context.missing(_youtubeIdMeta);
    }
    if (data.containsKey('step_key')) {
      context.handle(_stepKeyMeta,
          stepKey.isAcceptableOrUnknown(data['step_key']!, _stepKeyMeta));
    } else if (isInserting) {
      context.missing(_stepKeyMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    }
    if (data.containsKey('last_opened_at')) {
      context.handle(
          _lastOpenedAtMeta,
          lastOpenedAt.isAcceptableOrUnknown(
              data['last_opened_at']!, _lastOpenedAtMeta));
    }
    if (data.containsKey('open_count')) {
      context.handle(_openCountMeta,
          openCount.isAcceptableOrUnknown(data['open_count']!, _openCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {youtubeId, stepKey};
  @override
  VideoStepProgress map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoStepProgress.new(
      youtubeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}youtube_id'])!,
      stepKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}step_key'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}state'])!,
      lastOpenedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_opened_at']),
      openCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}open_count'])!,
    );
  }

  @override
  $VideoStepProgressTableTable createAlias(String alias) {
    return $VideoStepProgressTableTable(attachedDatabase, alias);
  }
}

class VideoStepProgressTableCompanion
    extends UpdateCompanion<VideoStepProgress> {
  final Value<String> youtubeId;
  final Value<String> stepKey;
  final Value<int> state;
  final Value<DateTime?> lastOpenedAt;
  final Value<int> openCount;
  final Value<int> rowid;
  const VideoStepProgressTableCompanion({
    this.youtubeId = const Value.absent(),
    this.stepKey = const Value.absent(),
    this.state = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.openCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VideoStepProgressTableCompanion.insert({
    required String youtubeId,
    required String stepKey,
    this.state = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.openCount = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : youtubeId = Value(youtubeId),
        stepKey = Value(stepKey);
  static Insertable<VideoStepProgress> custom({
    Expression<String>? youtubeId,
    Expression<String>? stepKey,
    Expression<int>? state,
    Expression<DateTime>? lastOpenedAt,
    Expression<int>? openCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (youtubeId != null) 'youtube_id': youtubeId,
      if (stepKey != null) 'step_key': stepKey,
      if (state != null) 'state': state,
      if (lastOpenedAt != null) 'last_opened_at': lastOpenedAt,
      if (openCount != null) 'open_count': openCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VideoStepProgressTableCompanion copyWith(
      {Value<String>? youtubeId,
      Value<String>? stepKey,
      Value<int>? state,
      Value<DateTime?>? lastOpenedAt,
      Value<int>? openCount,
      Value<int>? rowid}) {
    return VideoStepProgressTableCompanion(
      youtubeId: youtubeId ?? this.youtubeId,
      stepKey: stepKey ?? this.stepKey,
      state: state ?? this.state,
      lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
      openCount: openCount ?? this.openCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (youtubeId.present) {
      map['youtube_id'] = Variable<String>(youtubeId.value);
    }
    if (stepKey.present) {
      map['step_key'] = Variable<String>(stepKey.value);
    }
    if (state.present) {
      map['state'] = Variable<int>(state.value);
    }
    if (lastOpenedAt.present) {
      map['last_opened_at'] = Variable<DateTime>(lastOpenedAt.value);
    }
    if (openCount.present) {
      map['open_count'] = Variable<int>(openCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoStepProgressTableCompanion(')
          ..write('youtubeId: $youtubeId, ')
          ..write('stepKey: $stepKey, ')
          ..write('state: $state, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('openCount: $openCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailySpeakingSessionTableTable extends DailySpeakingSessionTable
    with
        TableInfo<$DailySpeakingSessionTableTable,
            DailySpeakingSessionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailySpeakingSessionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _topicIdMeta =
      const VerificationMeta('topicId');
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
      'topic_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _onRampMeta = const VerificationMeta('onRamp');
  @override
  late final GeneratedColumn<String> onRamp = GeneratedColumn<String>(
      'on_ramp', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _inputModeMeta =
      const VerificationMeta('inputMode');
  @override
  late final GeneratedColumn<String> inputMode = GeneratedColumn<String>(
      'input_mode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _inputTextMeta =
      const VerificationMeta('inputText');
  @override
  late final GeneratedColumn<String> inputText = GeneratedColumn<String>(
      'input_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _feedbackJsonMeta =
      const VerificationMeta('feedbackJson');
  @override
  late final GeneratedColumn<String> feedbackJson = GeneratedColumn<String>(
      'feedback_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalTokensMeta =
      const VerificationMeta('totalTokens');
  @override
  late final GeneratedColumn<int> totalTokens = GeneratedColumn<int>(
      'total_tokens', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _topicAttemptIdMeta =
      const VerificationMeta('topicAttemptId');
  @override
  late final GeneratedColumn<String> topicAttemptId = GeneratedColumn<String>(
      'topic_attempt_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _revisionNumberMeta =
      const VerificationMeta('revisionNumber');
  @override
  late final GeneratedColumn<int> revisionNumber = GeneratedColumn<int>(
      'revision_number', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        topicId,
        onRamp,
        inputMode,
        inputText,
        feedbackJson,
        totalTokens,
        topicAttemptId,
        revisionNumber,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_speaking_session_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<DailySpeakingSessionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('topic_id')) {
      context.handle(_topicIdMeta,
          topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta));
    }
    if (data.containsKey('on_ramp')) {
      context.handle(_onRampMeta,
          onRamp.isAcceptableOrUnknown(data['on_ramp']!, _onRampMeta));
    } else if (isInserting) {
      context.missing(_onRampMeta);
    }
    if (data.containsKey('input_mode')) {
      context.handle(_inputModeMeta,
          inputMode.isAcceptableOrUnknown(data['input_mode']!, _inputModeMeta));
    } else if (isInserting) {
      context.missing(_inputModeMeta);
    }
    if (data.containsKey('input_text')) {
      context.handle(_inputTextMeta,
          inputText.isAcceptableOrUnknown(data['input_text']!, _inputTextMeta));
    }
    if (data.containsKey('feedback_json')) {
      context.handle(
          _feedbackJsonMeta,
          feedbackJson.isAcceptableOrUnknown(
              data['feedback_json']!, _feedbackJsonMeta));
    } else if (isInserting) {
      context.missing(_feedbackJsonMeta);
    }
    if (data.containsKey('total_tokens')) {
      context.handle(
          _totalTokensMeta,
          totalTokens.isAcceptableOrUnknown(
              data['total_tokens']!, _totalTokensMeta));
    } else if (isInserting) {
      context.missing(_totalTokensMeta);
    }
    if (data.containsKey('topic_attempt_id')) {
      context.handle(
          _topicAttemptIdMeta,
          topicAttemptId.isAcceptableOrUnknown(
              data['topic_attempt_id']!, _topicAttemptIdMeta));
    }
    if (data.containsKey('revision_number')) {
      context.handle(
          _revisionNumberMeta,
          revisionNumber.isAcceptableOrUnknown(
              data['revision_number']!, _revisionNumberMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailySpeakingSessionTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailySpeakingSessionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      topicId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}topic_id']),
      onRamp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}on_ramp'])!,
      inputMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}input_mode'])!,
      inputText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}input_text']),
      feedbackJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}feedback_json'])!,
      totalTokens: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_tokens'])!,
      topicAttemptId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}topic_attempt_id']),
      revisionNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}revision_number'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DailySpeakingSessionTableTable createAlias(String alias) {
    return $DailySpeakingSessionTableTable(attachedDatabase, alias);
  }
}

class DailySpeakingSessionTableData extends DataClass
    implements Insertable<DailySpeakingSessionTableData> {
  final int id;
  final String? topicId;
  final String onRamp;
  final String inputMode;
  final String? inputText;

  /// Serialized [DailySpeakingFeedback]. Kept as JSON so adding fields to the
  /// feedback shape doesn't require a Drift schema migration.
  final String feedbackJson;
  final int totalTokens;

  /// Version-loop chaining (schema v6). [topicAttemptId] groups v1, v2, … of one
  /// topic attempt; [revisionNumber] is the position in that chain (1-based).
  /// Nullable / default 1 so pre-v6 rows migrate cleanly as standalone v1s.
  final String? topicAttemptId;
  final int revisionNumber;
  final DateTime createdAt;
  const DailySpeakingSessionTableData(
      {required this.id,
      this.topicId,
      required this.onRamp,
      required this.inputMode,
      this.inputText,
      required this.feedbackJson,
      required this.totalTokens,
      this.topicAttemptId,
      required this.revisionNumber,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || topicId != null) {
      map['topic_id'] = Variable<String>(topicId);
    }
    map['on_ramp'] = Variable<String>(onRamp);
    map['input_mode'] = Variable<String>(inputMode);
    if (!nullToAbsent || inputText != null) {
      map['input_text'] = Variable<String>(inputText);
    }
    map['feedback_json'] = Variable<String>(feedbackJson);
    map['total_tokens'] = Variable<int>(totalTokens);
    if (!nullToAbsent || topicAttemptId != null) {
      map['topic_attempt_id'] = Variable<String>(topicAttemptId);
    }
    map['revision_number'] = Variable<int>(revisionNumber);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DailySpeakingSessionTableCompanion toCompanion(bool nullToAbsent) {
    return DailySpeakingSessionTableCompanion(
      id: Value(id),
      topicId: topicId == null && nullToAbsent
          ? const Value.absent()
          : Value(topicId),
      onRamp: Value(onRamp),
      inputMode: Value(inputMode),
      inputText: inputText == null && nullToAbsent
          ? const Value.absent()
          : Value(inputText),
      feedbackJson: Value(feedbackJson),
      totalTokens: Value(totalTokens),
      topicAttemptId: topicAttemptId == null && nullToAbsent
          ? const Value.absent()
          : Value(topicAttemptId),
      revisionNumber: Value(revisionNumber),
      createdAt: Value(createdAt),
    );
  }

  factory DailySpeakingSessionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailySpeakingSessionTableData(
      id: serializer.fromJson<int>(json['id']),
      topicId: serializer.fromJson<String?>(json['topicId']),
      onRamp: serializer.fromJson<String>(json['onRamp']),
      inputMode: serializer.fromJson<String>(json['inputMode']),
      inputText: serializer.fromJson<String?>(json['inputText']),
      feedbackJson: serializer.fromJson<String>(json['feedbackJson']),
      totalTokens: serializer.fromJson<int>(json['totalTokens']),
      topicAttemptId: serializer.fromJson<String?>(json['topicAttemptId']),
      revisionNumber: serializer.fromJson<int>(json['revisionNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'topicId': serializer.toJson<String?>(topicId),
      'onRamp': serializer.toJson<String>(onRamp),
      'inputMode': serializer.toJson<String>(inputMode),
      'inputText': serializer.toJson<String?>(inputText),
      'feedbackJson': serializer.toJson<String>(feedbackJson),
      'totalTokens': serializer.toJson<int>(totalTokens),
      'topicAttemptId': serializer.toJson<String?>(topicAttemptId),
      'revisionNumber': serializer.toJson<int>(revisionNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DailySpeakingSessionTableData copyWith(
          {int? id,
          Value<String?> topicId = const Value.absent(),
          String? onRamp,
          String? inputMode,
          Value<String?> inputText = const Value.absent(),
          String? feedbackJson,
          int? totalTokens,
          Value<String?> topicAttemptId = const Value.absent(),
          int? revisionNumber,
          DateTime? createdAt}) =>
      DailySpeakingSessionTableData(
        id: id ?? this.id,
        topicId: topicId.present ? topicId.value : this.topicId,
        onRamp: onRamp ?? this.onRamp,
        inputMode: inputMode ?? this.inputMode,
        inputText: inputText.present ? inputText.value : this.inputText,
        feedbackJson: feedbackJson ?? this.feedbackJson,
        totalTokens: totalTokens ?? this.totalTokens,
        topicAttemptId:
            topicAttemptId.present ? topicAttemptId.value : this.topicAttemptId,
        revisionNumber: revisionNumber ?? this.revisionNumber,
        createdAt: createdAt ?? this.createdAt,
      );
  DailySpeakingSessionTableData copyWithCompanion(
      DailySpeakingSessionTableCompanion data) {
    return DailySpeakingSessionTableData(
      id: data.id.present ? data.id.value : this.id,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      onRamp: data.onRamp.present ? data.onRamp.value : this.onRamp,
      inputMode: data.inputMode.present ? data.inputMode.value : this.inputMode,
      inputText: data.inputText.present ? data.inputText.value : this.inputText,
      feedbackJson: data.feedbackJson.present
          ? data.feedbackJson.value
          : this.feedbackJson,
      totalTokens:
          data.totalTokens.present ? data.totalTokens.value : this.totalTokens,
      topicAttemptId: data.topicAttemptId.present
          ? data.topicAttemptId.value
          : this.topicAttemptId,
      revisionNumber: data.revisionNumber.present
          ? data.revisionNumber.value
          : this.revisionNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailySpeakingSessionTableData(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('onRamp: $onRamp, ')
          ..write('inputMode: $inputMode, ')
          ..write('inputText: $inputText, ')
          ..write('feedbackJson: $feedbackJson, ')
          ..write('totalTokens: $totalTokens, ')
          ..write('topicAttemptId: $topicAttemptId, ')
          ..write('revisionNumber: $revisionNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, topicId, onRamp, inputMode, inputText,
      feedbackJson, totalTokens, topicAttemptId, revisionNumber, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailySpeakingSessionTableData &&
          other.id == this.id &&
          other.topicId == this.topicId &&
          other.onRamp == this.onRamp &&
          other.inputMode == this.inputMode &&
          other.inputText == this.inputText &&
          other.feedbackJson == this.feedbackJson &&
          other.totalTokens == this.totalTokens &&
          other.topicAttemptId == this.topicAttemptId &&
          other.revisionNumber == this.revisionNumber &&
          other.createdAt == this.createdAt);
}

class DailySpeakingSessionTableCompanion
    extends UpdateCompanion<DailySpeakingSessionTableData> {
  final Value<int> id;
  final Value<String?> topicId;
  final Value<String> onRamp;
  final Value<String> inputMode;
  final Value<String?> inputText;
  final Value<String> feedbackJson;
  final Value<int> totalTokens;
  final Value<String?> topicAttemptId;
  final Value<int> revisionNumber;
  final Value<DateTime> createdAt;
  const DailySpeakingSessionTableCompanion({
    this.id = const Value.absent(),
    this.topicId = const Value.absent(),
    this.onRamp = const Value.absent(),
    this.inputMode = const Value.absent(),
    this.inputText = const Value.absent(),
    this.feedbackJson = const Value.absent(),
    this.totalTokens = const Value.absent(),
    this.topicAttemptId = const Value.absent(),
    this.revisionNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DailySpeakingSessionTableCompanion.insert({
    this.id = const Value.absent(),
    this.topicId = const Value.absent(),
    required String onRamp,
    required String inputMode,
    this.inputText = const Value.absent(),
    required String feedbackJson,
    required int totalTokens,
    this.topicAttemptId = const Value.absent(),
    this.revisionNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : onRamp = Value(onRamp),
        inputMode = Value(inputMode),
        feedbackJson = Value(feedbackJson),
        totalTokens = Value(totalTokens);
  static Insertable<DailySpeakingSessionTableData> custom({
    Expression<int>? id,
    Expression<String>? topicId,
    Expression<String>? onRamp,
    Expression<String>? inputMode,
    Expression<String>? inputText,
    Expression<String>? feedbackJson,
    Expression<int>? totalTokens,
    Expression<String>? topicAttemptId,
    Expression<int>? revisionNumber,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (topicId != null) 'topic_id': topicId,
      if (onRamp != null) 'on_ramp': onRamp,
      if (inputMode != null) 'input_mode': inputMode,
      if (inputText != null) 'input_text': inputText,
      if (feedbackJson != null) 'feedback_json': feedbackJson,
      if (totalTokens != null) 'total_tokens': totalTokens,
      if (topicAttemptId != null) 'topic_attempt_id': topicAttemptId,
      if (revisionNumber != null) 'revision_number': revisionNumber,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DailySpeakingSessionTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? topicId,
      Value<String>? onRamp,
      Value<String>? inputMode,
      Value<String?>? inputText,
      Value<String>? feedbackJson,
      Value<int>? totalTokens,
      Value<String?>? topicAttemptId,
      Value<int>? revisionNumber,
      Value<DateTime>? createdAt}) {
    return DailySpeakingSessionTableCompanion(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      onRamp: onRamp ?? this.onRamp,
      inputMode: inputMode ?? this.inputMode,
      inputText: inputText ?? this.inputText,
      feedbackJson: feedbackJson ?? this.feedbackJson,
      totalTokens: totalTokens ?? this.totalTokens,
      topicAttemptId: topicAttemptId ?? this.topicAttemptId,
      revisionNumber: revisionNumber ?? this.revisionNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (onRamp.present) {
      map['on_ramp'] = Variable<String>(onRamp.value);
    }
    if (inputMode.present) {
      map['input_mode'] = Variable<String>(inputMode.value);
    }
    if (inputText.present) {
      map['input_text'] = Variable<String>(inputText.value);
    }
    if (feedbackJson.present) {
      map['feedback_json'] = Variable<String>(feedbackJson.value);
    }
    if (totalTokens.present) {
      map['total_tokens'] = Variable<int>(totalTokens.value);
    }
    if (topicAttemptId.present) {
      map['topic_attempt_id'] = Variable<String>(topicAttemptId.value);
    }
    if (revisionNumber.present) {
      map['revision_number'] = Variable<int>(revisionNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailySpeakingSessionTableCompanion(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('onRamp: $onRamp, ')
          ..write('inputMode: $inputMode, ')
          ..write('inputText: $inputText, ')
          ..write('feedbackJson: $feedbackJson, ')
          ..write('totalTokens: $totalTokens, ')
          ..write('topicAttemptId: $topicAttemptId, ')
          ..write('revisionNumber: $revisionNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AiSentencePracticeTableTable aiSentencePracticeTable =
      $AiSentencePracticeTableTable(this);
  late final $UserExampleAnswerTableTable userExampleAnswerTable =
      $UserExampleAnswerTableTable(this);
  late final $ListeningPracticeAnswerTableTable listeningPracticeAnswerTable =
      $ListeningPracticeAnswerTableTable(this);
  late final $SpokenPatternExerciseAnswerTableTable
      spokenPatternExerciseAnswerTable =
      $SpokenPatternExerciseAnswerTableTable(this);
  late final $UserRecordedSentenceAudioTableTable
      userRecordedSentenceAudioTable =
      $UserRecordedSentenceAudioTableTable(this);
  late final $SavedTermTableTable savedTermTable = $SavedTermTableTable(this);
  late final $VideoStepProgressTableTable videoStepProgressTable =
      $VideoStepProgressTableTable(this);
  late final $DailySpeakingSessionTableTable dailySpeakingSessionTable =
      $DailySpeakingSessionTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        aiSentencePracticeTable,
        userExampleAnswerTable,
        listeningPracticeAnswerTable,
        spokenPatternExerciseAnswerTable,
        userRecordedSentenceAudioTable,
        savedTermTable,
        videoStepProgressTable,
        dailySpeakingSessionTable
      ];
}

typedef $$AiSentencePracticeTableTableCreateCompanionBuilder
    = AiSentencePracticeTableCompanion Function({
  Value<int> id,
  required String inputSentence,
  Value<String?> correctedSentence,
  Value<String?> explanation,
  required int totalTokensUsed,
  Value<DateTime> createdAt,
});
typedef $$AiSentencePracticeTableTableUpdateCompanionBuilder
    = AiSentencePracticeTableCompanion Function({
  Value<int> id,
  Value<String> inputSentence,
  Value<String?> correctedSentence,
  Value<String?> explanation,
  Value<int> totalTokensUsed,
  Value<DateTime> createdAt,
});

class $$AiSentencePracticeTableTableFilterComposer
    extends Composer<_$AppDatabase, $AiSentencePracticeTableTable> {
  $$AiSentencePracticeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get inputSentence => $composableBuilder(
      column: $table.inputSentence, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get correctedSentence => $composableBuilder(
      column: $table.correctedSentence,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalTokensUsed => $composableBuilder(
      column: $table.totalTokensUsed,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$AiSentencePracticeTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AiSentencePracticeTableTable> {
  $$AiSentencePracticeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get inputSentence => $composableBuilder(
      column: $table.inputSentence,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get correctedSentence => $composableBuilder(
      column: $table.correctedSentence,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalTokensUsed => $composableBuilder(
      column: $table.totalTokensUsed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$AiSentencePracticeTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiSentencePracticeTableTable> {
  $$AiSentencePracticeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get inputSentence => $composableBuilder(
      column: $table.inputSentence, builder: (column) => column);

  GeneratedColumn<String> get correctedSentence => $composableBuilder(
      column: $table.correctedSentence, builder: (column) => column);

  GeneratedColumn<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => column);

  GeneratedColumn<int> get totalTokensUsed => $composableBuilder(
      column: $table.totalTokensUsed, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AiSentencePracticeTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AiSentencePracticeTableTable,
    AiSentencePractice,
    $$AiSentencePracticeTableTableFilterComposer,
    $$AiSentencePracticeTableTableOrderingComposer,
    $$AiSentencePracticeTableTableAnnotationComposer,
    $$AiSentencePracticeTableTableCreateCompanionBuilder,
    $$AiSentencePracticeTableTableUpdateCompanionBuilder,
    (
      AiSentencePractice,
      BaseReferences<_$AppDatabase, $AiSentencePracticeTableTable,
          AiSentencePractice>
    ),
    AiSentencePractice,
    PrefetchHooks Function()> {
  $$AiSentencePracticeTableTableTableManager(
      _$AppDatabase db, $AiSentencePracticeTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiSentencePracticeTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$AiSentencePracticeTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiSentencePracticeTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> inputSentence = const Value.absent(),
            Value<String?> correctedSentence = const Value.absent(),
            Value<String?> explanation = const Value.absent(),
            Value<int> totalTokensUsed = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              AiSentencePracticeTableCompanion(
            id: id,
            inputSentence: inputSentence,
            correctedSentence: correctedSentence,
            explanation: explanation,
            totalTokensUsed: totalTokensUsed,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String inputSentence,
            Value<String?> correctedSentence = const Value.absent(),
            Value<String?> explanation = const Value.absent(),
            required int totalTokensUsed,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              AiSentencePracticeTableCompanion.insert(
            id: id,
            inputSentence: inputSentence,
            correctedSentence: correctedSentence,
            explanation: explanation,
            totalTokensUsed: totalTokensUsed,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AiSentencePracticeTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $AiSentencePracticeTableTable,
        AiSentencePractice,
        $$AiSentencePracticeTableTableFilterComposer,
        $$AiSentencePracticeTableTableOrderingComposer,
        $$AiSentencePracticeTableTableAnnotationComposer,
        $$AiSentencePracticeTableTableCreateCompanionBuilder,
        $$AiSentencePracticeTableTableUpdateCompanionBuilder,
        (
          AiSentencePractice,
          BaseReferences<_$AppDatabase, $AiSentencePracticeTableTable,
              AiSentencePractice>
        ),
        AiSentencePractice,
        PrefetchHooks Function()>;
typedef $$UserExampleAnswerTableTableCreateCompanionBuilder
    = UserExampleAnswerTableCompanion Function({
  Value<int> id,
  required int exampleId,
  required String userAnswer,
});
typedef $$UserExampleAnswerTableTableUpdateCompanionBuilder
    = UserExampleAnswerTableCompanion Function({
  Value<int> id,
  Value<int> exampleId,
  Value<String> userAnswer,
});

class $$UserExampleAnswerTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserExampleAnswerTableTable> {
  $$UserExampleAnswerTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get exampleId => $composableBuilder(
      column: $table.exampleId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userAnswer => $composableBuilder(
      column: $table.userAnswer, builder: (column) => ColumnFilters(column));
}

class $$UserExampleAnswerTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserExampleAnswerTableTable> {
  $$UserExampleAnswerTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get exampleId => $composableBuilder(
      column: $table.exampleId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userAnswer => $composableBuilder(
      column: $table.userAnswer, builder: (column) => ColumnOrderings(column));
}

class $$UserExampleAnswerTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserExampleAnswerTableTable> {
  $$UserExampleAnswerTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get exampleId =>
      $composableBuilder(column: $table.exampleId, builder: (column) => column);

  GeneratedColumn<String> get userAnswer => $composableBuilder(
      column: $table.userAnswer, builder: (column) => column);
}

class $$UserExampleAnswerTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserExampleAnswerTableTable,
    UserExampleAnswerTableData,
    $$UserExampleAnswerTableTableFilterComposer,
    $$UserExampleAnswerTableTableOrderingComposer,
    $$UserExampleAnswerTableTableAnnotationComposer,
    $$UserExampleAnswerTableTableCreateCompanionBuilder,
    $$UserExampleAnswerTableTableUpdateCompanionBuilder,
    (
      UserExampleAnswerTableData,
      BaseReferences<_$AppDatabase, $UserExampleAnswerTableTable,
          UserExampleAnswerTableData>
    ),
    UserExampleAnswerTableData,
    PrefetchHooks Function()> {
  $$UserExampleAnswerTableTableTableManager(
      _$AppDatabase db, $UserExampleAnswerTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserExampleAnswerTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$UserExampleAnswerTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserExampleAnswerTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> exampleId = const Value.absent(),
            Value<String> userAnswer = const Value.absent(),
          }) =>
              UserExampleAnswerTableCompanion(
            id: id,
            exampleId: exampleId,
            userAnswer: userAnswer,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int exampleId,
            required String userAnswer,
          }) =>
              UserExampleAnswerTableCompanion.insert(
            id: id,
            exampleId: exampleId,
            userAnswer: userAnswer,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserExampleAnswerTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $UserExampleAnswerTableTable,
        UserExampleAnswerTableData,
        $$UserExampleAnswerTableTableFilterComposer,
        $$UserExampleAnswerTableTableOrderingComposer,
        $$UserExampleAnswerTableTableAnnotationComposer,
        $$UserExampleAnswerTableTableCreateCompanionBuilder,
        $$UserExampleAnswerTableTableUpdateCompanionBuilder,
        (
          UserExampleAnswerTableData,
          BaseReferences<_$AppDatabase, $UserExampleAnswerTableTable,
              UserExampleAnswerTableData>
        ),
        UserExampleAnswerTableData,
        PrefetchHooks Function()>;
typedef $$ListeningPracticeAnswerTableTableCreateCompanionBuilder
    = ListeningPracticeAnswerTableCompanion Function({
  Value<int> id,
  required String youtubeId,
  required String groupId,
  required int questionId,
  Value<String?> userAnswer,
  required int timeSpent,
  required bool isCorrect,
});
typedef $$ListeningPracticeAnswerTableTableUpdateCompanionBuilder
    = ListeningPracticeAnswerTableCompanion Function({
  Value<int> id,
  Value<String> youtubeId,
  Value<String> groupId,
  Value<int> questionId,
  Value<String?> userAnswer,
  Value<int> timeSpent,
  Value<bool> isCorrect,
});

class $$ListeningPracticeAnswerTableTableFilterComposer
    extends Composer<_$AppDatabase, $ListeningPracticeAnswerTableTable> {
  $$ListeningPracticeAnswerTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get youtubeId => $composableBuilder(
      column: $table.youtubeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userAnswer => $composableBuilder(
      column: $table.userAnswer, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timeSpent => $composableBuilder(
      column: $table.timeSpent, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnFilters(column));
}

class $$ListeningPracticeAnswerTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ListeningPracticeAnswerTableTable> {
  $$ListeningPracticeAnswerTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get youtubeId => $composableBuilder(
      column: $table.youtubeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userAnswer => $composableBuilder(
      column: $table.userAnswer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timeSpent => $composableBuilder(
      column: $table.timeSpent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnOrderings(column));
}

class $$ListeningPracticeAnswerTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ListeningPracticeAnswerTableTable> {
  $$ListeningPracticeAnswerTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get youtubeId =>
      $composableBuilder(column: $table.youtubeId, builder: (column) => column);

  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<int> get questionId => $composableBuilder(
      column: $table.questionId, builder: (column) => column);

  GeneratedColumn<String> get userAnswer => $composableBuilder(
      column: $table.userAnswer, builder: (column) => column);

  GeneratedColumn<int> get timeSpent =>
      $composableBuilder(column: $table.timeSpent, builder: (column) => column);

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);
}

class $$ListeningPracticeAnswerTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ListeningPracticeAnswerTableTable,
    ListeningPracticeAnswer,
    $$ListeningPracticeAnswerTableTableFilterComposer,
    $$ListeningPracticeAnswerTableTableOrderingComposer,
    $$ListeningPracticeAnswerTableTableAnnotationComposer,
    $$ListeningPracticeAnswerTableTableCreateCompanionBuilder,
    $$ListeningPracticeAnswerTableTableUpdateCompanionBuilder,
    (
      ListeningPracticeAnswer,
      BaseReferences<_$AppDatabase, $ListeningPracticeAnswerTableTable,
          ListeningPracticeAnswer>
    ),
    ListeningPracticeAnswer,
    PrefetchHooks Function()> {
  $$ListeningPracticeAnswerTableTableTableManager(
      _$AppDatabase db, $ListeningPracticeAnswerTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ListeningPracticeAnswerTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ListeningPracticeAnswerTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ListeningPracticeAnswerTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> youtubeId = const Value.absent(),
            Value<String> groupId = const Value.absent(),
            Value<int> questionId = const Value.absent(),
            Value<String?> userAnswer = const Value.absent(),
            Value<int> timeSpent = const Value.absent(),
            Value<bool> isCorrect = const Value.absent(),
          }) =>
              ListeningPracticeAnswerTableCompanion(
            id: id,
            youtubeId: youtubeId,
            groupId: groupId,
            questionId: questionId,
            userAnswer: userAnswer,
            timeSpent: timeSpent,
            isCorrect: isCorrect,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String youtubeId,
            required String groupId,
            required int questionId,
            Value<String?> userAnswer = const Value.absent(),
            required int timeSpent,
            required bool isCorrect,
          }) =>
              ListeningPracticeAnswerTableCompanion.insert(
            id: id,
            youtubeId: youtubeId,
            groupId: groupId,
            questionId: questionId,
            userAnswer: userAnswer,
            timeSpent: timeSpent,
            isCorrect: isCorrect,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ListeningPracticeAnswerTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ListeningPracticeAnswerTableTable,
        ListeningPracticeAnswer,
        $$ListeningPracticeAnswerTableTableFilterComposer,
        $$ListeningPracticeAnswerTableTableOrderingComposer,
        $$ListeningPracticeAnswerTableTableAnnotationComposer,
        $$ListeningPracticeAnswerTableTableCreateCompanionBuilder,
        $$ListeningPracticeAnswerTableTableUpdateCompanionBuilder,
        (
          ListeningPracticeAnswer,
          BaseReferences<_$AppDatabase, $ListeningPracticeAnswerTableTable,
              ListeningPracticeAnswer>
        ),
        ListeningPracticeAnswer,
        PrefetchHooks Function()>;
typedef $$SpokenPatternExerciseAnswerTableTableCreateCompanionBuilder
    = SpokenPatternExerciseAnswerTableCompanion Function({
  Value<int> id,
  required int patternExerciseId,
  required String userAnswer,
});
typedef $$SpokenPatternExerciseAnswerTableTableUpdateCompanionBuilder
    = SpokenPatternExerciseAnswerTableCompanion Function({
  Value<int> id,
  Value<int> patternExerciseId,
  Value<String> userAnswer,
});

class $$SpokenPatternExerciseAnswerTableTableFilterComposer
    extends Composer<_$AppDatabase, $SpokenPatternExerciseAnswerTableTable> {
  $$SpokenPatternExerciseAnswerTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get patternExerciseId => $composableBuilder(
      column: $table.patternExerciseId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userAnswer => $composableBuilder(
      column: $table.userAnswer, builder: (column) => ColumnFilters(column));
}

class $$SpokenPatternExerciseAnswerTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SpokenPatternExerciseAnswerTableTable> {
  $$SpokenPatternExerciseAnswerTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get patternExerciseId => $composableBuilder(
      column: $table.patternExerciseId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userAnswer => $composableBuilder(
      column: $table.userAnswer, builder: (column) => ColumnOrderings(column));
}

class $$SpokenPatternExerciseAnswerTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpokenPatternExerciseAnswerTableTable> {
  $$SpokenPatternExerciseAnswerTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get patternExerciseId => $composableBuilder(
      column: $table.patternExerciseId, builder: (column) => column);

  GeneratedColumn<String> get userAnswer => $composableBuilder(
      column: $table.userAnswer, builder: (column) => column);
}

class $$SpokenPatternExerciseAnswerTableTableTableManager
    extends RootTableManager<
        _$AppDatabase,
        $SpokenPatternExerciseAnswerTableTable,
        ExerciseUserAnswer,
        $$SpokenPatternExerciseAnswerTableTableFilterComposer,
        $$SpokenPatternExerciseAnswerTableTableOrderingComposer,
        $$SpokenPatternExerciseAnswerTableTableAnnotationComposer,
        $$SpokenPatternExerciseAnswerTableTableCreateCompanionBuilder,
        $$SpokenPatternExerciseAnswerTableTableUpdateCompanionBuilder,
        (
          ExerciseUserAnswer,
          BaseReferences<_$AppDatabase, $SpokenPatternExerciseAnswerTableTable,
              ExerciseUserAnswer>
        ),
        ExerciseUserAnswer,
        PrefetchHooks Function()> {
  $$SpokenPatternExerciseAnswerTableTableTableManager(
      _$AppDatabase db, $SpokenPatternExerciseAnswerTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpokenPatternExerciseAnswerTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$SpokenPatternExerciseAnswerTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpokenPatternExerciseAnswerTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> patternExerciseId = const Value.absent(),
            Value<String> userAnswer = const Value.absent(),
          }) =>
              SpokenPatternExerciseAnswerTableCompanion(
            id: id,
            patternExerciseId: patternExerciseId,
            userAnswer: userAnswer,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int patternExerciseId,
            required String userAnswer,
          }) =>
              SpokenPatternExerciseAnswerTableCompanion.insert(
            id: id,
            patternExerciseId: patternExerciseId,
            userAnswer: userAnswer,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SpokenPatternExerciseAnswerTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SpokenPatternExerciseAnswerTableTable,
        ExerciseUserAnswer,
        $$SpokenPatternExerciseAnswerTableTableFilterComposer,
        $$SpokenPatternExerciseAnswerTableTableOrderingComposer,
        $$SpokenPatternExerciseAnswerTableTableAnnotationComposer,
        $$SpokenPatternExerciseAnswerTableTableCreateCompanionBuilder,
        $$SpokenPatternExerciseAnswerTableTableUpdateCompanionBuilder,
        (
          ExerciseUserAnswer,
          BaseReferences<_$AppDatabase, $SpokenPatternExerciseAnswerTableTable,
              ExerciseUserAnswer>
        ),
        ExerciseUserAnswer,
        PrefetchHooks Function()>;
typedef $$UserRecordedSentenceAudioTableTableCreateCompanionBuilder
    = UserRecordedSentenceAudioTableCompanion Function({
  Value<int> id,
  required String sentenceId,
  required String youtubeId,
  required String audioPath,
  required String audioName,
  Value<DateTime> createdAt,
});
typedef $$UserRecordedSentenceAudioTableTableUpdateCompanionBuilder
    = UserRecordedSentenceAudioTableCompanion Function({
  Value<int> id,
  Value<String> sentenceId,
  Value<String> youtubeId,
  Value<String> audioPath,
  Value<String> audioName,
  Value<DateTime> createdAt,
});

class $$UserRecordedSentenceAudioTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserRecordedSentenceAudioTableTable> {
  $$UserRecordedSentenceAudioTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sentenceId => $composableBuilder(
      column: $table.sentenceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get youtubeId => $composableBuilder(
      column: $table.youtubeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get audioPath => $composableBuilder(
      column: $table.audioPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get audioName => $composableBuilder(
      column: $table.audioName, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$UserRecordedSentenceAudioTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserRecordedSentenceAudioTableTable> {
  $$UserRecordedSentenceAudioTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sentenceId => $composableBuilder(
      column: $table.sentenceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get youtubeId => $composableBuilder(
      column: $table.youtubeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get audioPath => $composableBuilder(
      column: $table.audioPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get audioName => $composableBuilder(
      column: $table.audioName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$UserRecordedSentenceAudioTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserRecordedSentenceAudioTableTable> {
  $$UserRecordedSentenceAudioTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sentenceId => $composableBuilder(
      column: $table.sentenceId, builder: (column) => column);

  GeneratedColumn<String> get youtubeId =>
      $composableBuilder(column: $table.youtubeId, builder: (column) => column);

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);

  GeneratedColumn<String> get audioName =>
      $composableBuilder(column: $table.audioName, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserRecordedSentenceAudioTableTableTableManager
    extends RootTableManager<
        _$AppDatabase,
        $UserRecordedSentenceAudioTableTable,
        UserRecordedSentenceAudio,
        $$UserRecordedSentenceAudioTableTableFilterComposer,
        $$UserRecordedSentenceAudioTableTableOrderingComposer,
        $$UserRecordedSentenceAudioTableTableAnnotationComposer,
        $$UserRecordedSentenceAudioTableTableCreateCompanionBuilder,
        $$UserRecordedSentenceAudioTableTableUpdateCompanionBuilder,
        (
          UserRecordedSentenceAudio,
          BaseReferences<_$AppDatabase, $UserRecordedSentenceAudioTableTable,
              UserRecordedSentenceAudio>
        ),
        UserRecordedSentenceAudio,
        PrefetchHooks Function()> {
  $$UserRecordedSentenceAudioTableTableTableManager(
      _$AppDatabase db, $UserRecordedSentenceAudioTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserRecordedSentenceAudioTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$UserRecordedSentenceAudioTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserRecordedSentenceAudioTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> sentenceId = const Value.absent(),
            Value<String> youtubeId = const Value.absent(),
            Value<String> audioPath = const Value.absent(),
            Value<String> audioName = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UserRecordedSentenceAudioTableCompanion(
            id: id,
            sentenceId: sentenceId,
            youtubeId: youtubeId,
            audioPath: audioPath,
            audioName: audioName,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String sentenceId,
            required String youtubeId,
            required String audioPath,
            required String audioName,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              UserRecordedSentenceAudioTableCompanion.insert(
            id: id,
            sentenceId: sentenceId,
            youtubeId: youtubeId,
            audioPath: audioPath,
            audioName: audioName,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserRecordedSentenceAudioTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $UserRecordedSentenceAudioTableTable,
        UserRecordedSentenceAudio,
        $$UserRecordedSentenceAudioTableTableFilterComposer,
        $$UserRecordedSentenceAudioTableTableOrderingComposer,
        $$UserRecordedSentenceAudioTableTableAnnotationComposer,
        $$UserRecordedSentenceAudioTableTableCreateCompanionBuilder,
        $$UserRecordedSentenceAudioTableTableUpdateCompanionBuilder,
        (
          UserRecordedSentenceAudio,
          BaseReferences<_$AppDatabase, $UserRecordedSentenceAudioTableTable,
              UserRecordedSentenceAudio>
        ),
        UserRecordedSentenceAudio,
        PrefetchHooks Function()>;
typedef $$SavedTermTableTableCreateCompanionBuilder = SavedTermTableCompanion
    Function({
  Value<int> id,
  required String term,
  Value<String> kind,
  Value<String?> translationMy,
  Value<String?> definitionMy,
  Value<String> examplesJson,
  Value<String?> sourceTitle,
  Value<String?> sourceSentence,
  Value<DateTime> savedAt,
});
typedef $$SavedTermTableTableUpdateCompanionBuilder = SavedTermTableCompanion
    Function({
  Value<int> id,
  Value<String> term,
  Value<String> kind,
  Value<String?> translationMy,
  Value<String?> definitionMy,
  Value<String> examplesJson,
  Value<String?> sourceTitle,
  Value<String?> sourceSentence,
  Value<DateTime> savedAt,
});

class $$SavedTermTableTableFilterComposer
    extends Composer<_$AppDatabase, $SavedTermTableTable> {
  $$SavedTermTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get term => $composableBuilder(
      column: $table.term, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get translationMy => $composableBuilder(
      column: $table.translationMy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get definitionMy => $composableBuilder(
      column: $table.definitionMy, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get examplesJson => $composableBuilder(
      column: $table.examplesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceTitle => $composableBuilder(
      column: $table.sourceTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceSentence => $composableBuilder(
      column: $table.sourceSentence,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
      column: $table.savedAt, builder: (column) => ColumnFilters(column));
}

class $$SavedTermTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedTermTableTable> {
  $$SavedTermTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get term => $composableBuilder(
      column: $table.term, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translationMy => $composableBuilder(
      column: $table.translationMy,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get definitionMy => $composableBuilder(
      column: $table.definitionMy,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get examplesJson => $composableBuilder(
      column: $table.examplesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceTitle => $composableBuilder(
      column: $table.sourceTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceSentence => $composableBuilder(
      column: $table.sourceSentence,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
      column: $table.savedAt, builder: (column) => ColumnOrderings(column));
}

class $$SavedTermTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedTermTableTable> {
  $$SavedTermTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get term =>
      $composableBuilder(column: $table.term, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get translationMy => $composableBuilder(
      column: $table.translationMy, builder: (column) => column);

  GeneratedColumn<String> get definitionMy => $composableBuilder(
      column: $table.definitionMy, builder: (column) => column);

  GeneratedColumn<String> get examplesJson => $composableBuilder(
      column: $table.examplesJson, builder: (column) => column);

  GeneratedColumn<String> get sourceTitle => $composableBuilder(
      column: $table.sourceTitle, builder: (column) => column);

  GeneratedColumn<String> get sourceSentence => $composableBuilder(
      column: $table.sourceSentence, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$SavedTermTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavedTermTableTable,
    SavedTerm,
    $$SavedTermTableTableFilterComposer,
    $$SavedTermTableTableOrderingComposer,
    $$SavedTermTableTableAnnotationComposer,
    $$SavedTermTableTableCreateCompanionBuilder,
    $$SavedTermTableTableUpdateCompanionBuilder,
    (SavedTerm, BaseReferences<_$AppDatabase, $SavedTermTableTable, SavedTerm>),
    SavedTerm,
    PrefetchHooks Function()> {
  $$SavedTermTableTableTableManager(
      _$AppDatabase db, $SavedTermTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedTermTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedTermTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedTermTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> term = const Value.absent(),
            Value<String> kind = const Value.absent(),
            Value<String?> translationMy = const Value.absent(),
            Value<String?> definitionMy = const Value.absent(),
            Value<String> examplesJson = const Value.absent(),
            Value<String?> sourceTitle = const Value.absent(),
            Value<String?> sourceSentence = const Value.absent(),
            Value<DateTime> savedAt = const Value.absent(),
          }) =>
              SavedTermTableCompanion(
            id: id,
            term: term,
            kind: kind,
            translationMy: translationMy,
            definitionMy: definitionMy,
            examplesJson: examplesJson,
            sourceTitle: sourceTitle,
            sourceSentence: sourceSentence,
            savedAt: savedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String term,
            Value<String> kind = const Value.absent(),
            Value<String?> translationMy = const Value.absent(),
            Value<String?> definitionMy = const Value.absent(),
            Value<String> examplesJson = const Value.absent(),
            Value<String?> sourceTitle = const Value.absent(),
            Value<String?> sourceSentence = const Value.absent(),
            Value<DateTime> savedAt = const Value.absent(),
          }) =>
              SavedTermTableCompanion.insert(
            id: id,
            term: term,
            kind: kind,
            translationMy: translationMy,
            definitionMy: definitionMy,
            examplesJson: examplesJson,
            sourceTitle: sourceTitle,
            sourceSentence: sourceSentence,
            savedAt: savedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SavedTermTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SavedTermTableTable,
    SavedTerm,
    $$SavedTermTableTableFilterComposer,
    $$SavedTermTableTableOrderingComposer,
    $$SavedTermTableTableAnnotationComposer,
    $$SavedTermTableTableCreateCompanionBuilder,
    $$SavedTermTableTableUpdateCompanionBuilder,
    (SavedTerm, BaseReferences<_$AppDatabase, $SavedTermTableTable, SavedTerm>),
    SavedTerm,
    PrefetchHooks Function()>;
typedef $$VideoStepProgressTableTableCreateCompanionBuilder
    = VideoStepProgressTableCompanion Function({
  required String youtubeId,
  required String stepKey,
  Value<int> state,
  Value<DateTime?> lastOpenedAt,
  Value<int> openCount,
  Value<int> rowid,
});
typedef $$VideoStepProgressTableTableUpdateCompanionBuilder
    = VideoStepProgressTableCompanion Function({
  Value<String> youtubeId,
  Value<String> stepKey,
  Value<int> state,
  Value<DateTime?> lastOpenedAt,
  Value<int> openCount,
  Value<int> rowid,
});

class $$VideoStepProgressTableTableFilterComposer
    extends Composer<_$AppDatabase, $VideoStepProgressTableTable> {
  $$VideoStepProgressTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get youtubeId => $composableBuilder(
      column: $table.youtubeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stepKey => $composableBuilder(
      column: $table.stepKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastOpenedAt => $composableBuilder(
      column: $table.lastOpenedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get openCount => $composableBuilder(
      column: $table.openCount, builder: (column) => ColumnFilters(column));
}

class $$VideoStepProgressTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VideoStepProgressTableTable> {
  $$VideoStepProgressTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get youtubeId => $composableBuilder(
      column: $table.youtubeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stepKey => $composableBuilder(
      column: $table.stepKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastOpenedAt => $composableBuilder(
      column: $table.lastOpenedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get openCount => $composableBuilder(
      column: $table.openCount, builder: (column) => ColumnOrderings(column));
}

class $$VideoStepProgressTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VideoStepProgressTableTable> {
  $$VideoStepProgressTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get youtubeId =>
      $composableBuilder(column: $table.youtubeId, builder: (column) => column);

  GeneratedColumn<String> get stepKey =>
      $composableBuilder(column: $table.stepKey, builder: (column) => column);

  GeneratedColumn<int> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<DateTime> get lastOpenedAt => $composableBuilder(
      column: $table.lastOpenedAt, builder: (column) => column);

  GeneratedColumn<int> get openCount =>
      $composableBuilder(column: $table.openCount, builder: (column) => column);
}

class $$VideoStepProgressTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VideoStepProgressTableTable,
    VideoStepProgress,
    $$VideoStepProgressTableTableFilterComposer,
    $$VideoStepProgressTableTableOrderingComposer,
    $$VideoStepProgressTableTableAnnotationComposer,
    $$VideoStepProgressTableTableCreateCompanionBuilder,
    $$VideoStepProgressTableTableUpdateCompanionBuilder,
    (
      VideoStepProgress,
      BaseReferences<_$AppDatabase, $VideoStepProgressTableTable,
          VideoStepProgress>
    ),
    VideoStepProgress,
    PrefetchHooks Function()> {
  $$VideoStepProgressTableTableTableManager(
      _$AppDatabase db, $VideoStepProgressTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideoStepProgressTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$VideoStepProgressTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VideoStepProgressTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> youtubeId = const Value.absent(),
            Value<String> stepKey = const Value.absent(),
            Value<int> state = const Value.absent(),
            Value<DateTime?> lastOpenedAt = const Value.absent(),
            Value<int> openCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VideoStepProgressTableCompanion(
            youtubeId: youtubeId,
            stepKey: stepKey,
            state: state,
            lastOpenedAt: lastOpenedAt,
            openCount: openCount,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String youtubeId,
            required String stepKey,
            Value<int> state = const Value.absent(),
            Value<DateTime?> lastOpenedAt = const Value.absent(),
            Value<int> openCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VideoStepProgressTableCompanion.insert(
            youtubeId: youtubeId,
            stepKey: stepKey,
            state: state,
            lastOpenedAt: lastOpenedAt,
            openCount: openCount,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VideoStepProgressTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $VideoStepProgressTableTable,
        VideoStepProgress,
        $$VideoStepProgressTableTableFilterComposer,
        $$VideoStepProgressTableTableOrderingComposer,
        $$VideoStepProgressTableTableAnnotationComposer,
        $$VideoStepProgressTableTableCreateCompanionBuilder,
        $$VideoStepProgressTableTableUpdateCompanionBuilder,
        (
          VideoStepProgress,
          BaseReferences<_$AppDatabase, $VideoStepProgressTableTable,
              VideoStepProgress>
        ),
        VideoStepProgress,
        PrefetchHooks Function()>;
typedef $$DailySpeakingSessionTableTableCreateCompanionBuilder
    = DailySpeakingSessionTableCompanion Function({
  Value<int> id,
  Value<String?> topicId,
  required String onRamp,
  required String inputMode,
  Value<String?> inputText,
  required String feedbackJson,
  required int totalTokens,
  Value<String?> topicAttemptId,
  Value<int> revisionNumber,
  Value<DateTime> createdAt,
});
typedef $$DailySpeakingSessionTableTableUpdateCompanionBuilder
    = DailySpeakingSessionTableCompanion Function({
  Value<int> id,
  Value<String?> topicId,
  Value<String> onRamp,
  Value<String> inputMode,
  Value<String?> inputText,
  Value<String> feedbackJson,
  Value<int> totalTokens,
  Value<String?> topicAttemptId,
  Value<int> revisionNumber,
  Value<DateTime> createdAt,
});

class $$DailySpeakingSessionTableTableFilterComposer
    extends Composer<_$AppDatabase, $DailySpeakingSessionTableTable> {
  $$DailySpeakingSessionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get topicId => $composableBuilder(
      column: $table.topicId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get onRamp => $composableBuilder(
      column: $table.onRamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get inputMode => $composableBuilder(
      column: $table.inputMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get inputText => $composableBuilder(
      column: $table.inputText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get feedbackJson => $composableBuilder(
      column: $table.feedbackJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalTokens => $composableBuilder(
      column: $table.totalTokens, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get topicAttemptId => $composableBuilder(
      column: $table.topicAttemptId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get revisionNumber => $composableBuilder(
      column: $table.revisionNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$DailySpeakingSessionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DailySpeakingSessionTableTable> {
  $$DailySpeakingSessionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get topicId => $composableBuilder(
      column: $table.topicId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get onRamp => $composableBuilder(
      column: $table.onRamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get inputMode => $composableBuilder(
      column: $table.inputMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get inputText => $composableBuilder(
      column: $table.inputText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get feedbackJson => $composableBuilder(
      column: $table.feedbackJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalTokens => $composableBuilder(
      column: $table.totalTokens, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get topicAttemptId => $composableBuilder(
      column: $table.topicAttemptId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get revisionNumber => $composableBuilder(
      column: $table.revisionNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DailySpeakingSessionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailySpeakingSessionTableTable> {
  $$DailySpeakingSessionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<String> get onRamp =>
      $composableBuilder(column: $table.onRamp, builder: (column) => column);

  GeneratedColumn<String> get inputMode =>
      $composableBuilder(column: $table.inputMode, builder: (column) => column);

  GeneratedColumn<String> get inputText =>
      $composableBuilder(column: $table.inputText, builder: (column) => column);

  GeneratedColumn<String> get feedbackJson => $composableBuilder(
      column: $table.feedbackJson, builder: (column) => column);

  GeneratedColumn<int> get totalTokens => $composableBuilder(
      column: $table.totalTokens, builder: (column) => column);

  GeneratedColumn<String> get topicAttemptId => $composableBuilder(
      column: $table.topicAttemptId, builder: (column) => column);

  GeneratedColumn<int> get revisionNumber => $composableBuilder(
      column: $table.revisionNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DailySpeakingSessionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailySpeakingSessionTableTable,
    DailySpeakingSessionTableData,
    $$DailySpeakingSessionTableTableFilterComposer,
    $$DailySpeakingSessionTableTableOrderingComposer,
    $$DailySpeakingSessionTableTableAnnotationComposer,
    $$DailySpeakingSessionTableTableCreateCompanionBuilder,
    $$DailySpeakingSessionTableTableUpdateCompanionBuilder,
    (
      DailySpeakingSessionTableData,
      BaseReferences<_$AppDatabase, $DailySpeakingSessionTableTable,
          DailySpeakingSessionTableData>
    ),
    DailySpeakingSessionTableData,
    PrefetchHooks Function()> {
  $$DailySpeakingSessionTableTableTableManager(
      _$AppDatabase db, $DailySpeakingSessionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailySpeakingSessionTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$DailySpeakingSessionTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailySpeakingSessionTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> topicId = const Value.absent(),
            Value<String> onRamp = const Value.absent(),
            Value<String> inputMode = const Value.absent(),
            Value<String?> inputText = const Value.absent(),
            Value<String> feedbackJson = const Value.absent(),
            Value<int> totalTokens = const Value.absent(),
            Value<String?> topicAttemptId = const Value.absent(),
            Value<int> revisionNumber = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DailySpeakingSessionTableCompanion(
            id: id,
            topicId: topicId,
            onRamp: onRamp,
            inputMode: inputMode,
            inputText: inputText,
            feedbackJson: feedbackJson,
            totalTokens: totalTokens,
            topicAttemptId: topicAttemptId,
            revisionNumber: revisionNumber,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> topicId = const Value.absent(),
            required String onRamp,
            required String inputMode,
            Value<String?> inputText = const Value.absent(),
            required String feedbackJson,
            required int totalTokens,
            Value<String?> topicAttemptId = const Value.absent(),
            Value<int> revisionNumber = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DailySpeakingSessionTableCompanion.insert(
            id: id,
            topicId: topicId,
            onRamp: onRamp,
            inputMode: inputMode,
            inputText: inputText,
            feedbackJson: feedbackJson,
            totalTokens: totalTokens,
            topicAttemptId: topicAttemptId,
            revisionNumber: revisionNumber,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailySpeakingSessionTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $DailySpeakingSessionTableTable,
        DailySpeakingSessionTableData,
        $$DailySpeakingSessionTableTableFilterComposer,
        $$DailySpeakingSessionTableTableOrderingComposer,
        $$DailySpeakingSessionTableTableAnnotationComposer,
        $$DailySpeakingSessionTableTableCreateCompanionBuilder,
        $$DailySpeakingSessionTableTableUpdateCompanionBuilder,
        (
          DailySpeakingSessionTableData,
          BaseReferences<_$AppDatabase, $DailySpeakingSessionTableTable,
              DailySpeakingSessionTableData>
        ),
        DailySpeakingSessionTableData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AiSentencePracticeTableTableTableManager get aiSentencePracticeTable =>
      $$AiSentencePracticeTableTableTableManager(
          _db, _db.aiSentencePracticeTable);
  $$UserExampleAnswerTableTableTableManager get userExampleAnswerTable =>
      $$UserExampleAnswerTableTableTableManager(
          _db, _db.userExampleAnswerTable);
  $$ListeningPracticeAnswerTableTableTableManager
      get listeningPracticeAnswerTable =>
          $$ListeningPracticeAnswerTableTableTableManager(
              _db, _db.listeningPracticeAnswerTable);
  $$SpokenPatternExerciseAnswerTableTableTableManager
      get spokenPatternExerciseAnswerTable =>
          $$SpokenPatternExerciseAnswerTableTableTableManager(
              _db, _db.spokenPatternExerciseAnswerTable);
  $$UserRecordedSentenceAudioTableTableTableManager
      get userRecordedSentenceAudioTable =>
          $$UserRecordedSentenceAudioTableTableTableManager(
              _db, _db.userRecordedSentenceAudioTable);
  $$SavedTermTableTableTableManager get savedTermTable =>
      $$SavedTermTableTableTableManager(_db, _db.savedTermTable);
  $$VideoStepProgressTableTableTableManager get videoStepProgressTable =>
      $$VideoStepProgressTableTableTableManager(
          _db, _db.videoStepProgressTable);
  $$DailySpeakingSessionTableTableTableManager get dailySpeakingSessionTable =>
      $$DailySpeakingSessionTableTableTableManager(
          _db, _db.dailySpeakingSessionTable);
}
