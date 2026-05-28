import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';

part 'daily_speaking_topic_bloc.freezed.dart';

/// Loads the curated topic bank for the suggested-topic on-ramp (P3).
///
/// Currently bundled as an asset (`assets/daily_speaking/topics/topics.json`).
/// When the bank grows past ~50 entries, swap [_loadFromAssets] for a fetch
/// from Bunny CDN — the rest of the BLoC and the topic model don't change.
@freezed
class DailySpeakingTopicEvent with _$DailySpeakingTopicEvent {
  const factory DailySpeakingTopicEvent.load() = _Load;
}

@freezed
class DailySpeakingTopicState with _$DailySpeakingTopicState {
  const factory DailySpeakingTopicState.initial() = _Initial;
  const factory DailySpeakingTopicState.loading() = _Loading;
  const factory DailySpeakingTopicState.loaded(List<DailySpeakingTopic> topics) =
      _Loaded;
  const factory DailySpeakingTopicState.error(String message) = _Error;
}

class DailySpeakingTopicBloc
    extends Bloc<DailySpeakingTopicEvent, DailySpeakingTopicState> {
  DailySpeakingTopicBloc() : super(const DailySpeakingTopicState.initial()) {
    on<DailySpeakingTopicEvent>((event, emit) async {
      await event.when(
        load: () => _load(emit),
      );
    });
  }

  static const _assetPath = 'assets/daily_speaking/topics/topics.json';

  Future<void> _load(Emitter<DailySpeakingTopicState> emit) async {
    try {
      emit(const DailySpeakingTopicState.loading());
      final topics = await _loadFromAssets();
      emit(DailySpeakingTopicState.loaded(topics));
    } catch (e) {
      AppLogger.instance.error(
        'DailySpeakingTopicBloc load error: $e',
        error: e,
      );
      emit(DailySpeakingTopicState.error(e.toString()));
    }
  }

  Future<List<DailySpeakingTopic>> _loadFromAssets() async {
    final raw = await rootBundle.loadString(_assetPath);
    final decoded = jsonDecode(raw);
    if (decoded is! List) {
      throw const FormatException('topics.json: expected a list');
    }
    return decoded
        .map((e) => DailySpeakingTopic.fromJson(Map<String, dynamic>.from(e)))
        .toList(growable: false);
  }
}
