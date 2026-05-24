import 'package:drift/drift.dart' hide JsonKey;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../services/app_database/app_database.dart';


part 'user_example_answer_bloc.freezed.dart';

@freezed
class UserExampleAnswerEvent with _$UserExampleAnswerEvent {
  const factory UserExampleAnswerEvent.load(int exampleId) = _Load;
  const factory UserExampleAnswerEvent.insert(
      int exampleId, String userAnswer) = _Insert;
}

@freezed
class UserExampleAnswerState with _$UserExampleAnswerState {
  const factory UserExampleAnswerState.initial() = _Initial;
  const factory UserExampleAnswerState.loading({String? message}) = _Loading;
  const factory UserExampleAnswerState.loaded(String? userAnswer) = _Loaded;
  const factory UserExampleAnswerState.error(String message) = _Error;
}

class UserExampleAnswerBloc
    extends Bloc<UserExampleAnswerEvent, UserExampleAnswerState> {
  UserExampleAnswerBloc() : super(const UserExampleAnswerState.initial()) {
    on<UserExampleAnswerEvent>((event, emit) async {
      await event.when(
        load: (exampleId) async {
          try {
            emit(const UserExampleAnswerState.loading());
            final data =
                await (AppDatabase.instance().userExampleAnswerTable.select()
                      ..where((tbl) => tbl.exampleId.equals(exampleId)))
                    .getSingleOrNull();
            emit(UserExampleAnswerState.loaded(data?.userAnswer));
          } catch (e) {
            AppLogger.instance.error("_userExampleAnswerLoad: ${e.toString()}", error: e);
            emit(UserExampleAnswerState.error(e.toString()));
          }
        },
        insert: (exampleId, userAnswer) async {
          try {
            emit(const UserExampleAnswerState.loading());
            final data = await AppDatabase.instance()
                .userExampleAnswerTable
                .insertReturning(
                  UserExampleAnswerTableCompanion(
                    exampleId: Value(exampleId),
                    userAnswer: Value(userAnswer),
                  ),
                );
            emit(UserExampleAnswerState.loaded(data.userAnswer));
          } catch (e) {
            AppLogger.instance.error("_userExampleAnswerInsert: ${e.toString()}", error: e);
            emit(UserExampleAnswerState.error(e.toString()));
          }
        },
      );
    });
  }
}
