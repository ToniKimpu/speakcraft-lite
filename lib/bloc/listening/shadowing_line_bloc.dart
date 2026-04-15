import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/screens/listening_and_shadowing/model/subtitle_line.dart';

part 'shadowing_line_bloc.freezed.dart';

@freezed
abstract class ShadowingLineEvent with _$ShadowingLineEvent {
  const factory ShadowingLineEvent.parse(String url) = _Parse;
}

@freezed
abstract class ShadowingLineState with _$ShadowingLineState {
  const factory ShadowingLineState.initial() = _Initial;
  const factory ShadowingLineState.loading() = _Loading;
  const factory ShadowingLineState.loaded(List<SubtitleLine> lines) = _Loaded;
  const factory ShadowingLineState.error(String message) = _Error;
}

class ShadowingLineBloc extends Bloc<ShadowingLineEvent, ShadowingLineState> {
  ShadowingLineBloc() : super(const ShadowingLineState.initial()) {
    on<ShadowingLineEvent>((event, emit) async {
      await event.when(
        parse: (url) => _parse(url, emit),
      );
    });
  }

  Future<void> _parse(String url, Emitter<ShadowingLineState> emit) async {
    emit(const ShadowingLineState.loading());
    try {
      if (url.isEmpty) {
        throw Exception("No shadowing path provided.");
      }
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception("Failed to load shadowing file: ${response.statusCode}");
      }
      final List<dynamic> jsonList = json.decode(response.body);
      final lines = <SubtitleLine>[];
      for (int i = 0; i < jsonList.length; i++) {
        lines.add(SubtitleLine.fromJson(jsonList[i]));
      }
      emit(ShadowingLineState.loaded(lines));
    } catch (e, st) {
      AppLogger.instance
          .error("ShadowingLineBloc: $e", error: e, stackTrace: st);
      emit(ShadowingLineState.error(e.toString()));
    }
  }
}
