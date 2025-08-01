import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/bloc/audio_player/audio_player_bloc.dart';
import 'package:pmp_english/bloc/subtitle_detail/subtitle_detail_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/subtitle_widget.dart';

import '../../../model/subtitle/subtitle.dart';

class SubtitleDetailWidget extends StatefulWidget {
  const SubtitleDetailWidget({
    super.key,
    required this.audioPostionTrackerBloc,
    required this.audioDurationTrackerBloc,
    required this.audioPlayerStateTrackerBloc,
    required this.audioPlayer,
    required this.subtitleBloc,
    required this.showSubtitleDetail,
    required this.subtitles,
    required this.hasMMSub,
    required this.onUserChangePage,
  });
  final AudioPlayerBloc audioPostionTrackerBloc,
      audioDurationTrackerBloc,
      audioPlayerStateTrackerBloc;
  final AudioPlayer audioPlayer;
  final SubtitleBloc subtitleBloc;
  final ValueNotifier<bool> showSubtitleDetail;
  final List<Subtitle> subtitles;
  final bool hasMMSub;
  final Function(Subtitle subtitle) onUserChangePage;

  @override
  State<SubtitleDetailWidget> createState() => _SubtitleDetailWidgetState();
}

class _SubtitleDetailWidgetState extends State<SubtitleDetailWidget> {
  bool _streamData = false;
  final _pageController = PageController();
  int _currentIndex = 0;
  void _goToNext() async {
    if (_currentIndex < widget.subtitles.length - 1) {
      setState(() => _currentIndex++);
      await widget.audioPlayer.stop();
      final subtitle = widget.subtitles[_currentIndex];
      if (subtitle.audioName.isNotEmpty) {
        widget.audioPlayer.setUrl(subtitle.audioName);
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      if (_streamData) widget.onUserChangePage(widget.subtitles[_currentIndex]);
    }
  }

  void _goToPrevious() async {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      await widget.audioPlayer.stop();
      final subtitle = widget.subtitles[_currentIndex];
      if (subtitle.audioName.isNotEmpty) {
        widget.audioPlayer.setUrl(subtitle.audioName);
      }
      await widget.audioPlayer.stop();
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      if (_streamData) widget.onUserChangePage(widget.subtitles[_currentIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubtitleBloc, SubtitleState>(
      listener: (context, state) {
        state.maybeWhen(
          onPageChanged: (index) async {
            if (_pageController.hasClients && _streamData) {
              _currentIndex = index;
              final subtitle = widget.subtitles[index];
              await widget.audioPlayer.stop();
              if (subtitle.audioName.isNotEmpty) {
                widget.audioPlayer.setUrl(subtitle.audioName);
              }

              _pageController.animateToPage(
                _currentIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          orElse: () => -1,
        );
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: widget.showSubtitleDetail,
        builder: (context, show, child) {
          return Offstage(
            offstage: !show,
            child: child!,
          );
        },
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            // padding: const EdgeInsets.only(left: 0, right: 0, top: 12),
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
                  color: Colors.black
                      .withValues(alpha: 0.3), // Slightly stronger shadow
                  blurRadius: 12,
                  spreadRadius: 6,
                ),
              ],
              border: Border.all(
                color: Colors.white
                    .withValues(alpha: 0.4), // Soft white border for contrast
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: SizedBox(
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
                            scale:
                                0.75, // Adjust between 0.6 to 1.0 to fine-tune size
                            child: Switch(
                              value: _streamData,
                              onChanged: (value) {
                                setState(() {
                                  _streamData = value;
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
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.subtitles.length,
                    itemBuilder: (context, index) {
                      return SubtitleWidget(
                        audioPlayer: widget.audioPlayer,
                        audioPositionTrackerBloc:
                            widget.audioPostionTrackerBloc,
                        audioDurationTrackerBloc:
                            widget.audioDurationTrackerBloc,
                        audioPlayerStateTrackerBloc:
                            widget.audioPlayerStateTrackerBloc,
                        subtitle: widget.subtitles[index],
                        hasMMSub: widget.hasMMSub,
                      );
                    },
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: _goToPrevious,
                        icon:
                            const Icon(Icons.chevron_left, color: Colors.white),
                      ),
                      Text(
                        '${_currentIndex + 1}/${widget.subtitles.length}',
                        style: PmpTextStyles.labelSemi
                            .copyWith(color: Colors.white),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: _goToNext,
                        icon: const Icon(Icons.chevron_right,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
