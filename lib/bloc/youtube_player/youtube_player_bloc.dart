import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
part 'youtube_player_bloc.freezed.dart';

@freezed
abstract class YoutubePlayerEvent with _$YoutubePlayerEvent {
  const factory YoutubePlayerEvent.updatePlayerState(PlayerState playerState) =
      _UpdatePlayerState;
}

@freezed
abstract class YoutubePlayerState with _$YoutubePlayerState {
  const factory YoutubePlayerState.initial() = _Initial;
  const factory YoutubePlayerState.loading() = _Loading;
  const factory YoutubePlayerState.onUpdatePlayerState(
      PlayerState playerState) = _OnUpdatePlayerState;
  const factory YoutubePlayerState.error(String message) = _Error;
}

class YoutubePlayerBloc extends Bloc<YoutubePlayerEvent, YoutubePlayerState> {
  YoutubePlayerBloc() : super(const YoutubePlayerState.initial()) {
    on<YoutubePlayerEvent>((event, emit) async {
      try {
        await event.when(
          updatePlayerState: (playerState) {
            emit(const YoutubePlayerState.loading());
            emit(YoutubePlayerState.onUpdatePlayerState(playerState));
          },
        );
      } catch (e) {
        emit(YoutubePlayerState.error(e.toString()));
      }
    });
  }
}
