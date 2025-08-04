import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

import '../../model/subtitle/subtitle.dart';
import '../../services/supabase_service.dart';

part 'subtitle_detail_bloc.freezed.dart';

@freezed
abstract class SubtitleEvent with _$SubtitleEvent {
  const factory SubtitleEvent.parseSubtitle(String subtitlePath) =
      _ParseSubtitle;
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
  const factory SubtitleState.onParseCompleted(List<Subtitle> subtitles) =
      _OnParseCompleted;
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
        parseSubtitle: (subtitlePath) async {
          await parseSubtitle(subtitlePath, emit);
        },
        parseComplete: (subtitles) async {
          debugPrint(
              "_subtitleDetailparseInfo: ${subtitles.length} length from Bloc");
          emit(SubtitleState.onParseCompleted(subtitles));
        },
      );
    });
  }
  Future<void> parseSubtitle(
      String fileUrl, Emitter<SubtitleState> emit) async {
    // const double fixedHeight = 112.0;
    // double scrollPosition = 0;
    debugPrint("_parseJsonSubtitleFile: $fileUrl file Url!");
    emit(const SubtitleState.onParsingSubtitle(<Subtitle>[]));
    try {
      final response = await http.get(Uri.parse(fileUrl));
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
        final startDuration = _parseJsonDuration(jsonItem['start']);
        final endDuration = _parseJsonDuration(jsonItem['end']);

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
            // scrollPosition: i < 2 ? 0 : scrollPosition,
            vocabularies: (jsonItem['vocabulary'] as List<dynamic>?)
                ?.map((vocabJson) => SubtitleVocabulary.fromJson(vocabJson))
                .toList(),
          ),
        );

        // if (i >= 1) {
        //   scrollPosition += fixedHeight;
        // }
      }
      emit(SubtitleState.onParsingSubtitle(subtitles));
    } catch (e) {
      debugPrint(
          "_parseJsonSubtitleFile: error:  Error parsing subtitle JSON file: $e");
      emit(SubtitleState.error(e.toString()));
    }
  }

  Duration _parseJsonDuration(String time) {
    final parts = time.split(':'); // [hh, mm, ss.mmm]
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);

    final secParts = parts[2].split('.');
    final seconds = int.parse(secParts[0]);
    final milliseconds =
        int.parse(secParts[1].padRight(3, '0')); // ensure 3 digits

    return Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
  }
}
