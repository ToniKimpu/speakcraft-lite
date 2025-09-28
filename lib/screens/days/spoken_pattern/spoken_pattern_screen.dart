import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/screens/days/spoken_pattern/spoken_pattern_widget.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

import '../../../bloc/audio_player/audio_player_bloc.dart';
import '../../../bloc/spoken_pattern/spoken_pattern_bloc.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../l10n/generated/l10n.dart';
import '../../../model/lesson/lesson.dart';
import '../../../model/spoken_pattern/spoken_pattern.dart';
import 'widgets/footer_widget.dart';

class SpokenPatternScreen extends StatefulWidget {
  const SpokenPatternScreen({
    super.key,
    required this.lesson,
  });
  final Lesson lesson;

  @override
  State<SpokenPatternScreen> createState() => _SpokenPatternScreenState();
}

class _SpokenPatternScreenState extends State<SpokenPatternScreen> {
  int _currentPage = 0;
  final _spokenPatternBloc = SpokenPatternBloc();
  final _audioPositionTrackerBloc = AudioPlayerBloc();
  final _audioPlayerStateTrackerBloc = AudioPlayerBloc();
  final _audioPlayer = AudioPlayer();
  StreamSubscription? _playerStateSubscription;
  StreamSubscription<Duration>? _positionSub;
  final _spokenPatterns = <SpokenPattern>[];

  final List<int> _doneIds = [];

  @override
  void initState() {
    super.initState();
    _spokenPatternBloc
        .add(SpokenPatternEvent.loadPatternsByLesson(widget.lesson.id));
    _playerStateSubscription = _audioPlayer.playerStateStream.listen(
      (playerState) {
        _audioPlayerStateTrackerBloc.add(
          AudioPlayerEvent.updatePlayerState(playerState),
        );
      },
    );
    _positionSub = _audioPlayer.positionStream.listen(
      (pos) {
        _audioPositionTrackerBloc
            .add(AudioPlayerEvent.setCurrentPosition(pos.inSeconds));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _playerStateSubscription?.cancel();
    _positionSub?.cancel();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_currentPage > 0) {
          _audioPlayer.stop();
          setState(() {
            _currentPage--;
            if (_spokenPatterns.isNotEmpty &&
                _spokenPatterns[_currentPage].audioPath != null) {
              _audioPlayer.setUrl(_spokenPatterns[_currentPage].audioPath!);
            }
          });
          return;
        }
        Navigator.pop(context);
      },
      child: MainScaffold(
        appBar: AppBar(
          title: Text(widget.lesson.lessonName),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<SpokenPatternBloc>(
              create: (context) => _spokenPatternBloc,
            ),
            BlocProvider<AudioPlayerBloc>(
              create: (context) => _audioPositionTrackerBloc,
            ),
          ],
          child: BlocBuilder<SpokenPatternBloc, SpokenPatternState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () {
                  return const Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                loaded: (spokenPatterns) {
                  if (spokenPatterns.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).txtWillUploadSoon,
                        style: PmpTextStyles.body2Semi
                            .copyWith(color: Colors.white),
                      ),
                    );
                  }
                  debugPrint(
                      "_spokenPatternScreen: ${spokenPatterns.length} total length!");
                  if (_spokenPatterns.isEmpty) {
                    _spokenPatterns.addAll(spokenPatterns);
                  }
                  // if (spokenPatterns.first.audioPath != null &&
                  //     spokenPatterns.first.audioPath!.isNotEmpty &&
                  //     _currentPage == 0) {
                  //   _audioPlayer.setUrl(spokenPatterns.first.audioPath!.trim());
                  // }
                  return Column(
                    children: [
                      Expanded(
                        child: IndexedStack(
                          index: _currentPage,
                          children: List.generate(
                            spokenPatterns.length,
                            (index) {
                              return SpokenPatternWidget(
                                audioPlayer: _audioPlayer,
                                spokenPattern: spokenPatterns[index],
                                audioPositionTrackerBloc:
                                    _audioPositionTrackerBloc,
                                audioPlayerStateTrackerBloc:
                                    _audioPlayerStateTrackerBloc,
                                onNextEnabledChanged: (spokenPatternId) {
                                  setState(() {
                                    if (!_doneIds.contains(spokenPatternId)) {
                                      _doneIds.add(spokenPatternId);
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      FooterWidget(
                        spokenPatterns: _spokenPatterns,
                        currentPage: _currentPage,
                        audioPlayer: _audioPlayer,
                        nextEnabled:
                            _doneIds.contains(_spokenPatterns[_currentPage].id),
                        onPageChanged: (newPage) {
                          setState(() {
                            _currentPage = newPage;
                            if (_spokenPatterns[_currentPage].audioPath !=
                                null) {
                              _audioPlayer.setUrl(
                                  _spokenPatterns[_currentPage].audioPath!);
                            }
                          });
                        },
                      ),
                    ],
                  );
                },
                orElse: () => Container(),
              );
            },
          ),
        ),
      ),
    );
  }
}
