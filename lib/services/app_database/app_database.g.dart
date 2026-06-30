// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
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

class $WritingProgressTableTable extends WritingProgressTable
    with TableInfo<$WritingProgressTableTable, WritingProgressTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WritingProgressTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
      'unit_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [unitId, completedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'writing_progress_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<WritingProgressTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    } else if (isInserting) {
      context.missing(_unitIdMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {unitId};
  @override
  WritingProgressTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WritingProgressTableData(
      unitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_id'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at'])!,
    );
  }

  @override
  $WritingProgressTableTable createAlias(String alias) {
    return $WritingProgressTableTable(attachedDatabase, alias);
  }
}

class WritingProgressTableData extends DataClass
    implements Insertable<WritingProgressTableData> {
  final String unitId;
  final DateTime completedAt;
  const WritingProgressTableData(
      {required this.unitId, required this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['unit_id'] = Variable<String>(unitId);
    map['completed_at'] = Variable<DateTime>(completedAt);
    return map;
  }

  WritingProgressTableCompanion toCompanion(bool nullToAbsent) {
    return WritingProgressTableCompanion(
      unitId: Value(unitId),
      completedAt: Value(completedAt),
    );
  }

  factory WritingProgressTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WritingProgressTableData(
      unitId: serializer.fromJson<String>(json['unitId']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'unitId': serializer.toJson<String>(unitId),
      'completedAt': serializer.toJson<DateTime>(completedAt),
    };
  }

  WritingProgressTableData copyWith({String? unitId, DateTime? completedAt}) =>
      WritingProgressTableData(
        unitId: unitId ?? this.unitId,
        completedAt: completedAt ?? this.completedAt,
      );
  WritingProgressTableData copyWithCompanion(
      WritingProgressTableCompanion data) {
    return WritingProgressTableData(
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WritingProgressTableData(')
          ..write('unitId: $unitId, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(unitId, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WritingProgressTableData &&
          other.unitId == this.unitId &&
          other.completedAt == this.completedAt);
}

class WritingProgressTableCompanion
    extends UpdateCompanion<WritingProgressTableData> {
  final Value<String> unitId;
  final Value<DateTime> completedAt;
  final Value<int> rowid;
  const WritingProgressTableCompanion({
    this.unitId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WritingProgressTableCompanion.insert({
    required String unitId,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : unitId = Value(unitId);
  static Insertable<WritingProgressTableData> custom({
    Expression<String>? unitId,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (unitId != null) 'unit_id': unitId,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WritingProgressTableCompanion copyWith(
      {Value<String>? unitId,
      Value<DateTime>? completedAt,
      Value<int>? rowid}) {
    return WritingProgressTableCompanion(
      unitId: unitId ?? this.unitId,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WritingProgressTableCompanion(')
          ..write('unitId: $unitId, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VocabReviewTableTable extends VocabReviewTable
    with TableInfo<$VocabReviewTableTable, VocabReviewTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabReviewTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _boxMeta = const VerificationMeta('box');
  @override
  late final GeneratedColumn<int> box = GeneratedColumn<int>(
      'box', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<int> dueAt = GeneratedColumn<int>(
      'due_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _seenMeta = const VerificationMeta('seen');
  @override
  late final GeneratedColumn<int> seen = GeneratedColumn<int>(
      'seen', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _correctMeta =
      const VerificationMeta('correct');
  @override
  late final GeneratedColumn<int> correct = GeneratedColumn<int>(
      'correct', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [groupId, word, box, dueAt, seen, correct];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocab_review_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<VocabReviewTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('box')) {
      context.handle(
          _boxMeta, box.isAcceptableOrUnknown(data['box']!, _boxMeta));
    }
    if (data.containsKey('due_at')) {
      context.handle(
          _dueAtMeta, dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta));
    }
    if (data.containsKey('seen')) {
      context.handle(
          _seenMeta, seen.isAcceptableOrUnknown(data['seen']!, _seenMeta));
    }
    if (data.containsKey('correct')) {
      context.handle(_correctMeta,
          correct.isAcceptableOrUnknown(data['correct']!, _correctMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {groupId, word};
  @override
  VocabReviewTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabReviewTableData(
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      box: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}box'])!,
      dueAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}due_at'])!,
      seen: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}seen'])!,
      correct: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}correct'])!,
    );
  }

  @override
  $VocabReviewTableTable createAlias(String alias) {
    return $VocabReviewTableTable(attachedDatabase, alias);
  }
}

class VocabReviewTableData extends DataClass
    implements Insertable<VocabReviewTableData> {
  final String groupId;

  /// The taught word/expression (normalised lowercase) — the exercise answer.
  final String word;

  /// Leitner box 1..5 (higher = longer interval / better known).
  final int box;

  /// Epoch milliseconds when this word is next due.
  final int dueAt;

  /// Counters for simple stats / weakest-first ordering.
  final int seen;
  final int correct;
  const VocabReviewTableData(
      {required this.groupId,
      required this.word,
      required this.box,
      required this.dueAt,
      required this.seen,
      required this.correct});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['group_id'] = Variable<String>(groupId);
    map['word'] = Variable<String>(word);
    map['box'] = Variable<int>(box);
    map['due_at'] = Variable<int>(dueAt);
    map['seen'] = Variable<int>(seen);
    map['correct'] = Variable<int>(correct);
    return map;
  }

  VocabReviewTableCompanion toCompanion(bool nullToAbsent) {
    return VocabReviewTableCompanion(
      groupId: Value(groupId),
      word: Value(word),
      box: Value(box),
      dueAt: Value(dueAt),
      seen: Value(seen),
      correct: Value(correct),
    );
  }

  factory VocabReviewTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabReviewTableData(
      groupId: serializer.fromJson<String>(json['groupId']),
      word: serializer.fromJson<String>(json['word']),
      box: serializer.fromJson<int>(json['box']),
      dueAt: serializer.fromJson<int>(json['dueAt']),
      seen: serializer.fromJson<int>(json['seen']),
      correct: serializer.fromJson<int>(json['correct']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'groupId': serializer.toJson<String>(groupId),
      'word': serializer.toJson<String>(word),
      'box': serializer.toJson<int>(box),
      'dueAt': serializer.toJson<int>(dueAt),
      'seen': serializer.toJson<int>(seen),
      'correct': serializer.toJson<int>(correct),
    };
  }

  VocabReviewTableData copyWith(
          {String? groupId,
          String? word,
          int? box,
          int? dueAt,
          int? seen,
          int? correct}) =>
      VocabReviewTableData(
        groupId: groupId ?? this.groupId,
        word: word ?? this.word,
        box: box ?? this.box,
        dueAt: dueAt ?? this.dueAt,
        seen: seen ?? this.seen,
        correct: correct ?? this.correct,
      );
  VocabReviewTableData copyWithCompanion(VocabReviewTableCompanion data) {
    return VocabReviewTableData(
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      word: data.word.present ? data.word.value : this.word,
      box: data.box.present ? data.box.value : this.box,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      seen: data.seen.present ? data.seen.value : this.seen,
      correct: data.correct.present ? data.correct.value : this.correct,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabReviewTableData(')
          ..write('groupId: $groupId, ')
          ..write('word: $word, ')
          ..write('box: $box, ')
          ..write('dueAt: $dueAt, ')
          ..write('seen: $seen, ')
          ..write('correct: $correct')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(groupId, word, box, dueAt, seen, correct);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabReviewTableData &&
          other.groupId == this.groupId &&
          other.word == this.word &&
          other.box == this.box &&
          other.dueAt == this.dueAt &&
          other.seen == this.seen &&
          other.correct == this.correct);
}

class VocabReviewTableCompanion extends UpdateCompanion<VocabReviewTableData> {
  final Value<String> groupId;
  final Value<String> word;
  final Value<int> box;
  final Value<int> dueAt;
  final Value<int> seen;
  final Value<int> correct;
  final Value<int> rowid;
  const VocabReviewTableCompanion({
    this.groupId = const Value.absent(),
    this.word = const Value.absent(),
    this.box = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.seen = const Value.absent(),
    this.correct = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VocabReviewTableCompanion.insert({
    required String groupId,
    required String word,
    this.box = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.seen = const Value.absent(),
    this.correct = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : groupId = Value(groupId),
        word = Value(word);
  static Insertable<VocabReviewTableData> custom({
    Expression<String>? groupId,
    Expression<String>? word,
    Expression<int>? box,
    Expression<int>? dueAt,
    Expression<int>? seen,
    Expression<int>? correct,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (groupId != null) 'group_id': groupId,
      if (word != null) 'word': word,
      if (box != null) 'box': box,
      if (dueAt != null) 'due_at': dueAt,
      if (seen != null) 'seen': seen,
      if (correct != null) 'correct': correct,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VocabReviewTableCompanion copyWith(
      {Value<String>? groupId,
      Value<String>? word,
      Value<int>? box,
      Value<int>? dueAt,
      Value<int>? seen,
      Value<int>? correct,
      Value<int>? rowid}) {
    return VocabReviewTableCompanion(
      groupId: groupId ?? this.groupId,
      word: word ?? this.word,
      box: box ?? this.box,
      dueAt: dueAt ?? this.dueAt,
      seen: seen ?? this.seen,
      correct: correct ?? this.correct,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (box.present) {
      map['box'] = Variable<int>(box.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<int>(dueAt.value);
    }
    if (seen.present) {
      map['seen'] = Variable<int>(seen.value);
    }
    if (correct.present) {
      map['correct'] = Variable<int>(correct.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabReviewTableCompanion(')
          ..write('groupId: $groupId, ')
          ..write('word: $word, ')
          ..write('box: $box, ')
          ..write('dueAt: $dueAt, ')
          ..write('seen: $seen, ')
          ..write('correct: $correct, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SymSessionTableTable extends SymSessionTable
    with TableInfo<$SymSessionTableTable, SymSessionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymSessionTableTable(this.attachedDatabase, [this._alias]);
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
      'topic_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _finalTextMeta =
      const VerificationMeta('finalText');
  @override
  late final GeneratedColumn<String> finalText = GeneratedColumn<String>(
      'final_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _naturalVersionMeta =
      const VerificationMeta('naturalVersion');
  @override
  late final GeneratedColumn<String> naturalVersion = GeneratedColumn<String>(
      'natural_version', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
      'score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _bandMeta = const VerificationMeta('band');
  @override
  late final GeneratedColumn<String> band = GeneratedColumn<String>(
      'band', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _versionsMeta =
      const VerificationMeta('versions');
  @override
  late final GeneratedColumn<int> versions = GeneratedColumn<int>(
      'versions', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _recordingPathMeta =
      const VerificationMeta('recordingPath');
  @override
  late final GeneratedColumn<String> recordingPath = GeneratedColumn<String>(
      'recording_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _recordingNameMeta =
      const VerificationMeta('recordingName');
  @override
  late final GeneratedColumn<String> recordingName = GeneratedColumn<String>(
      'recording_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tokensMeta = const VerificationMeta('tokens');
  @override
  late final GeneratedColumn<int> tokens = GeneratedColumn<int>(
      'tokens', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _versionsJsonMeta =
      const VerificationMeta('versionsJson');
  @override
  late final GeneratedColumn<String> versionsJson = GeneratedColumn<String>(
      'versions_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
        finalText,
        naturalVersion,
        score,
        band,
        versions,
        recordingPath,
        recordingName,
        tokens,
        versionsJson,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sym_session_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SymSessionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('topic_id')) {
      context.handle(_topicIdMeta,
          topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta));
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('final_text')) {
      context.handle(_finalTextMeta,
          finalText.isAcceptableOrUnknown(data['final_text']!, _finalTextMeta));
    } else if (isInserting) {
      context.missing(_finalTextMeta);
    }
    if (data.containsKey('natural_version')) {
      context.handle(
          _naturalVersionMeta,
          naturalVersion.isAcceptableOrUnknown(
              data['natural_version']!, _naturalVersionMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    if (data.containsKey('band')) {
      context.handle(
          _bandMeta, band.isAcceptableOrUnknown(data['band']!, _bandMeta));
    }
    if (data.containsKey('versions')) {
      context.handle(_versionsMeta,
          versions.isAcceptableOrUnknown(data['versions']!, _versionsMeta));
    }
    if (data.containsKey('recording_path')) {
      context.handle(
          _recordingPathMeta,
          recordingPath.isAcceptableOrUnknown(
              data['recording_path']!, _recordingPathMeta));
    }
    if (data.containsKey('recording_name')) {
      context.handle(
          _recordingNameMeta,
          recordingName.isAcceptableOrUnknown(
              data['recording_name']!, _recordingNameMeta));
    }
    if (data.containsKey('tokens')) {
      context.handle(_tokensMeta,
          tokens.isAcceptableOrUnknown(data['tokens']!, _tokensMeta));
    }
    if (data.containsKey('versions_json')) {
      context.handle(
          _versionsJsonMeta,
          versionsJson.isAcceptableOrUnknown(
              data['versions_json']!, _versionsJsonMeta));
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
  SymSessionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymSessionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      topicId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}topic_id'])!,
      finalText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}final_text'])!,
      naturalVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}natural_version']),
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}score']),
      band: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}band']),
      versions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}versions'])!,
      recordingPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recording_path']),
      recordingName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recording_name']),
      tokens: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tokens'])!,
      versionsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}versions_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SymSessionTableTable createAlias(String alias) {
    return $SymSessionTableTable(attachedDatabase, alias);
  }
}

class SymSessionTableData extends DataClass
    implements Insertable<SymSessionTableData> {
  final int id;

  /// The topic this session belongs to (e.g. `my_family`).
  final String topicId;

  /// What the learner finally wrote.
  final String finalText;

  /// The AI's natural rewrite (null if feedback was skipped / failed).
  final String? naturalVersion;

  /// Clarity score 0–100 from the last feedback pass.
  final int? score;

  /// great | good | keep_going.
  final String? band;

  /// How many drafts (v1, v2, …) the learner went through.
  final int versions;

  /// On-device path to the voice recording (null if they didn't record).
  final String? recordingPath;
  final String? recordingName;

  /// Tokens billed across all versions of this attempt (0 for mock / skipped).
  final int tokens;

  /// JSON array of every version (v1, v2, …) in this attempt — each with its
  /// own text + feedback summary. Null/empty ⇒ a single version (use the summary
  /// columns above). Lets the history show a v1/v2 chain.
  final String? versionsJson;
  final DateTime createdAt;
  const SymSessionTableData(
      {required this.id,
      required this.topicId,
      required this.finalText,
      this.naturalVersion,
      this.score,
      this.band,
      required this.versions,
      this.recordingPath,
      this.recordingName,
      required this.tokens,
      this.versionsJson,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['topic_id'] = Variable<String>(topicId);
    map['final_text'] = Variable<String>(finalText);
    if (!nullToAbsent || naturalVersion != null) {
      map['natural_version'] = Variable<String>(naturalVersion);
    }
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<int>(score);
    }
    if (!nullToAbsent || band != null) {
      map['band'] = Variable<String>(band);
    }
    map['versions'] = Variable<int>(versions);
    if (!nullToAbsent || recordingPath != null) {
      map['recording_path'] = Variable<String>(recordingPath);
    }
    if (!nullToAbsent || recordingName != null) {
      map['recording_name'] = Variable<String>(recordingName);
    }
    map['tokens'] = Variable<int>(tokens);
    if (!nullToAbsent || versionsJson != null) {
      map['versions_json'] = Variable<String>(versionsJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SymSessionTableCompanion toCompanion(bool nullToAbsent) {
    return SymSessionTableCompanion(
      id: Value(id),
      topicId: Value(topicId),
      finalText: Value(finalText),
      naturalVersion: naturalVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(naturalVersion),
      score:
          score == null && nullToAbsent ? const Value.absent() : Value(score),
      band: band == null && nullToAbsent ? const Value.absent() : Value(band),
      versions: Value(versions),
      recordingPath: recordingPath == null && nullToAbsent
          ? const Value.absent()
          : Value(recordingPath),
      recordingName: recordingName == null && nullToAbsent
          ? const Value.absent()
          : Value(recordingName),
      tokens: Value(tokens),
      versionsJson: versionsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(versionsJson),
      createdAt: Value(createdAt),
    );
  }

  factory SymSessionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymSessionTableData(
      id: serializer.fromJson<int>(json['id']),
      topicId: serializer.fromJson<String>(json['topicId']),
      finalText: serializer.fromJson<String>(json['finalText']),
      naturalVersion: serializer.fromJson<String?>(json['naturalVersion']),
      score: serializer.fromJson<int?>(json['score']),
      band: serializer.fromJson<String?>(json['band']),
      versions: serializer.fromJson<int>(json['versions']),
      recordingPath: serializer.fromJson<String?>(json['recordingPath']),
      recordingName: serializer.fromJson<String?>(json['recordingName']),
      tokens: serializer.fromJson<int>(json['tokens']),
      versionsJson: serializer.fromJson<String?>(json['versionsJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'topicId': serializer.toJson<String>(topicId),
      'finalText': serializer.toJson<String>(finalText),
      'naturalVersion': serializer.toJson<String?>(naturalVersion),
      'score': serializer.toJson<int?>(score),
      'band': serializer.toJson<String?>(band),
      'versions': serializer.toJson<int>(versions),
      'recordingPath': serializer.toJson<String?>(recordingPath),
      'recordingName': serializer.toJson<String?>(recordingName),
      'tokens': serializer.toJson<int>(tokens),
      'versionsJson': serializer.toJson<String?>(versionsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SymSessionTableData copyWith(
          {int? id,
          String? topicId,
          String? finalText,
          Value<String?> naturalVersion = const Value.absent(),
          Value<int?> score = const Value.absent(),
          Value<String?> band = const Value.absent(),
          int? versions,
          Value<String?> recordingPath = const Value.absent(),
          Value<String?> recordingName = const Value.absent(),
          int? tokens,
          Value<String?> versionsJson = const Value.absent(),
          DateTime? createdAt}) =>
      SymSessionTableData(
        id: id ?? this.id,
        topicId: topicId ?? this.topicId,
        finalText: finalText ?? this.finalText,
        naturalVersion:
            naturalVersion.present ? naturalVersion.value : this.naturalVersion,
        score: score.present ? score.value : this.score,
        band: band.present ? band.value : this.band,
        versions: versions ?? this.versions,
        recordingPath:
            recordingPath.present ? recordingPath.value : this.recordingPath,
        recordingName:
            recordingName.present ? recordingName.value : this.recordingName,
        tokens: tokens ?? this.tokens,
        versionsJson:
            versionsJson.present ? versionsJson.value : this.versionsJson,
        createdAt: createdAt ?? this.createdAt,
      );
  SymSessionTableData copyWithCompanion(SymSessionTableCompanion data) {
    return SymSessionTableData(
      id: data.id.present ? data.id.value : this.id,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      finalText: data.finalText.present ? data.finalText.value : this.finalText,
      naturalVersion: data.naturalVersion.present
          ? data.naturalVersion.value
          : this.naturalVersion,
      score: data.score.present ? data.score.value : this.score,
      band: data.band.present ? data.band.value : this.band,
      versions: data.versions.present ? data.versions.value : this.versions,
      recordingPath: data.recordingPath.present
          ? data.recordingPath.value
          : this.recordingPath,
      recordingName: data.recordingName.present
          ? data.recordingName.value
          : this.recordingName,
      tokens: data.tokens.present ? data.tokens.value : this.tokens,
      versionsJson: data.versionsJson.present
          ? data.versionsJson.value
          : this.versionsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymSessionTableData(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('finalText: $finalText, ')
          ..write('naturalVersion: $naturalVersion, ')
          ..write('score: $score, ')
          ..write('band: $band, ')
          ..write('versions: $versions, ')
          ..write('recordingPath: $recordingPath, ')
          ..write('recordingName: $recordingName, ')
          ..write('tokens: $tokens, ')
          ..write('versionsJson: $versionsJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      topicId,
      finalText,
      naturalVersion,
      score,
      band,
      versions,
      recordingPath,
      recordingName,
      tokens,
      versionsJson,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymSessionTableData &&
          other.id == this.id &&
          other.topicId == this.topicId &&
          other.finalText == this.finalText &&
          other.naturalVersion == this.naturalVersion &&
          other.score == this.score &&
          other.band == this.band &&
          other.versions == this.versions &&
          other.recordingPath == this.recordingPath &&
          other.recordingName == this.recordingName &&
          other.tokens == this.tokens &&
          other.versionsJson == this.versionsJson &&
          other.createdAt == this.createdAt);
}

class SymSessionTableCompanion extends UpdateCompanion<SymSessionTableData> {
  final Value<int> id;
  final Value<String> topicId;
  final Value<String> finalText;
  final Value<String?> naturalVersion;
  final Value<int?> score;
  final Value<String?> band;
  final Value<int> versions;
  final Value<String?> recordingPath;
  final Value<String?> recordingName;
  final Value<int> tokens;
  final Value<String?> versionsJson;
  final Value<DateTime> createdAt;
  const SymSessionTableCompanion({
    this.id = const Value.absent(),
    this.topicId = const Value.absent(),
    this.finalText = const Value.absent(),
    this.naturalVersion = const Value.absent(),
    this.score = const Value.absent(),
    this.band = const Value.absent(),
    this.versions = const Value.absent(),
    this.recordingPath = const Value.absent(),
    this.recordingName = const Value.absent(),
    this.tokens = const Value.absent(),
    this.versionsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SymSessionTableCompanion.insert({
    this.id = const Value.absent(),
    required String topicId,
    required String finalText,
    this.naturalVersion = const Value.absent(),
    this.score = const Value.absent(),
    this.band = const Value.absent(),
    this.versions = const Value.absent(),
    this.recordingPath = const Value.absent(),
    this.recordingName = const Value.absent(),
    this.tokens = const Value.absent(),
    this.versionsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : topicId = Value(topicId),
        finalText = Value(finalText);
  static Insertable<SymSessionTableData> custom({
    Expression<int>? id,
    Expression<String>? topicId,
    Expression<String>? finalText,
    Expression<String>? naturalVersion,
    Expression<int>? score,
    Expression<String>? band,
    Expression<int>? versions,
    Expression<String>? recordingPath,
    Expression<String>? recordingName,
    Expression<int>? tokens,
    Expression<String>? versionsJson,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (topicId != null) 'topic_id': topicId,
      if (finalText != null) 'final_text': finalText,
      if (naturalVersion != null) 'natural_version': naturalVersion,
      if (score != null) 'score': score,
      if (band != null) 'band': band,
      if (versions != null) 'versions': versions,
      if (recordingPath != null) 'recording_path': recordingPath,
      if (recordingName != null) 'recording_name': recordingName,
      if (tokens != null) 'tokens': tokens,
      if (versionsJson != null) 'versions_json': versionsJson,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SymSessionTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? topicId,
      Value<String>? finalText,
      Value<String?>? naturalVersion,
      Value<int?>? score,
      Value<String?>? band,
      Value<int>? versions,
      Value<String?>? recordingPath,
      Value<String?>? recordingName,
      Value<int>? tokens,
      Value<String?>? versionsJson,
      Value<DateTime>? createdAt}) {
    return SymSessionTableCompanion(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      finalText: finalText ?? this.finalText,
      naturalVersion: naturalVersion ?? this.naturalVersion,
      score: score ?? this.score,
      band: band ?? this.band,
      versions: versions ?? this.versions,
      recordingPath: recordingPath ?? this.recordingPath,
      recordingName: recordingName ?? this.recordingName,
      tokens: tokens ?? this.tokens,
      versionsJson: versionsJson ?? this.versionsJson,
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
    if (finalText.present) {
      map['final_text'] = Variable<String>(finalText.value);
    }
    if (naturalVersion.present) {
      map['natural_version'] = Variable<String>(naturalVersion.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (band.present) {
      map['band'] = Variable<String>(band.value);
    }
    if (versions.present) {
      map['versions'] = Variable<int>(versions.value);
    }
    if (recordingPath.present) {
      map['recording_path'] = Variable<String>(recordingPath.value);
    }
    if (recordingName.present) {
      map['recording_name'] = Variable<String>(recordingName.value);
    }
    if (tokens.present) {
      map['tokens'] = Variable<int>(tokens.value);
    }
    if (versionsJson.present) {
      map['versions_json'] = Variable<String>(versionsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymSessionTableCompanion(')
          ..write('id: $id, ')
          ..write('topicId: $topicId, ')
          ..write('finalText: $finalText, ')
          ..write('naturalVersion: $naturalVersion, ')
          ..write('score: $score, ')
          ..write('band: $band, ')
          ..write('versions: $versions, ')
          ..write('recordingPath: $recordingPath, ')
          ..write('recordingName: $recordingName, ')
          ..write('tokens: $tokens, ')
          ..write('versionsJson: $versionsJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ChallengeMarkTableTable extends ChallengeMarkTable
    with TableInfo<$ChallengeMarkTableTable, ChallengeMarkTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChallengeMarkTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _youtubeIdMeta =
      const VerificationMeta('youtubeId');
  @override
  late final GeneratedColumn<String> youtubeId = GeneratedColumn<String>(
      'youtube_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sentenceIndexMeta =
      const VerificationMeta('sentenceIndex');
  @override
  late final GeneratedColumn<int> sentenceIndex = GeneratedColumn<int>(
      'sentence_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _positionMsMeta =
      const VerificationMeta('positionMs');
  @override
  late final GeneratedColumn<int> positionMs = GeneratedColumn<int>(
      'position_ms', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
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
      [youtubeId, sentenceIndex, positionMs, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenge_mark_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChallengeMarkTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('youtube_id')) {
      context.handle(_youtubeIdMeta,
          youtubeId.isAcceptableOrUnknown(data['youtube_id']!, _youtubeIdMeta));
    } else if (isInserting) {
      context.missing(_youtubeIdMeta);
    }
    if (data.containsKey('sentence_index')) {
      context.handle(
          _sentenceIndexMeta,
          sentenceIndex.isAcceptableOrUnknown(
              data['sentence_index']!, _sentenceIndexMeta));
    } else if (isInserting) {
      context.missing(_sentenceIndexMeta);
    }
    if (data.containsKey('position_ms')) {
      context.handle(
          _positionMsMeta,
          positionMs.isAcceptableOrUnknown(
              data['position_ms']!, _positionMsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {youtubeId, sentenceIndex};
  @override
  ChallengeMarkTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChallengeMarkTableData(
      youtubeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}youtube_id'])!,
      sentenceIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sentence_index'])!,
      positionMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position_ms'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ChallengeMarkTableTable createAlias(String alias) {
    return $ChallengeMarkTableTable(attachedDatabase, alias);
  }
}

class ChallengeMarkTableData extends DataClass
    implements Insertable<ChallengeMarkTableData> {
  /// The lesson's YouTube id (matches Listening.youtubeId).
  final String youtubeId;

  /// Index of the marked sentence within the lesson's subtitle list.
  final int sentenceIndex;

  /// The raw playback position (ms) the learner tapped at — kept for reference.
  final int positionMs;
  final DateTime createdAt;
  const ChallengeMarkTableData(
      {required this.youtubeId,
      required this.sentenceIndex,
      required this.positionMs,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['youtube_id'] = Variable<String>(youtubeId);
    map['sentence_index'] = Variable<int>(sentenceIndex);
    map['position_ms'] = Variable<int>(positionMs);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ChallengeMarkTableCompanion toCompanion(bool nullToAbsent) {
    return ChallengeMarkTableCompanion(
      youtubeId: Value(youtubeId),
      sentenceIndex: Value(sentenceIndex),
      positionMs: Value(positionMs),
      createdAt: Value(createdAt),
    );
  }

  factory ChallengeMarkTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChallengeMarkTableData(
      youtubeId: serializer.fromJson<String>(json['youtubeId']),
      sentenceIndex: serializer.fromJson<int>(json['sentenceIndex']),
      positionMs: serializer.fromJson<int>(json['positionMs']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'youtubeId': serializer.toJson<String>(youtubeId),
      'sentenceIndex': serializer.toJson<int>(sentenceIndex),
      'positionMs': serializer.toJson<int>(positionMs),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ChallengeMarkTableData copyWith(
          {String? youtubeId,
          int? sentenceIndex,
          int? positionMs,
          DateTime? createdAt}) =>
      ChallengeMarkTableData(
        youtubeId: youtubeId ?? this.youtubeId,
        sentenceIndex: sentenceIndex ?? this.sentenceIndex,
        positionMs: positionMs ?? this.positionMs,
        createdAt: createdAt ?? this.createdAt,
      );
  ChallengeMarkTableData copyWithCompanion(ChallengeMarkTableCompanion data) {
    return ChallengeMarkTableData(
      youtubeId: data.youtubeId.present ? data.youtubeId.value : this.youtubeId,
      sentenceIndex: data.sentenceIndex.present
          ? data.sentenceIndex.value
          : this.sentenceIndex,
      positionMs:
          data.positionMs.present ? data.positionMs.value : this.positionMs,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChallengeMarkTableData(')
          ..write('youtubeId: $youtubeId, ')
          ..write('sentenceIndex: $sentenceIndex, ')
          ..write('positionMs: $positionMs, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(youtubeId, sentenceIndex, positionMs, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChallengeMarkTableData &&
          other.youtubeId == this.youtubeId &&
          other.sentenceIndex == this.sentenceIndex &&
          other.positionMs == this.positionMs &&
          other.createdAt == this.createdAt);
}

class ChallengeMarkTableCompanion
    extends UpdateCompanion<ChallengeMarkTableData> {
  final Value<String> youtubeId;
  final Value<int> sentenceIndex;
  final Value<int> positionMs;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ChallengeMarkTableCompanion({
    this.youtubeId = const Value.absent(),
    this.sentenceIndex = const Value.absent(),
    this.positionMs = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChallengeMarkTableCompanion.insert({
    required String youtubeId,
    required int sentenceIndex,
    this.positionMs = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : youtubeId = Value(youtubeId),
        sentenceIndex = Value(sentenceIndex);
  static Insertable<ChallengeMarkTableData> custom({
    Expression<String>? youtubeId,
    Expression<int>? sentenceIndex,
    Expression<int>? positionMs,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (youtubeId != null) 'youtube_id': youtubeId,
      if (sentenceIndex != null) 'sentence_index': sentenceIndex,
      if (positionMs != null) 'position_ms': positionMs,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChallengeMarkTableCompanion copyWith(
      {Value<String>? youtubeId,
      Value<int>? sentenceIndex,
      Value<int>? positionMs,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return ChallengeMarkTableCompanion(
      youtubeId: youtubeId ?? this.youtubeId,
      sentenceIndex: sentenceIndex ?? this.sentenceIndex,
      positionMs: positionMs ?? this.positionMs,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (youtubeId.present) {
      map['youtube_id'] = Variable<String>(youtubeId.value);
    }
    if (sentenceIndex.present) {
      map['sentence_index'] = Variable<int>(sentenceIndex.value);
    }
    if (positionMs.present) {
      map['position_ms'] = Variable<int>(positionMs.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengeMarkTableCompanion(')
          ..write('youtubeId: $youtubeId, ')
          ..write('sentenceIndex: $sentenceIndex, ')
          ..write('positionMs: $positionMs, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ListeningPracticeAnswerTableTable listeningPracticeAnswerTable =
      $ListeningPracticeAnswerTableTable(this);
  late final $UserRecordedSentenceAudioTableTable
      userRecordedSentenceAudioTable =
      $UserRecordedSentenceAudioTableTable(this);
  late final $SavedTermTableTable savedTermTable = $SavedTermTableTable(this);
  late final $VideoStepProgressTableTable videoStepProgressTable =
      $VideoStepProgressTableTable(this);
  late final $WritingProgressTableTable writingProgressTable =
      $WritingProgressTableTable(this);
  late final $VocabReviewTableTable vocabReviewTable =
      $VocabReviewTableTable(this);
  late final $SymSessionTableTable symSessionTable =
      $SymSessionTableTable(this);
  late final $ChallengeMarkTableTable challengeMarkTable =
      $ChallengeMarkTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        listeningPracticeAnswerTable,
        userRecordedSentenceAudioTable,
        savedTermTable,
        videoStepProgressTable,
        writingProgressTable,
        vocabReviewTable,
        symSessionTable,
        challengeMarkTable
      ];
}

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
typedef $$WritingProgressTableTableCreateCompanionBuilder
    = WritingProgressTableCompanion Function({
  required String unitId,
  Value<DateTime> completedAt,
  Value<int> rowid,
});
typedef $$WritingProgressTableTableUpdateCompanionBuilder
    = WritingProgressTableCompanion Function({
  Value<String> unitId,
  Value<DateTime> completedAt,
  Value<int> rowid,
});

class $$WritingProgressTableTableFilterComposer
    extends Composer<_$AppDatabase, $WritingProgressTableTable> {
  $$WritingProgressTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get unitId => $composableBuilder(
      column: $table.unitId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));
}

class $$WritingProgressTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WritingProgressTableTable> {
  $$WritingProgressTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get unitId => $composableBuilder(
      column: $table.unitId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));
}

class $$WritingProgressTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WritingProgressTableTable> {
  $$WritingProgressTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get unitId =>
      $composableBuilder(column: $table.unitId, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);
}

class $$WritingProgressTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WritingProgressTableTable,
    WritingProgressTableData,
    $$WritingProgressTableTableFilterComposer,
    $$WritingProgressTableTableOrderingComposer,
    $$WritingProgressTableTableAnnotationComposer,
    $$WritingProgressTableTableCreateCompanionBuilder,
    $$WritingProgressTableTableUpdateCompanionBuilder,
    (
      WritingProgressTableData,
      BaseReferences<_$AppDatabase, $WritingProgressTableTable,
          WritingProgressTableData>
    ),
    WritingProgressTableData,
    PrefetchHooks Function()> {
  $$WritingProgressTableTableTableManager(
      _$AppDatabase db, $WritingProgressTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WritingProgressTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WritingProgressTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WritingProgressTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> unitId = const Value.absent(),
            Value<DateTime> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WritingProgressTableCompanion(
            unitId: unitId,
            completedAt: completedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String unitId,
            Value<DateTime> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WritingProgressTableCompanion.insert(
            unitId: unitId,
            completedAt: completedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WritingProgressTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $WritingProgressTableTable,
        WritingProgressTableData,
        $$WritingProgressTableTableFilterComposer,
        $$WritingProgressTableTableOrderingComposer,
        $$WritingProgressTableTableAnnotationComposer,
        $$WritingProgressTableTableCreateCompanionBuilder,
        $$WritingProgressTableTableUpdateCompanionBuilder,
        (
          WritingProgressTableData,
          BaseReferences<_$AppDatabase, $WritingProgressTableTable,
              WritingProgressTableData>
        ),
        WritingProgressTableData,
        PrefetchHooks Function()>;
typedef $$VocabReviewTableTableCreateCompanionBuilder
    = VocabReviewTableCompanion Function({
  required String groupId,
  required String word,
  Value<int> box,
  Value<int> dueAt,
  Value<int> seen,
  Value<int> correct,
  Value<int> rowid,
});
typedef $$VocabReviewTableTableUpdateCompanionBuilder
    = VocabReviewTableCompanion Function({
  Value<String> groupId,
  Value<String> word,
  Value<int> box,
  Value<int> dueAt,
  Value<int> seen,
  Value<int> correct,
  Value<int> rowid,
});

class $$VocabReviewTableTableFilterComposer
    extends Composer<_$AppDatabase, $VocabReviewTableTable> {
  $$VocabReviewTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get box => $composableBuilder(
      column: $table.box, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dueAt => $composableBuilder(
      column: $table.dueAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get seen => $composableBuilder(
      column: $table.seen, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get correct => $composableBuilder(
      column: $table.correct, builder: (column) => ColumnFilters(column));
}

class $$VocabReviewTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabReviewTableTable> {
  $$VocabReviewTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get box => $composableBuilder(
      column: $table.box, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dueAt => $composableBuilder(
      column: $table.dueAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get seen => $composableBuilder(
      column: $table.seen, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get correct => $composableBuilder(
      column: $table.correct, builder: (column) => ColumnOrderings(column));
}

class $$VocabReviewTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabReviewTableTable> {
  $$VocabReviewTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<int> get box =>
      $composableBuilder(column: $table.box, builder: (column) => column);

  GeneratedColumn<int> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<int> get seen =>
      $composableBuilder(column: $table.seen, builder: (column) => column);

  GeneratedColumn<int> get correct =>
      $composableBuilder(column: $table.correct, builder: (column) => column);
}

class $$VocabReviewTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VocabReviewTableTable,
    VocabReviewTableData,
    $$VocabReviewTableTableFilterComposer,
    $$VocabReviewTableTableOrderingComposer,
    $$VocabReviewTableTableAnnotationComposer,
    $$VocabReviewTableTableCreateCompanionBuilder,
    $$VocabReviewTableTableUpdateCompanionBuilder,
    (
      VocabReviewTableData,
      BaseReferences<_$AppDatabase, $VocabReviewTableTable,
          VocabReviewTableData>
    ),
    VocabReviewTableData,
    PrefetchHooks Function()> {
  $$VocabReviewTableTableTableManager(
      _$AppDatabase db, $VocabReviewTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabReviewTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabReviewTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabReviewTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> groupId = const Value.absent(),
            Value<String> word = const Value.absent(),
            Value<int> box = const Value.absent(),
            Value<int> dueAt = const Value.absent(),
            Value<int> seen = const Value.absent(),
            Value<int> correct = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VocabReviewTableCompanion(
            groupId: groupId,
            word: word,
            box: box,
            dueAt: dueAt,
            seen: seen,
            correct: correct,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String groupId,
            required String word,
            Value<int> box = const Value.absent(),
            Value<int> dueAt = const Value.absent(),
            Value<int> seen = const Value.absent(),
            Value<int> correct = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VocabReviewTableCompanion.insert(
            groupId: groupId,
            word: word,
            box: box,
            dueAt: dueAt,
            seen: seen,
            correct: correct,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VocabReviewTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VocabReviewTableTable,
    VocabReviewTableData,
    $$VocabReviewTableTableFilterComposer,
    $$VocabReviewTableTableOrderingComposer,
    $$VocabReviewTableTableAnnotationComposer,
    $$VocabReviewTableTableCreateCompanionBuilder,
    $$VocabReviewTableTableUpdateCompanionBuilder,
    (
      VocabReviewTableData,
      BaseReferences<_$AppDatabase, $VocabReviewTableTable,
          VocabReviewTableData>
    ),
    VocabReviewTableData,
    PrefetchHooks Function()>;
typedef $$SymSessionTableTableCreateCompanionBuilder = SymSessionTableCompanion
    Function({
  Value<int> id,
  required String topicId,
  required String finalText,
  Value<String?> naturalVersion,
  Value<int?> score,
  Value<String?> band,
  Value<int> versions,
  Value<String?> recordingPath,
  Value<String?> recordingName,
  Value<int> tokens,
  Value<String?> versionsJson,
  Value<DateTime> createdAt,
});
typedef $$SymSessionTableTableUpdateCompanionBuilder = SymSessionTableCompanion
    Function({
  Value<int> id,
  Value<String> topicId,
  Value<String> finalText,
  Value<String?> naturalVersion,
  Value<int?> score,
  Value<String?> band,
  Value<int> versions,
  Value<String?> recordingPath,
  Value<String?> recordingName,
  Value<int> tokens,
  Value<String?> versionsJson,
  Value<DateTime> createdAt,
});

class $$SymSessionTableTableFilterComposer
    extends Composer<_$AppDatabase, $SymSessionTableTable> {
  $$SymSessionTableTableFilterComposer({
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

  ColumnFilters<String> get finalText => $composableBuilder(
      column: $table.finalText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get naturalVersion => $composableBuilder(
      column: $table.naturalVersion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get band => $composableBuilder(
      column: $table.band, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get versions => $composableBuilder(
      column: $table.versions, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recordingPath => $composableBuilder(
      column: $table.recordingPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recordingName => $composableBuilder(
      column: $table.recordingName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tokens => $composableBuilder(
      column: $table.tokens, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get versionsJson => $composableBuilder(
      column: $table.versionsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SymSessionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SymSessionTableTable> {
  $$SymSessionTableTableOrderingComposer({
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

  ColumnOrderings<String> get finalText => $composableBuilder(
      column: $table.finalText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get naturalVersion => $composableBuilder(
      column: $table.naturalVersion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get band => $composableBuilder(
      column: $table.band, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get versions => $composableBuilder(
      column: $table.versions, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recordingPath => $composableBuilder(
      column: $table.recordingPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recordingName => $composableBuilder(
      column: $table.recordingName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tokens => $composableBuilder(
      column: $table.tokens, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get versionsJson => $composableBuilder(
      column: $table.versionsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SymSessionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymSessionTableTable> {
  $$SymSessionTableTableAnnotationComposer({
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

  GeneratedColumn<String> get finalText =>
      $composableBuilder(column: $table.finalText, builder: (column) => column);

  GeneratedColumn<String> get naturalVersion => $composableBuilder(
      column: $table.naturalVersion, builder: (column) => column);

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get band =>
      $composableBuilder(column: $table.band, builder: (column) => column);

  GeneratedColumn<int> get versions =>
      $composableBuilder(column: $table.versions, builder: (column) => column);

  GeneratedColumn<String> get recordingPath => $composableBuilder(
      column: $table.recordingPath, builder: (column) => column);

  GeneratedColumn<String> get recordingName => $composableBuilder(
      column: $table.recordingName, builder: (column) => column);

  GeneratedColumn<int> get tokens =>
      $composableBuilder(column: $table.tokens, builder: (column) => column);

  GeneratedColumn<String> get versionsJson => $composableBuilder(
      column: $table.versionsJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SymSessionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SymSessionTableTable,
    SymSessionTableData,
    $$SymSessionTableTableFilterComposer,
    $$SymSessionTableTableOrderingComposer,
    $$SymSessionTableTableAnnotationComposer,
    $$SymSessionTableTableCreateCompanionBuilder,
    $$SymSessionTableTableUpdateCompanionBuilder,
    (
      SymSessionTableData,
      BaseReferences<_$AppDatabase, $SymSessionTableTable, SymSessionTableData>
    ),
    SymSessionTableData,
    PrefetchHooks Function()> {
  $$SymSessionTableTableTableManager(
      _$AppDatabase db, $SymSessionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymSessionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymSessionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymSessionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> topicId = const Value.absent(),
            Value<String> finalText = const Value.absent(),
            Value<String?> naturalVersion = const Value.absent(),
            Value<int?> score = const Value.absent(),
            Value<String?> band = const Value.absent(),
            Value<int> versions = const Value.absent(),
            Value<String?> recordingPath = const Value.absent(),
            Value<String?> recordingName = const Value.absent(),
            Value<int> tokens = const Value.absent(),
            Value<String?> versionsJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SymSessionTableCompanion(
            id: id,
            topicId: topicId,
            finalText: finalText,
            naturalVersion: naturalVersion,
            score: score,
            band: band,
            versions: versions,
            recordingPath: recordingPath,
            recordingName: recordingName,
            tokens: tokens,
            versionsJson: versionsJson,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String topicId,
            required String finalText,
            Value<String?> naturalVersion = const Value.absent(),
            Value<int?> score = const Value.absent(),
            Value<String?> band = const Value.absent(),
            Value<int> versions = const Value.absent(),
            Value<String?> recordingPath = const Value.absent(),
            Value<String?> recordingName = const Value.absent(),
            Value<int> tokens = const Value.absent(),
            Value<String?> versionsJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SymSessionTableCompanion.insert(
            id: id,
            topicId: topicId,
            finalText: finalText,
            naturalVersion: naturalVersion,
            score: score,
            band: band,
            versions: versions,
            recordingPath: recordingPath,
            recordingName: recordingName,
            tokens: tokens,
            versionsJson: versionsJson,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SymSessionTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SymSessionTableTable,
    SymSessionTableData,
    $$SymSessionTableTableFilterComposer,
    $$SymSessionTableTableOrderingComposer,
    $$SymSessionTableTableAnnotationComposer,
    $$SymSessionTableTableCreateCompanionBuilder,
    $$SymSessionTableTableUpdateCompanionBuilder,
    (
      SymSessionTableData,
      BaseReferences<_$AppDatabase, $SymSessionTableTable, SymSessionTableData>
    ),
    SymSessionTableData,
    PrefetchHooks Function()>;
typedef $$ChallengeMarkTableTableCreateCompanionBuilder
    = ChallengeMarkTableCompanion Function({
  required String youtubeId,
  required int sentenceIndex,
  Value<int> positionMs,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$ChallengeMarkTableTableUpdateCompanionBuilder
    = ChallengeMarkTableCompanion Function({
  Value<String> youtubeId,
  Value<int> sentenceIndex,
  Value<int> positionMs,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$ChallengeMarkTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChallengeMarkTableTable> {
  $$ChallengeMarkTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get youtubeId => $composableBuilder(
      column: $table.youtubeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sentenceIndex => $composableBuilder(
      column: $table.sentenceIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get positionMs => $composableBuilder(
      column: $table.positionMs, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$ChallengeMarkTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChallengeMarkTableTable> {
  $$ChallengeMarkTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get youtubeId => $composableBuilder(
      column: $table.youtubeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sentenceIndex => $composableBuilder(
      column: $table.sentenceIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get positionMs => $composableBuilder(
      column: $table.positionMs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$ChallengeMarkTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChallengeMarkTableTable> {
  $$ChallengeMarkTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get youtubeId =>
      $composableBuilder(column: $table.youtubeId, builder: (column) => column);

  GeneratedColumn<int> get sentenceIndex => $composableBuilder(
      column: $table.sentenceIndex, builder: (column) => column);

  GeneratedColumn<int> get positionMs => $composableBuilder(
      column: $table.positionMs, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ChallengeMarkTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChallengeMarkTableTable,
    ChallengeMarkTableData,
    $$ChallengeMarkTableTableFilterComposer,
    $$ChallengeMarkTableTableOrderingComposer,
    $$ChallengeMarkTableTableAnnotationComposer,
    $$ChallengeMarkTableTableCreateCompanionBuilder,
    $$ChallengeMarkTableTableUpdateCompanionBuilder,
    (
      ChallengeMarkTableData,
      BaseReferences<_$AppDatabase, $ChallengeMarkTableTable,
          ChallengeMarkTableData>
    ),
    ChallengeMarkTableData,
    PrefetchHooks Function()> {
  $$ChallengeMarkTableTableTableManager(
      _$AppDatabase db, $ChallengeMarkTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChallengeMarkTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChallengeMarkTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChallengeMarkTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> youtubeId = const Value.absent(),
            Value<int> sentenceIndex = const Value.absent(),
            Value<int> positionMs = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChallengeMarkTableCompanion(
            youtubeId: youtubeId,
            sentenceIndex: sentenceIndex,
            positionMs: positionMs,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String youtubeId,
            required int sentenceIndex,
            Value<int> positionMs = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChallengeMarkTableCompanion.insert(
            youtubeId: youtubeId,
            sentenceIndex: sentenceIndex,
            positionMs: positionMs,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChallengeMarkTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChallengeMarkTableTable,
    ChallengeMarkTableData,
    $$ChallengeMarkTableTableFilterComposer,
    $$ChallengeMarkTableTableOrderingComposer,
    $$ChallengeMarkTableTableAnnotationComposer,
    $$ChallengeMarkTableTableCreateCompanionBuilder,
    $$ChallengeMarkTableTableUpdateCompanionBuilder,
    (
      ChallengeMarkTableData,
      BaseReferences<_$AppDatabase, $ChallengeMarkTableTable,
          ChallengeMarkTableData>
    ),
    ChallengeMarkTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ListeningPracticeAnswerTableTableTableManager
      get listeningPracticeAnswerTable =>
          $$ListeningPracticeAnswerTableTableTableManager(
              _db, _db.listeningPracticeAnswerTable);
  $$UserRecordedSentenceAudioTableTableTableManager
      get userRecordedSentenceAudioTable =>
          $$UserRecordedSentenceAudioTableTableTableManager(
              _db, _db.userRecordedSentenceAudioTable);
  $$SavedTermTableTableTableManager get savedTermTable =>
      $$SavedTermTableTableTableManager(_db, _db.savedTermTable);
  $$VideoStepProgressTableTableTableManager get videoStepProgressTable =>
      $$VideoStepProgressTableTableTableManager(
          _db, _db.videoStepProgressTable);
  $$WritingProgressTableTableTableManager get writingProgressTable =>
      $$WritingProgressTableTableTableManager(_db, _db.writingProgressTable);
  $$VocabReviewTableTableTableManager get vocabReviewTable =>
      $$VocabReviewTableTableTableManager(_db, _db.vocabReviewTable);
  $$SymSessionTableTableTableManager get symSessionTable =>
      $$SymSessionTableTableTableManager(_db, _db.symSessionTable);
  $$ChallengeMarkTableTableTableManager get challengeMarkTable =>
      $$ChallengeMarkTableTableTableManager(_db, _db.challengeMarkTable);
}
