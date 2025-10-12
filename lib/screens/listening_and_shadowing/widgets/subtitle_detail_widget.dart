import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/bloc/audio_player/audio_player_bloc.dart';
import 'package:pmp_english/bloc/subtitle_detail/subtitle_detail_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/subtitle_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/pmp_colors.dart';
import '../../../model/subtitle/subtitle.dart';

class SubtitleDetailWidget extends StatefulWidget {
  const SubtitleDetailWidget({
    super.key,
    required this.youtubeReadyToPlay,
    required this.youtubeController,
    required this.audioPostionTrackerBloc,
    required this.audioDurationTrackerBloc,
    required this.audioPlayerStateTrackerBloc,
    required this.audioPlayer,
    required this.subtitleBloc,
    required this.subtitles,
    required this.hasMMSub,
    required this.onUserChangePage,
  });
  final bool youtubeReadyToPlay;
  final YoutubePlayerController youtubeController;
  final AudioPlayerBloc audioPostionTrackerBloc,
      audioDurationTrackerBloc,
      audioPlayerStateTrackerBloc;
  final AudioPlayer audioPlayer;
  final SubtitleBloc subtitleBloc;
  final List<Subtitle> subtitles;
  final bool hasMMSub;
  final Function(Subtitle subtitle) onUserChangePage;

  @override
  State<SubtitleDetailWidget> createState() => _SubtitleDetailWidgetState();
}

class _SubtitleDetailWidgetState extends State<SubtitleDetailWidget> {
  bool _streamData = true;
  int _currentIndex = 0;
  int _instantStreamIndex = 0;
  late Subtitle _selectedSubtitle;

  @override
  void initState() {
    super.initState();
    _selectedSubtitle = widget.subtitles[_currentIndex];
  }

  Future<void> _setAudioSourceIfNeeded(String url) async {
    try {
      await widget.audioPlayer.stop();

      final source = widget.audioPlayer.audioSource;
      final currentTag = source?.sequence.first.tag;
      debugPrint("_setAudioSourceIfNeeded: $currentTag current Tag");
      debugPrint("_setAudioSourceIfNeeded: $url url Tag");
      if (currentTag != url) {
        await widget.audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(url), tag: url),
        );
      }
    } catch (e, st) {
      debugPrint("Error setting audio source: $e\n$st");
    }
  }

  void _goToNext() {
    if (_currentIndex < widget.subtitles.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedSubtitle = widget.subtitles[_currentIndex];
      });
      if (_selectedSubtitle.audioName.isNotEmpty) {
        _setAudioSourceIfNeeded(_selectedSubtitle.audioName);
      }
      if (_streamData) widget.onUserChangePage(_selectedSubtitle);
    }
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _selectedSubtitle = widget.subtitles[_currentIndex];
      });
      if (_selectedSubtitle.audioName.isNotEmpty) {
        _setAudioSourceIfNeeded(_selectedSubtitle.audioName);
      }
      if (_streamData) widget.onUserChangePage(_selectedSubtitle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubtitleBloc, SubtitleState>(
      bloc: widget.subtitleBloc,
      listener: (context, state) {
        state.maybeWhen(
          onPageChanged: (index) {
            _instantStreamIndex = index;
            if (_streamData) {
              setState(() {
                _currentIndex = index;
                _selectedSubtitle = widget.subtitles[index];
              });
              if (_selectedSubtitle.audioName.isNotEmpty) {
                _setAudioSourceIfNeeded(_selectedSubtitle.audioName);
              }
            }
          },
          orElse: () => -1,
        );
      },
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF0F2027),
                Color(0xFF203A43),
                Color(0xFF2C5364),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 12,
                spreadRadius: 6,
              ),
            ],
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            children: [
              // Stream switch row
              SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Stream',
                        style: PmpTextStyles.body2Semi.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Transform.scale(
                        scale: 0.75,
                        child: Switch(
                          value: _streamData,
                          onChanged: (value) {
                            setState(() {
                              _streamData = value;
                              if (_streamData) {
                                _currentIndex = _instantStreamIndex;
                                _selectedSubtitle =
                                    widget.subtitles[_instantStreamIndex];
                              }
                            });
                          },
                          activeColor: Colors.white,
                          inactiveThumbColor:
                              Colors.white.withValues(alpha: 0.8),
                          activeTrackColor: Colors.green,
                          inactiveTrackColor:
                              Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.white.withValues(alpha: 0.4), height: 1),
              // Single subtitle
              Expanded(
                child: SubtitleWidget(
                  youtubeController: widget.youtubeController,
                  audioPlayer: widget.audioPlayer,
                  audioPositionTrackerBloc: widget.audioPostionTrackerBloc,
                  audioDurationTrackerBloc: widget.audioDurationTrackerBloc,
                  audioPlayerStateTrackerBloc:
                      widget.audioPlayerStateTrackerBloc,
                  subtitle: _selectedSubtitle,
                  hasMMSub: widget.hasMMSub,
                ),
              ),
              Divider(color: Colors.white.withValues(alpha: 0.4), height: 1),
              // Controls row
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    widget.youtubeReadyToPlay
                        ? Material(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                if (widget.youtubeController.value.isPlaying) {
                                  widget.youtubeController.pause();
                                } else {
                                  widget.youtubeController.play();
                                  if (widget.audioPlayer.playing) {
                                    widget.audioPlayer.pause();
                                  }
                                }
                                setState(() {});
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  widget.youtubeController.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: PmpColors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: PmpColors.white,
                            ),
                          ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: _goToPrevious,
                      icon: const Icon(Icons.chevron_left, color: Colors.white),
                    ),
                    Text(
                      '${_currentIndex + 1}/${widget.subtitles.length}',
                      style:
                          PmpTextStyles.labelSemi.copyWith(color: Colors.white),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: _goToNext,
                      icon:
                          const Icon(Icons.chevron_right, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
