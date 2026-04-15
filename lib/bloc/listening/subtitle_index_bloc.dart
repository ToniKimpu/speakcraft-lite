import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subtitle_index_bloc.freezed.dart';

@freezed
abstract class SubtitleIndexEvent with _$SubtitleIndexEvent {
  const factory SubtitleIndexEvent.set(int index) = _Set;
}

@freezed
abstract class SubtitleIndexState with _$SubtitleIndexState {
  const factory SubtitleIndexState.initial() = _Initial;
  const factory SubtitleIndexState.changed(int index) = _Changed;
}

class SubtitleIndexBloc extends Bloc<SubtitleIndexEvent, SubtitleIndexState> {
  SubtitleIndexBloc() : super(const SubtitleIndexState.initial()) {
    on<SubtitleIndexEvent>((event, emit) {
      event.when(
        set: (index) => emit(SubtitleIndexState.changed(index)),
      );
    });
  }
}
