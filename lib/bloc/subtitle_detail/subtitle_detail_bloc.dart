import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:pmp_english/model/listening/listening.dart';
import 'package:pmp_english/model/listening_question/listening_question.dart';
import 'package:pmp_english/screens/listening_and_shadowing/model/subtitle_line.dart';

import '../../model/listening_practice_answer/listening_practice_answer.dart';
import '../../model/record_subtitle/record_subtitle.dart';
import '../../model/subtitle/subtitle.dart';
import '../../services/app_database/app_database.dart';
import '../../services/supabase_service.dart';

part 'subtitle_detail_bloc.freezed.dart';

@freezed
abstract class SubtitleEvent with _$SubtitleEvent {
  const factory SubtitleEvent.parseSubtitleLine(String url) =
      _ParseSubtitleLine;
  const factory SubtitleEvent.parseSubtitle(Listening listening) =
      _ParseSubtitle;
  const factory SubtitleEvent.parseRecordSubtitle(Listening listening) =
      _ParseRecordSubtitle;
  const factory SubtitleEvent.parseListeningQuestion(Listening listening) =
      _ParseListeningQuestion;
  const factory SubtitleEvent.parseComplete(List<Subtitle> subtitles) =
      _ParseComplete;
  const factory SubtitleEvent.setCurrentPageIndex(int index) =
      _SetCurrentPageIndex;
}

@freezed
abstract class SubtitleState with _$SubtitleState {
  const factory SubtitleState.initial() = _Initial;
  const factory SubtitleState.loading({String? message}) = _Loading;
  const factory SubtitleState.onParsingSubtitle(List<Subtitle> subtitles) =
      _OnParsingSubtitle;
  const factory SubtitleState.onParseListeningQuestionCompleted(
          List<ListeningQuestion> listeningQuestions,
          List<ListeningPracticeAnswer> userAnswers) =
      _OnParseListeningQuestionCompleted;
  const factory SubtitleState.onParseCompleted(List<Subtitle> subtitles) =
      _OnParseCompleted;
  const factory SubtitleState.onRecordSubtitleCompleted(
      List<RecordSubtitle> recordSubtitles) = _OnRecordSubtitleCompleted;
  const factory SubtitleState.onParseSubtitleLineCompleted(
      List<SubtitleLine> subtitleLines) = _OnParseSubtitleLineCompleted;
  const factory SubtitleState.onPageChanged(int index) = OnPageChanged;
  const factory SubtitleState.error(String message) = _Error;
}

class SubtitleBloc extends Bloc<SubtitleEvent, SubtitleState> {
  SubtitleBloc() : super(const SubtitleState.initial()) {
    on<SubtitleEvent>((event, emit) async {
      await event.when(
        setCurrentPageIndex: (index) async {
          emit(SubtitleState.onPageChanged(index));
        },
        parseRecordSubtitle: (listening) async {
          await parseRecordSubtitle(listening, emit);
        },
        parseListeningQuestion: (listening) async {
          await _mapParseListeningQuestionsToState(listening, emit);
        },
        parseSubtitleLine: (url) async {
          await _mapParseSubtitleLineToState(url, emit);
        },
        parseSubtitle: (listening) async {
          await parseSubtitle(listening, emit);
        },
        parseComplete: (subtitles) async {
          debugPrint(
              "_subtitleDetailparseInfo: ${subtitles.length} length from Bloc");
          emit(SubtitleState.onParseCompleted(subtitles));
        },
      );
    });
  }

  Future<void> _mapParseListeningQuestionsToState(
      Listening listening, Emitter<SubtitleState> emit) async {
    try {
      emit(const SubtitleState.loading());
      final jsonString =
          await rootBundle.loadString("assets/subtitles/grit_questions.json");
      final List<dynamic> jsonList = json.decode(jsonString);

      final db = AppDatabase.instance();
      final List<ListeningPracticeAnswer> userAnswers =
          await (db.listeningPracticeAnswerTable.select()
                ..where((tbl) => tbl.youtubeId.equals(listening.youtubeId)))
              .get();

      final listeningQuestions = await Future.wait(
        jsonList.map((e) async {
          final question = ListeningQuestion.fromJson(e);
          // Shuffle answers
          final shuffledAnswers = List<AnswerOption>.from(question.answers)
            ..shuffle();
          return question.copyWith(
            answers: shuffledAnswers,
          );
        }),
      );
      emit(
        SubtitleState.onParseListeningQuestionCompleted(
          listeningQuestions,
          userAnswers,
        ),
      );
    } catch (e) {
      debugPrint("_mapParseSubtitleLineToState: ${e.toString()}");
    }
  }

  Future<void> _mapParseSubtitleLineToState(
    String url,
    Emitter<SubtitleState> emit,
  ) async {
    try {
      emit(const SubtitleState.loading());

      // Make sure shadowingPath is not null or empty
      if (url.isEmpty) {
        throw Exception("No shadowing path provided.");
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        debugPrint(
            "_mapParseSubtitleLineToState: ${jsonList.first.toString()}");
        final subtitleLines =
            jsonList.map((e) => SubtitleLine.fromJson(e)).toList();

        emit(SubtitleState.onParseSubtitleLineCompleted(subtitleLines));
      } else {
        throw Exception("Failed to load subtitle file: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("_mapParseSubtitleLineToState: ${e.toString()}");
      // Optionally emit an error state if you have one
      // emit(SubtitleState.error(e.toString()));
    }
  }

  Future<void> parseSubtitle(
      Listening listening, Emitter<SubtitleState> emit) async {
    // const double fixedHeight = 112.0;
    // double scrollPosition = 0;
    debugPrint("_parseJsonSubtitleFile: ${listening.toJson()} file Url!");
    // emit(const SubtitleState.onParsingSubtitle(<Subtitle>[]));
    emit(const SubtitleState.loading());
    try {
      final response = await http.get(Uri.parse(listening.subtitlePath));
      if (response.statusCode != 200) {
        throw Exception("Failed to load subtitles: ${response.statusCode}");
      }
      final List<dynamic> jsonList =
          json.decode(utf8.decode(response.bodyBytes));
      debugPrint(
          "_parseJsonSubtitleFile: ${jsonList.first.toString()} lenght!");
      final List<Subtitle> subtitles = [];

      for (int i = 0; i < jsonList.length; i++) {
        final jsonItem = jsonList[i];
        int start = jsonItem['start'] as int;
        int end = i == jsonList.length - 1
            ? listening.end
            : jsonList[i + 1]['start'] as int;
        final startDuration = Duration(seconds: start);
        final endDuration = Duration(seconds: end);

        subtitles.add(
          Subtitle(
            id: jsonItem['id'],
            english: jsonItem['english'] ?? '',
            burmese: jsonItem['burmese'],
            description: jsonItem['description'],
            audioName: jsonItem["audioName"] == null
                ? ""
                : supabase.storage.from("contents").getPublicUrl(
                      "${SupabaseBucketFolders.listeningAndShadowingAudios.name}/${jsonItem["audioName"] as String}",
                    ),
            start: startDuration,
            end: endDuration,
            widgetHeight: 0.0,
            scrollPosition: 0.0,
            vocabularies: (jsonItem['vocabulary'] as List<dynamic>?)
                ?.map((vocabJson) => SubtitleVocabulary.fromJson(vocabJson))
                .toList(),
          ),
        );
        // if (i >= 1) {
        //   scrollPosition += fixedHeight;
        // }
      }
      emit(SubtitleState.onParseCompleted(subtitles));
    } catch (e) {
      debugPrint(
          "_parseJsonSubtitleFile: error:  Error parsing subtitle JSON file: $e");
      emit(SubtitleState.error(e.toString()));
    }
  }

  Future<void> parseRecordSubtitle(
    Listening listening,
    Emitter<SubtitleState> emit,
  ) async {
    debugPrint("_parseJsonSubtitleFile: ${listening.recordSubtitlePath}");
    emit(const SubtitleState.loading());

    try {
      final response = await http.get(Uri.parse(listening.recordSubtitlePath));
      if (response.statusCode != 200) {
        throw Exception(
          "Failed to load subtitles: ${response.statusCode}",
        );
      }

      final List<dynamic> jsonList =
          json.decode(utf8.decode(response.bodyBytes));

      final List<RecordSubtitle> recordSubtitles = [];

      debugPrint(
          "_parseJsonSubtitleFile: ${jsonList.first.toString()} lenght!");

      for (int i = 0; i < jsonList.length; i++) {
        final Map<String, dynamic> recordJson =
            jsonList[i] as Map<String, dynamic>;
        final record = RecordSubtitle.fromJson(recordJson);
        recordSubtitles.add(record);
      }
      emit(SubtitleState.onRecordSubtitleCompleted(recordSubtitles));
    } catch (e, stack) {
      debugPrint(
        "_parseJsonSubtitleFile error: $e\n$stack",
      );
      emit(SubtitleState.error(e.toString()));
    }
  }

}
