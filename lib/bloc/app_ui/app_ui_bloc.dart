import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_ui_bloc.freezed.dart';

@freezed
abstract class AppUIEvent with _$AppUIEvent {
  const factory AppUIEvent.reloadAISentencePracticeList() =
      _ReloadAISentencePracticeList;
  const factory AppUIEvent.reloadListeningPracticeList() =
      _ReloadListeningPracticeList;
}

@freezed
abstract class AppUIState with _$AppUIState {
  const factory AppUIState.initial() = _Initial;
  const factory AppUIState.loading({String? message}) = _Loading;
  const factory AppUIState.onReloadAISentencePracticeList() =
      _OnReloadAISentencePracticeList;
  const factory AppUIState.onReloadListeningPracticeList() =
      _OnReloadListeningPracticeList;
  const factory AppUIState.error(String message) = _Error;
}

class AppUIBloc extends Bloc<AppUIEvent, AppUIState> {
  AppUIBloc() : super(const AppUIState.initial()) {
    on<AppUIEvent>((event, emit) async {
      event.when(
        reloadAISentencePracticeList: () {
          emit(const AppUIState.loading());
          emit(
            const AppUIState.onReloadAISentencePracticeList(),
          );
        },
        reloadListeningPracticeList: () {
          emit(const AppUIState.loading());
          emit(
            const AppUIState.onReloadListeningPracticeList(),
          );
        },
      );
    });
  }
}
