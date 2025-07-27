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
    return AiSentencePractice(
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AiSentencePracticeTableTable aiSentencePracticeTable =
      $AiSentencePracticeTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [aiSentencePracticeTable];
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AiSentencePracticeTableTableTableManager get aiSentencePracticeTable =>
      $$AiSentencePracticeTableTableTableManager(
          _db, _db.aiSentencePracticeTable);
}
