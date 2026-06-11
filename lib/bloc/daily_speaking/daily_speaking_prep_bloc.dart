import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/services/daily_speaking/daily_speaking_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'daily_speaking_prep_bloc.freezed.dart';

/// Drives the own-topic AI prep scaffold (P2). One-shot [expand] of the bare
/// typed topic into a filled [DailySpeakingTopic], then a small set of
/// constrained follow-up [askMore] chips that append deltas to the loaded
/// topic. This is NOT a free-form chatbot — each ask is a typed [PrepAskKind].
///
/// Page-scoped (provided by the scaffold route), so the loaded topic is cached
/// for the page's lifetime: navigating into the recorder and back doesn't
/// refetch. (Cross-session Drift caching is out of scope for MVP — see TODO.)
@freezed
class DailySpeakingPrepEvent with _$DailySpeakingPrepEvent {
  const factory DailySpeakingPrepEvent.expand(String topicText) = _Expand;
  const factory DailySpeakingPrepEvent.askMore(PrepAskKind kind) = _AskMore;
  const factory DailySpeakingPrepEvent.reset() = _Reset;
}

@freezed
class DailySpeakingPrepState with _$DailySpeakingPrepState {
  const factory DailySpeakingPrepState.initial() = _Initial;
  const factory DailySpeakingPrepState.loading() = _Loading; // first expand
  const factory DailySpeakingPrepState.loaded(
    DailySpeakingTopic topic, {
    @Default(false) bool asking, // follow-up ask in flight (keep scaffold up)
    @Default(0) int asksUsed, // anti-abuse UX guard, capped at [maxAsks]
  }) = _Loaded;
  const factory DailySpeakingPrepState.error(String message) = _Error;
}

class DailySpeakingPrepBloc
    extends Bloc<DailySpeakingPrepEvent, DailySpeakingPrepState> {
  DailySpeakingPrepBloc({DailySpeakingService? service})
      : _service = service ?? DailySpeakingService(),
        super(const DailySpeakingPrepState.initial()) {
    on<DailySpeakingPrepEvent>((event, emit) async {
      await event.when(
        expand: (topicText) => _expand(topicText, emit),
        askMore: (kind) => _askMore(kind, emit),
        reset: () async => emit(const DailySpeakingPrepState.initial()),
      );
    });
  }

  final DailySpeakingService _service;

  /// Max follow-up asks per topic — a UX guard mirroring the server-side
  /// anti-abuse ceiling (enforced for real once the edge function exists).
  static const int maxAsks = 3;

  Future<void> _expand(
    String topicText,
    Emitter<DailySpeakingPrepState> emit,
  ) async {
    final text = topicText.trim();
    if (text.isEmpty) {
      emit(const DailySpeakingPrepState.error('Please enter a topic first.'));
      return;
    }
    try {
      emit(const DailySpeakingPrepState.loading());
      final topic = await _service.expandTopic(topicText: text);
      emit(DailySpeakingPrepState.loaded(topic));
    } catch (e, st) {
      _handleError(e, st, emit);
    }
  }

  Future<void> _askMore(
    PrepAskKind kind,
    Emitter<DailySpeakingPrepState> emit,
  ) async {
    // Only valid once a topic is loaded; ignore while another ask is in flight
    // or once the cap is reached (the UI disables the chips, this is defense).
    final current = state.mapOrNull(loaded: (s) => s);
    if (current == null || current.asking || current.asksUsed >= maxAsks) {
      return;
    }
    try {
      emit(current.copyWith(asking: true));
      final topic = await _service.askMore(kind: kind, current: current.topic);
      emit(DailySpeakingPrepState.loaded(
        topic,
        asksUsed: current.asksUsed + 1,
      ));
    } catch (e) {
      // A failed ask must not blow away the scaffold the learner already has —
      // drop the spinner, keep the current topic, don't burn the ask.
      AppLogger.instance.error('DailySpeakingPrepBloc ask error: $e', error: e);
      emit(current.copyWith(asking: false));
    }
  }

  void _handleError(
    Object e,
    StackTrace st,
    Emitter<DailySpeakingPrepState> emit,
  ) {
    AppLogger.instance.error('DailySpeakingPrepBloc expand error: $e', error: e);
    if (e is SocketException) {
      emit(const DailySpeakingPrepState.error('No internet connection.'));
    } else if (e is FunctionException) {
      emit(const DailySpeakingPrepState.error('Sorry, the server is busy.'));
    } else {
      emit(const DailySpeakingPrepState.error('Something went wrong.'));
    }
  }
}
