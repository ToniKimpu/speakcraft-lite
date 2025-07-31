import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subtitle_detail_bloc.freezed.dart';

@freezed
abstract class SubtitleDetailEvent with _$SubtitleDetailEvent {
  const factory SubtitleDetailEvent.setCurrentPageIndex(int index) =
      _SetCurrentPageIndex;
}

@freezed
abstract class SubtitleState with _$SubtitleState {
  const factory SubtitleState.initial() = _Initial;
  const factory SubtitleState.loading({String? message}) = _Loading;
  const factory SubtitleState.onPageChanged(int index) = OnPageChanged;
  const factory SubtitleState.error(String message) = _Error;
}

class SubtitleBloc extends Bloc<SubtitleDetailEvent, SubtitleState> {
  SubtitleBloc() : super(const SubtitleState.initial()) {
    on<SubtitleDetailEvent>((event, emit) {
      event.when(
        setCurrentPageIndex: (index) =>
            emit(SubtitleState.onPageChanged(index)),
      );
    });
  }
}
