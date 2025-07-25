import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_player_bloc.freezed.dart';

@freezed
abstract class AudioPlayerEvent with _$AudioPlayerEvent {
  const factory AudioPlayerEvent.setUrl(String audioUrl) = _SetUrl;
  const factory AudioPlayerEvent.setCurrentPosition(int position) =
      _SetCurrentPosition;
  const factory AudioPlayerEvent.play() = _Play;
  const factory AudioPlayerEvent.pause() = _Pause;
  const factory AudioPlayerEvent.stop() = _Stop;
}

@freezed
abstract class AudioPlayerState with _$AudioPlayerState {
  const factory AudioPlayerState.initial() = _Initial;
  const factory AudioPlayerState.loading() = _Loading;
  const factory AudioPlayerState.getUrl(String audioUrl) = _GetUrl;
  const factory AudioPlayerState.onPlay() = _OnPlay;
  const factory AudioPlayerState.onPause() = _onPause;
  const factory AudioPlayerState.onStop() = _onStop;
  const factory AudioPlayerState.onCurrentPosition(int position) =
      _OnCurrentPosition;
  const factory AudioPlayerState.error(String message) = _Error;
}

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  AudioPlayerBloc() : super(const AudioPlayerState.initial()) {
    on<AudioPlayerEvent>((event, emit) async {
      try {
        await event.when(
          setUrl: (audioUrl) async {
            emit(const AudioPlayerState.loading());
            emit(AudioPlayerState.getUrl(audioUrl));
          },
          play: () {
            emit(const AudioPlayerState.loading());
            emit(const AudioPlayerState.onPlay());
          },
          pause: () {
            emit(const AudioPlayerState.loading());
            emit(const AudioPlayerState.onPause());
          },
          stop: () {
            emit(const AudioPlayerState.loading());
            emit(const AudioPlayerState.onPause());
          },
          setCurrentPosition: (position) {
            emit(const AudioPlayerState.loading());
            emit(AudioPlayerState.onCurrentPosition(position));
          },
        );
      } catch (e) {
        emit(AudioPlayerState.error(e.toString()));
      }
    });
  }
}
