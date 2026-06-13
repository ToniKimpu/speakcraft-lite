import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speakcraft/core/logger/app_logger.dart';
import 'package:speakcraft/model/daily_speaking/daily_speaking_topic.dart';
import 'package:speakcraft/model/daily_speaking/prep_section.dart';
import 'package:speakcraft/services/daily_speaking/daily_speaking_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'daily_speaking_prep_bloc.freezed.dart';

/// Drives the own-topic AI prep scaffold (P2). [expand] turns the bare typed
/// topic into a [DailySpeakingTopic] filled for the [PrepSection]s the learner
/// chose on the choose-prep screen; [askMore] pulls one extra section they
/// didn't pick up front. This is NOT a free-form chatbot — every request is a
/// typed [PrepSection].
///
/// Page-scoped (provided by the scaffold route), so the loaded topic is cached
/// for the page's lifetime: navigating into the recorder and back doesn't
/// refetch.
@freezed
class DailySpeakingPrepEvent with _$DailySpeakingPrepEvent {
  const factory DailySpeakingPrepEvent.expand(
    String topicText,
    Set<PrepSection> sections,
  ) = _Expand;
  const factory DailySpeakingPrepEvent.askMore(PrepSection section) = _AskMore;
  const factory DailySpeakingPrepEvent.reset() = _Reset;
}

@freezed
class DailySpeakingPrepState with _$DailySpeakingPrepState {
  const factory DailySpeakingPrepState.initial() = _Initial;
  const factory DailySpeakingPrepState.loading() = _Loading; // first expand
  const factory DailySpeakingPrepState.loaded(
    DailySpeakingTopic topic, {
    @Default(false) bool asking, // an "add more" request is in flight
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
        expand: (topicText, sections) => _expand(topicText, sections, emit),
        askMore: (section) => _askMore(section, emit),
        reset: () async => emit(const DailySpeakingPrepState.initial()),
      );
    });
  }

  final DailySpeakingService _service;

  Future<void> _expand(
    String topicText,
    Set<PrepSection> sections,
    Emitter<DailySpeakingPrepState> emit,
  ) async {
    final text = topicText.trim();
    if (text.isEmpty) {
      emit(const DailySpeakingPrepState.error('Please enter a topic first.'));
      return;
    }
    try {
      emit(const DailySpeakingPrepState.loading());
      final topic = await _service.expandTopic(
        topicText: text,
        sections: sections,
      );
      emit(DailySpeakingPrepState.loaded(topic));
    } catch (e, st) {
      _handleError(e, st, emit);
    }
  }

  Future<void> _askMore(
    PrepSection section,
    Emitter<DailySpeakingPrepState> emit,
  ) async {
    // Only valid once a topic is loaded; ignore while another ask is in flight
    // (the UI also disables the chips, this is defense).
    final current = state.mapOrNull(loaded: (s) => s);
    if (current == null || current.asking) return;
    try {
      emit(current.copyWith(asking: true));
      final topic =
          await _service.askMore(section: section, current: current.topic);
      emit(DailySpeakingPrepState.loaded(topic));
    } catch (e) {
      // A failed ask must not blow away the scaffold the learner already has —
      // drop the spinner, keep the current topic.
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
