import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/screens/days/spoken_pattern/spoken_pattern_widget.dart';

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
  final _pageController = PageController();
  final _spokenPatternBloc = SpokenPatternBloc();
  final _audioPositionTrackerBloc = AudioPlayerBloc();
  final _audioPlayerStateTrackerBloc = AudioPlayerBloc();
  final _audioPlayer = AudioPlayer();
  StreamSubscription? _playerStateSubscription;
  StreamSubscription<Duration>? _positionSub;
  final _spokenPatterns = <SpokenPattern>[];

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
        _audioPositionTrackerBloc.add(AudioPlayerEvent.setCurrentPosition(pos));
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _playerStateSubscription?.cancel();
    _positionSub?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_currentPage > 0) {
          _audioPlayer.stop();
          _currentPage--;
          _pageController.jumpToPage(_currentPage);
          setState(() {
            if (_spokenPatterns.isNotEmpty &&
                _spokenPatterns[_currentPage].audioPath != null) {
              _audioPlayer.setUrl(_spokenPatterns[_currentPage].audioPath!);
            }
          });
          return;
        }
        Navigator.pop(context);
      },
      child: Scaffold(
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
                  AppLogger.instance.debug(
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
                        child: PageView.builder(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: spokenPatterns.length,
                          itemBuilder: (context, index) {
                            return SpokenPatternWidget(
                              spokenPattern: spokenPatterns[index],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: FooterWidget(
                          totalPage: _spokenPatterns.length,
                          currentPage: _currentPage,
                          // audioPlayer: _audioPlayer,
                          // nextEnabled: _doneIds
                          //     .contains(_spokenPatterns[_currentPage].id),
                          nextEnabled: true,
                          onPageChanged: (newPage) {
                            _audioPlayer.stop();
                            _pageController.jumpToPage(newPage);
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
