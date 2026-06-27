import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakcraft/config/pmp_routes.dart';
import 'package:speakcraft/model/listening/listening.dart';
import 'package:speakcraft/shared_widgets/glass.dart';

import '../../bloc/user_recorded_sentence_audio/user_recorded_sentence_audio_bloc.dart';
import '../../model/listening/listening_recording.dart';
import 'recording_voice_widgets/user_recorded_list.dart';

/// History landing for "Full talk" mode.
///
/// Full takes are stored with the reserved sentence id [_kFullSentenceId], so
/// this screen reuses the same recordings repository / bloc / list widget the
/// section-by-section flow uses — just filtered to that one id. A persistent
/// bottom button opens the recording teleprompter ([PmpRoutes.fullTalkRecordPage]);
/// the list reloads when the user returns so a freshly saved take shows up.
class FullTalkHistoryPage extends StatefulWidget {
  const FullTalkHistoryPage({super.key, required this.listening});

  final Listening listening;

  static const _kFullSentenceId = 'FULL';

  @override
  State<FullTalkHistoryPage> createState() => _FullTalkHistoryPageState();
}

class _FullTalkHistoryPageState extends State<FullTalkHistoryPage> {
  final _recordingsBloc = UserRecordedSentenceAudioBloc();
  late final AudioPlayer _audioPlayer;
  final _currentlyPlayingIndexNotifier = ValueNotifier<int?>(null);

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _currentlyPlayingIndexNotifier.value = null;
      }
    });
    _load(withLoading: true);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _recordingsBloc.close();
    _currentlyPlayingIndexNotifier.dispose();
    super.dispose();
  }

  void _load({required bool withLoading}) {
    _recordingsBloc.add(
      UserRecordedSentenceAudioEvent.load(
        listeningId: widget.listening.id,
        withLoading: withLoading,
      ),
    );
  }

  Future<void> _openRecorder() async {
    await _audioPlayer.stop();
    _currentlyPlayingIndexNotifier.value = null;
    if (!mounted) return;
    await Navigator.pushNamed(
      context,
      PmpRoutes.fullTalkRecordPage,
      arguments: {'listening': widget.listening},
    );
    // A new take may have been saved — refresh without the full-screen spinner.
    _load(withLoading: false);
  }

  Future<void> _onTogglePlay(ListeningRecording data, int index) async {
    final isCurrent = _currentlyPlayingIndexNotifier.value == index;
    if (isCurrent) {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
        _currentlyPlayingIndexNotifier.value = null;
      } else {
        await _audioPlayer.play();
        _currentlyPlayingIndexNotifier.value = index;
      }
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.setFilePath(data.audioPath);
      _audioPlayer.play();
      _currentlyPlayingIndexNotifier.value = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
            padding: EdgeInsets.only(left: 8), child: GlassBackButton()),
        title: const Text('Full talk'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<int?>(
              valueListenable: _currentlyPlayingIndexNotifier,
              builder: (context, currentIndex, _) {
                return UserRecordedList(
                  audioPlayer: _audioPlayer,
                  currentIndex: currentIndex,
                  userRecordedSentenceAudioBloc: _recordingsBloc,
                  listeningId: widget.listening.id,
                  sentenceId: FullTalkHistoryPage._kFullSentenceId,
                  onTogglePlay: _onTogglePlay,
                  emptyMessage: 'No full takes yet.\nTap “Record new take” to start.',
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              decoration: BoxDecoration(
                color: cs.surface,
                border: Border(top: BorderSide(color: cs.outlineVariant)),
              ),
              child: FilledButton.icon(
                onPressed: _openRecorder,
                icon: const Icon(Icons.mic),
                label: const Text('Record new take'),
                style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
