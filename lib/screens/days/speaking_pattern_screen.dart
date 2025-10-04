import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/bloc/audio_player/audio_player_bloc.dart';
import 'package:pmp_english/l10n/generated/l10n.dart';
import 'package:pmp_english/screens/days/widgets/spoken_pattern_widget.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

import '../../bloc/spoken_pattern/spoken_pattern_bloc.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/lesson/lesson.dart';
import '../../model/spoken_pattern/spoken_pattern.dart';

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
  final _spokenPatternBloc = SpokenPatternBloc();
  final _audioPositionTrackerBloc = AudioPlayerBloc();
  final _audioPlayerStateTrackerBloc = AudioPlayerBloc();
  final _audioPlayer = AudioPlayer();
  int _currentPage = 0;
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
          title: Text(
            widget.lesson.lessonName,
          ),
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
                  if (_spokenPatterns.isEmpty) {
                    _spokenPatterns.addAll(spokenPatterns);
                  }
                  if (spokenPatterns.first.audioPath != null &&
                      _currentPage == 0) {
                    _audioPlayer.setUrl(spokenPatterns.first.audioPath!.trim());
                  }
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
                              );
                            },
                          ),
                        ),
                      ),
                      _buildFooter(_spokenPatterns),
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

  Widget _buildFooter(List<SpokenPattern> spokenPatterns) {
    return Card(
      elevation: 4, // Adds shadow effect
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      // color: const Color(0xFF0F2027),
      color: const Color(0xFF1C2C3C),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPreviousButton(spokenPatterns),
            _buildProgressIndicator(spokenPatterns),
            _buildNextButton(spokenPatterns),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviousButton(List<SpokenPattern> spokenPatterns) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: _currentPage <= 0
          ? null
          : () {
              _audioPlayer.stop();
              setState(
                () {
                  _currentPage--;
                  if (spokenPatterns[_currentPage].audioPath != null) {
                    _audioPlayer
                        .setUrl(spokenPatterns[_currentPage].audioPath!);
                  }
                },
              );
            },
      child: Ink(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: _currentPage == 0
              ? const LinearGradient(
                  colors: [Colors.grey, Colors.grey], // Disabled state
                )
              : const LinearGradient(
                  colors: [
                    Color(0xFFFFD700), // Gold
                    Color(0xFFFFA500), // Deep Gold
                    Color(0xFFB8860B), // Dark Golden
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.chevron_left,
          color: _currentPage == 0
              ? Colors.black38
              : Colors.white, // White for contrast
          size: 28,
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(List<SpokenPattern> spokenPatterns) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFD700), // Gold
            Color(0xFFFFA500), // Deep Gold/Orange
            Color(0xFFB8860B), // Dark Golden
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            spreadRadius: 3,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        '${_currentPage + 1}/${spokenPatterns.length}',
        style: PmpTextStyles.body2Semi.copyWith(
          color: Colors.white, // White text for contrast
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(1, 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(List<SpokenPattern> spokenPatterns) {
    final totalPatterns = spokenPatterns.length - 1;
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: _currentPage >= totalPatterns
          ? null
          : () {
              _audioPlayer.stop();
              setState(
                () {
                  _currentPage++;
                  if (spokenPatterns[_currentPage].audioPath != null) {
                    _audioPlayer
                        .setUrl(spokenPatterns[_currentPage].audioPath!);
                  }
                },
              );
            },
      child: Ink(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: _currentPage >= totalPatterns
              ? const LinearGradient(
                  colors: [Colors.grey, Colors.grey], // Disabled state
                )
              : const LinearGradient(
                  colors: [
                    Color(0xFFFFD700), // Gold
                    Color(0xFFFFA500), // Deep Gold
                    Color(0xFFB8860B), // Dark Golden
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.chevron_right,
          color: _currentPage >= totalPatterns
              ? Colors.black38
              : Colors.white, // White for contrast
          size: 28,
        ),
      ),
    );
  }
}
