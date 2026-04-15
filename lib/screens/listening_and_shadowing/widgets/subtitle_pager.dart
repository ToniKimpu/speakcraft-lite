import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/bloc/listening/subtitle_index_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/model/subtitle/subtitle.dart';
import 'package:pmp_english/model/vocabulary/vocabulary.dart';
import 'package:pmp_english/screens/listening_and_shadowing/widgets/subtitle_card.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Paged viewer for a list of [Subtitle]s with prev/next controls and an
/// auto-stream toggle that follows the video position via [SubtitleIndexBloc].
class SubtitlePager extends StatefulWidget {
  const SubtitlePager({
    super.key,
    required this.youtubeController,
    required this.audioPlayer,
    required this.subtitleIndexBloc,
    required this.subtitles,
    required this.hasMMSub,
    required this.onUserChangePage,
    this.vocabBySentenceId = const {},
  });

  final YoutubePlayerController youtubeController;
  final AudioPlayer audioPlayer;
  final SubtitleIndexBloc subtitleIndexBloc;
  final List<Subtitle> subtitles;
  final bool hasMMSub;
  final void Function(Subtitle subtitle) onUserChangePage;
  final Map<int, List<VocabularyWord>> vocabBySentenceId;

  @override
  State<SubtitlePager> createState() => _SubtitlePagerState();
}

class _SubtitlePagerState extends State<SubtitlePager> {
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
      if (currentTag != url) {
        await widget.audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(url), tag: url),
        );
      }
    } catch (e, st) {
      AppLogger.instance
          .error("Error setting audio source: $e", error: e, stackTrace: st);
    }
  }

  void _goToNext() {
    if (_currentIndex >= widget.subtitles.length - 1) return;
    _selectIndex(_currentIndex + 1, pushToVideo: _streamData);
  }

  void _goToPrevious() {
    if (_currentIndex <= 0) return;
    _selectIndex(_currentIndex - 1, pushToVideo: _streamData);
  }

  void _selectIndex(int index, {required bool pushToVideo}) {
    setState(() {
      _currentIndex = index;
      _selectedSubtitle = widget.subtitles[index];
    });
    if (_selectedSubtitle.audioName.isNotEmpty) {
      _setAudioSourceIfNeeded(_selectedSubtitle.audioName);
    }
    if (pushToVideo) widget.onUserChangePage(_selectedSubtitle);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocListener<SubtitleIndexBloc, SubtitleIndexState>(
      bloc: widget.subtitleIndexBloc,
      listener: (context, state) {
        state.maybeWhen(
          changed: (index) {
            _instantStreamIndex = index;
            if (_streamData) _selectIndex(index, pushToVideo: false);
          },
          orElse: () {},
        );
      },
      child: Container(
        width: double.infinity,
        color: colorScheme.surface,
        child: Column(
          children: [
            Expanded(
              child: SubtitleCard(
                youtubeController: widget.youtubeController,
                audioPlayer: widget.audioPlayer,
                subtitle: _selectedSubtitle,
                hasMMSub: widget.hasMMSub,
                vocabularyWords: _selectedSubtitle.id != null
                    ? widget.vocabBySentenceId[_selectedSubtitle.id!] ??
                        const []
                    : const [],
              ),
            ),
            Divider(color: colorScheme.outlineVariant, height: 1),
            _buildControlsRow(colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildControlsRow(ColorScheme colorScheme) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          const SizedBox(width: 16),
          Text(
            'Stream',
            style: PmpTextStyles.body2Semi.copyWith(color: colorScheme.onSurface),
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
                    _selectedSubtitle = widget.subtitles[_instantStreamIndex];
                  }
                });
              },
            ),
          ),
          const Spacer(),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: _goToPrevious,
            icon: Icon(Icons.chevron_left, color: colorScheme.onSurface),
          ),
          Text(
            '${_currentIndex + 1}/${widget.subtitles.length}',
            style: PmpTextStyles.labelSemi.copyWith(color: colorScheme.onSurface),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: _goToNext,
            icon: Icon(Icons.chevron_right, color: colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}
