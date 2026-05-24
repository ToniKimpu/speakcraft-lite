import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/model/subtitle/subtitle.dart';
import 'package:speakcraft/services/supabase_service.dart';

part 'subtitle_parsing_bloc.freezed.dart';

@freezed
abstract class SubtitleParsingEvent with _$SubtitleParsingEvent {
  const factory SubtitleParsingEvent.parse(Listening listening) = _Parse;
}

@freezed
abstract class SubtitleParsingState with _$SubtitleParsingState {
  const factory SubtitleParsingState.initial() = _Initial;
  const factory SubtitleParsingState.loading() = _Loading;
  const factory SubtitleParsingState.loaded(List<Subtitle> subtitles) = _Loaded;
  const factory SubtitleParsingState.error(String message) = _Error;
}

class SubtitleParsingBloc
    extends Bloc<SubtitleParsingEvent, SubtitleParsingState> {
  SubtitleParsingBloc() : super(const SubtitleParsingState.initial()) {
    on<SubtitleParsingEvent>((event, emit) async {
      await event.when(
        parse: (listening) => _parse(listening, emit),
      );
    });
  }

  Future<void> _parse(
      Listening listening, Emitter<SubtitleParsingState> emit) async {
    emit(const SubtitleParsingState.loading());
    try {
      final response = await http.get(Uri.parse(listening.subtitlePath));
      if (response.statusCode != 200) {
        throw Exception("Failed to load subtitles: ${response.statusCode}");
      }
      final List<dynamic> jsonList =
          json.decode(utf8.decode(response.bodyBytes));
      final List<Subtitle> subtitles = [];

      for (int i = 0; i < jsonList.length; i++) {
        final jsonItem = jsonList[i];
        final num startRaw = jsonItem['start'] as num;
        final num endRaw = i == jsonList.length - 1
            ? listening.end
            : jsonList[i + 1]['start'] as num;

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
            start: _numToDuration(startRaw),
            end: _numToDuration(endRaw),
            widgetHeight: 0.0,
            scrollPosition: 0.0,
            explanationUrl: jsonItem['explanation_url'] ?? "",
            vocabularies: (jsonItem['vocabulary'] as List<dynamic>?)
                ?.map((v) => SubtitleVocabulary.fromJson(v))
                .toList(),
          ),
        );
      }
      emit(SubtitleParsingState.loaded(subtitles));
    } catch (e, st) {
      AppLogger.instance.error(
          "SubtitleParsingBloc: failed to parse subtitle JSON: $e",
          error: e,
          stackTrace: st);
      emit(SubtitleParsingState.error(e.toString()));
    }
  }

  Duration _numToDuration(num value) =>
      Duration(microseconds: (value * 1000000).round());
}
