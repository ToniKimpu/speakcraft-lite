import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/model/daily_speaking/topic_progress.dart';
import 'package:speakcraft/repositories/daily_speaking/topic_progress_repository.dart';
import 'package:speakcraft/services/share_preference_utils.dart';
import 'package:speakcraft/services/supabase_service.dart';

part 'daily_speaking_topic_bloc.freezed.dart';

/// Loads the curated topic bank for the suggested-topic on-ramp (P3) from
/// Supabase, plus the learner's per-topic progress (for the fresh-first /
/// practiced-sunk list ordering).
///
/// Topics live in the `daily_speaking_topics` table (rich content as JSONB;
/// see `SUGGESTED_TOPICS_SUPABASE_PLAN.md`). The bundled
/// `assets/daily_speaking/topics/topics.json` stays as an **offline fallback**
/// (used when the network/table is unavailable), and the last successful fetch
/// is cached in SharedPreferences so a returning learner gets an instant list.
@freezed
class DailySpeakingTopicEvent with _$DailySpeakingTopicEvent {
  const factory DailySpeakingTopicEvent.load() = _Load;
}

@freezed
class DailySpeakingTopicState with _$DailySpeakingTopicState {
  const factory DailySpeakingTopicState.initial() = _Initial;
  const factory DailySpeakingTopicState.loading() = _Loading;
  const factory DailySpeakingTopicState.loaded(
    List<DailySpeakingTopic> topics,
    Map<String, TopicProgress> progress,
  ) = _Loaded;
  const factory DailySpeakingTopicState.error(String message) = _Error;
}

class DailySpeakingTopicBloc
    extends Bloc<DailySpeakingTopicEvent, DailySpeakingTopicState> {
  DailySpeakingTopicBloc({TopicProgressRepository? progressRepository})
      : _progressRepository =
            progressRepository ?? LocalTopicProgressRepository(),
        super(const DailySpeakingTopicState.initial()) {
    on<DailySpeakingTopicEvent>((event, emit) async {
      await event.when(
        load: () => _load(emit),
      );
    });
  }

  final TopicProgressRepository _progressRepository;

  static const _assetPath = 'assets/daily_speaking/topics/topics.json';
  static const _cacheKey = 'ds_topics_cache_json';

  Future<void> _load(Emitter<DailySpeakingTopicState> emit) async {
    try {
      emit(const DailySpeakingTopicState.loading());
      final topics = await _loadTopics();
      // Progress is best-effort: a failure here shouldn't blank the list.
      Map<String, TopicProgress> progress = const {};
      try {
        progress = await _progressRepository.loadProgress();
      } catch (e) {
        AppLogger.instance
            .error('DailySpeakingTopicBloc progress error: $e', error: e);
      }
      emit(DailySpeakingTopicState.loaded(topics, progress));
    } catch (e) {
      AppLogger.instance.error(
        'DailySpeakingTopicBloc load error: $e',
        error: e,
      );
      emit(DailySpeakingTopicState.error(e.toString()));
    }
  }

  /// Network-first with graceful degradation: Supabase → last cached fetch →
  /// bundled asset. The asset is the final guarantee so the screen always has
  /// content, even offline or before the table is seeded.
  Future<List<DailySpeakingTopic>> _loadTopics() async {
    try {
      final rows = await supabase
          .from('daily_speaking_topics')
          .select()
          .eq('is_published', true)
          .order('sort_order', ascending: true)
          .order('created_at', ascending: false);
      final list = rows
          .map((e) => DailySpeakingTopic.fromJson(Map<String, dynamic>.from(e)))
          .toList(growable: false);
      // Cache only a non-empty fetch — an empty table shouldn't clobber a good
      // cache or hide the asset fallback.
      if (list.isNotEmpty) {
        await SharedPreferenceUtils.saveString(_cacheKey, jsonEncode(rows));
        return list;
      }
      return _fromCacheOrAssets();
    } catch (e) {
      AppLogger.instance.error(
        'DailySpeakingTopicBloc Supabase fetch failed, falling back: $e',
        error: e,
      );
      return _fromCacheOrAssets();
    }
  }

  Future<List<DailySpeakingTopic>> _fromCacheOrAssets() async {
    final cached = SharedPreferenceUtils.getString(_cacheKey);
    if (cached != null && cached.isNotEmpty) {
      try {
        final decoded = jsonDecode(cached);
        if (decoded is List && decoded.isNotEmpty) {
          return decoded
              .map((e) =>
                  DailySpeakingTopic.fromJson(Map<String, dynamic>.from(e)))
              .toList(growable: false);
        }
      } catch (_) {
        // Corrupt cache — fall through to the bundled asset.
      }
    }
    return _loadFromAssets();
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
