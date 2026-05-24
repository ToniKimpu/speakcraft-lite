import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/model/record_subtitle/record_subtitle.dart';

part 'record_subtitle_bloc.freezed.dart';

@freezed
abstract class RecordSubtitleEvent with _$RecordSubtitleEvent {
  const factory RecordSubtitleEvent.parse(Listening listening) = _Parse;
}

@freezed
abstract class RecordSubtitleState with _$RecordSubtitleState {
  const factory RecordSubtitleState.initial() = _Initial;
  const factory RecordSubtitleState.loading() = _Loading;
  const factory RecordSubtitleState.loaded(List<RecordSubtitle> recordSubtitles) =
      _Loaded;
  const factory RecordSubtitleState.error(String message) = _Error;
}

class RecordSubtitleBloc
    extends Bloc<RecordSubtitleEvent, RecordSubtitleState> {
  RecordSubtitleBloc() : super(const RecordSubtitleState.initial()) {
    on<RecordSubtitleEvent>((event, emit) async {
      await event.when(
        parse: (listening) => _parse(listening, emit),
      );
    });
  }

  Future<void> _parse(
      Listening listening, Emitter<RecordSubtitleState> emit) async {
    emit(const RecordSubtitleState.loading());
    try {
      if (listening.recordSubtitlePath.isEmpty) {
        emit(const RecordSubtitleState.loaded(<RecordSubtitle>[]));
        return;
      }

      final response = await http.get(Uri.parse(listening.recordSubtitlePath));
      if (response.statusCode != 200) {
        throw Exception(
            "Failed to load record subtitles: ${response.statusCode}");
      }

      final bodyString = utf8.decode(response.bodyBytes).trim();
      if (bodyString.isEmpty) {
        emit(const RecordSubtitleState.loaded(<RecordSubtitle>[]));
        return;
      }

      final decoded = json.decode(bodyString);
      if (decoded is! List) {
        throw Exception("Invalid record subtitle format: expected list");
      }
      if (decoded.isEmpty) {
        emit(const RecordSubtitleState.loaded(<RecordSubtitle>[]));
        return;
      }

      final recordSubtitles = decoded
          .map((e) => RecordSubtitle.fromJson(e as Map<String, dynamic>))
          .toList();
      emit(RecordSubtitleState.loaded(recordSubtitles));
    } catch (e, st) {
      AppLogger.instance.error("RecordSubtitleBloc: $e",
          error: e, stackTrace: st);
      emit(RecordSubtitleState.error(e.toString()));
    }
  }
}
