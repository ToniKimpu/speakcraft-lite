import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/guided_lesson.dart';

part 'guided_lesson_bloc.freezed.dart';

/// Loads the beginner "Start here" lessons for the guided on-ramp.
///
/// Prototype: lessons load from the bundled
/// `assets/daily_speaking/guided/guided.json` only. When the Supabase swap
/// lands, add the network-first → SharedPreferences-cache → asset fallback
/// chain (copy it verbatim from `DailySpeakingTopicBloc._loadTopics` /
/// `_fromCacheOrAssets`) — see the `TODO(supabase)` marker in [_loadLessons].
/// The asset stays as the offline/empty-table fallback either way.
@freezed
class GuidedLessonEvent with _$GuidedLessonEvent {
  const factory GuidedLessonEvent.load() = _Load;
}

@freezed
class GuidedLessonState with _$GuidedLessonState {
  const factory GuidedLessonState.initial() = _Initial;
  const factory GuidedLessonState.loading() = _Loading;
  const factory GuidedLessonState.loaded(List<GuidedLesson> lessons) = _Loaded;
  const factory GuidedLessonState.error(String message) = _Error;
}

class GuidedLessonBloc extends Bloc<GuidedLessonEvent, GuidedLessonState> {
  GuidedLessonBloc() : super(const GuidedLessonState.initial()) {
    on<GuidedLessonEvent>((event, emit) async {
      await event.when(load: () => _load(emit));
    });
  }

  static const _assetPath = 'assets/daily_speaking/guided/guided.json';

  Future<void> _load(Emitter<GuidedLessonState> emit) async {
    try {
      emit(const GuidedLessonState.loading());
      final lessons = await _loadLessons();
      emit(GuidedLessonState.loaded(lessons));
    } catch (e) {
      AppLogger.instance.error('GuidedLessonBloc load error: $e', error: e);
      emit(GuidedLessonState.error(e.toString()));
    }
  }

  Future<List<GuidedLesson>> _loadLessons() async {
    // TODO(supabase): network-first from a `daily_speaking_guided` table →
    // SharedPreferences cache → asset fallback, mirroring
    // DailySpeakingTopicBloc._loadTopics. For the prototype, asset-only.
    final lessons = await _loadFromAssets();
    lessons.sort((a, b) {
      final byLevel = a.level.compareTo(b.level);
      if (byLevel != 0) return byLevel;
      return a.sortOrder.compareTo(b.sortOrder);
    });
    return lessons;
  }

  Future<List<GuidedLesson>> _loadFromAssets() async {
    final raw = await rootBundle.loadString(_assetPath);
    final decoded = jsonDecode(raw);
    if (decoded is! List) {
      throw const FormatException('guided.json: expected a list');
    }
    return decoded
        .map((e) => GuidedLesson.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
