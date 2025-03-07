import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/pattern/pattern.dart';

class SelfPatternWidget extends StatefulWidget {
  const SelfPatternWidget(
      {super.key,
      required this.patternContainerKey,
      required this.pattern,
      required ValueNotifier<bool> showVocabularyNotifier,
      required ValueNotifier<bool> showExampleNotifier})
      : _showVocabularyNotifier = showVocabularyNotifier,
        _showExampleNotifier = showExampleNotifier;

  final GlobalKey<State<StatefulWidget>> patternContainerKey;
  final ValueNotifier<bool> _showVocabularyNotifier;
  final ValueNotifier<bool> _showExampleNotifier;
  final Pattern pattern;

  @override
  State<SelfPatternWidget> createState() => _SelfPatternWidgetState();
}

class _SelfPatternWidgetState extends State<SelfPatternWidget> {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    if (widget.pattern.audioPath != null) {
      _player.setUrl(widget.pattern.audioPath!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.patternContainerKey,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  Text(
                    widget.pattern.pattern.trim(),
                    style: PmpTextStyles.body1Semi.copyWith(
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.pattern.title != null)
                    Text(
                      widget.pattern.title!.trim(),
                      style: PmpTextStyles.body2Medium.copyWith(
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
              if (widget.pattern.audioPath != null)
                Material(
                  borderRadius: BorderRadius.circular(12),
                  color: PmpColors.primary400,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      final playerState = _player.playerState;
                      if (playerState.processingState ==
                          ProcessingState.completed) {
                        _player.seek(Duration.zero);
                        _player.play();
                      } else if (_player.playing) {
                        _player.pause();
                      } else {
                        _player.play();
                      }
                    },
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: StreamBuilder<PlayerState>(
                        stream: _player.playerStateStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                          final isPlaying = playerState?.playing ?? false;
                          final processingState = playerState?.processingState;
                          if (processingState == ProcessingState.completed) {
                            return const Icon(
                              Icons.replay,
                              color: Colors.white,
                              size: 16,
                            );
                          }
                          return Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 16,
                          );
                        },
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            widget.pattern.description ?? '',
            style: PmpTextStyles.body2Medium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PmpColors.primary400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (widget._showExampleNotifier.value) {
                    widget._showExampleNotifier.value = false;
                    return;
                  }
                  widget._showVocabularyNotifier.value =
                      !widget._showVocabularyNotifier.value;
                },
                child: Text(
                  'Vocabularies',
                  style:
                      PmpTextStyles.body2Medium.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PmpColors.primary400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (widget._showVocabularyNotifier.value) {
                    widget._showVocabularyNotifier.value = false;
                    return;
                  }
                  widget._showExampleNotifier.value =
                      !widget._showExampleNotifier.value;
                },
                child: Text(
                  'Examples',
                  style:
                      PmpTextStyles.body2Medium.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
