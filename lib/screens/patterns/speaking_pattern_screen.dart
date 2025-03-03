import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/bloc/audio_player/audio_player_bloc.dart';
import 'package:pmp_english/l10n/generated/l10n.dart';
import 'package:pmp_english/screens/patterns/widgets/pattern_widget.dart';

import '../../bloc/pattern/pattern_bloc.dart';
import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/lesson/lesson.dart';
import '../../model/pattern/pattern.dart';

class SpeakingPatternScreen extends StatefulWidget {
  const SpeakingPatternScreen({
    super.key,
    required this.lesson,
  });
  final Lesson lesson;

  @override
  State<SpeakingPatternScreen> createState() => _SpeakingPatternScreenState();
}

class _SpeakingPatternScreenState extends State<SpeakingPatternScreen> {
  final _patternBloc = PatternBloc();
  final _audioPlayerBloc = AudioPlayerBloc();
  final _audioPlayer = AudioPlayer();
  int _currentPage = 0;
  StreamSubscription? _playerStateSubscription;
  final _patterns = <Pattern>[];
  @override
  void initState() {
    super.initState();
    _patternBloc.add(PatternEvent.loadPatternsByLesson(widget.lesson.id));
    _playerStateSubscription =
        _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        _audioPlayerBloc.add(const AudioPlayerEvent.stop());
        _audioPlayer.seek(Duration.zero);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _playerStateSubscription?.cancel();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_currentPage > 0) {
          _audioPlayerBloc.add(const AudioPlayerEvent.stop());
          setState(() {
            _currentPage--;
            if (_patterns.isNotEmpty &&
                _patterns[_currentPage].audioPath != null) {
              _audioPlayerBloc.add(
                AudioPlayerEvent.setUrl(_patterns[_currentPage].audioPath!),
              );
            }
          });
          return;
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.lesson.lessonName),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<PatternBloc>(
              create: (context) => _patternBloc,
            ),
            BlocProvider<AudioPlayerBloc>(
              create: (context) => _audioPlayerBloc,
            ),
          ],
          child: BlocListener<AudioPlayerBloc, AudioPlayerState>(
            bloc: _audioPlayerBloc,
            listener: (context, state) {
              state.maybeWhen(
                getUrl: (audioUrl) {
                  _audioPlayer.setUrl(audioUrl);
                },
                onPlay: () {
                  debugPrint("_audioPlayerBloc: onPlay!");
                  _audioPlayer.play();
                },
                onPause: () {
                  _audioPlayer.pause();
                },
                onStop: () {
                  _audioPlayer.stop();
                },
                orElse: () => -1,
              );
            },
            child: BlocBuilder<PatternBloc, PatternState>(
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
                  loaded: (patterns) {
                    if (patterns.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context).txtWillUploadSoon,
                        ),
                      );
                    }
                    if (_patterns.isEmpty) {
                      _patterns.addAll(patterns);
                    }
                    if (patterns.first.audioPath != null && _currentPage == 0) {
                      _audioPlayer.setUrl(patterns.first.audioPath!.trim());
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: IndexedStack(
                            index: _currentPage,
                            children: List.generate(
                              patterns.length,
                              (index) {
                                return PatternWidget(
                                  pattern: patterns[index],
                                  audioPlayerBloc: _audioPlayerBloc,
                                );
                              },
                            ),
                          ),
                        ),
                        _buildFooter(patterns),
                      ],
                    );
                  },
                  orElse: () => Container(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(List<Pattern> patterns) {
    return Container(
      width: double.infinity,
      height: 48,
      color: PmpColors.primary400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPreviousButton(patterns),
          _buildProgressIndicator(patterns),
          _buildNextButton(patterns),
        ],
      ),
    );
  }

  Widget _buildPreviousButton(List<Pattern> patterns) {
    return IconButton(
      onPressed: _currentPage <= 0
          ? null
          : () {
              _audioPlayerBloc.add(const AudioPlayerEvent.stop());
              setState(() {
                _currentPage--;
                if (patterns[_currentPage].audioPath != null) {
                  _audioPlayerBloc.add(
                    AudioPlayerEvent.setUrl(patterns[_currentPage].audioPath!),
                  );
                }
              });
            },
      icon: Icon(
        Icons.chevron_left,
        color: _currentPage <= 0 ? Colors.grey : Colors.white,
      ),
    );
  }

  Widget _buildProgressIndicator(List<Pattern> patterns) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: const BoxDecoration(
        color: PmpColors.primary400,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Text(
        '${_currentPage + 1}/${patterns.length}',
        style: PmpTextStyles.body1Semi.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildNextButton(List<Pattern> patterns) {
    final totalPatterns = patterns.length - 1;
    return IconButton(
      onPressed: _currentPage >= totalPatterns
          ? null
          : () {
              _audioPlayerBloc.add(const AudioPlayerEvent.stop());
              setState(() {
                _currentPage++;
                if (patterns[_currentPage].audioPath != null) {
                  _audioPlayerBloc.add(
                    AudioPlayerEvent.setUrl(patterns[_currentPage].audioPath!),
                  );
                }
              });
            },
      icon: Icon(
        Icons.chevron_right,
        color: _currentPage >= totalPatterns ? Colors.grey : Colors.white,
      ),
    );
  }
}
