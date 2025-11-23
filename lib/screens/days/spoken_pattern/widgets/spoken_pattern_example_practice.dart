import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/model/pattern_example/pattern_example.dart';
import 'package:pmp_english/model/pattern_vocabulary/pattern_vocabulary.dart';
import 'package:pmp_english/screens/days/spoken_pattern/widgets/word_chips.dart';

import '../../../../config/pmp_text_styles.dart';
import '../../../../services/supabase_service.dart';

class SpokenPatternExamplePractice extends StatefulWidget {
  const SpokenPatternExamplePractice({
    super.key,
    required this.audioPlayer,
    required this.spokenPatternExample,
    required this.onDone,
    required this.currentPlayingId,
    required this.onCurrentPlayingIdChanged,
    required this.currentPlayerState,
    required this.onAnswerChanged,
  });
  final AudioPlayer audioPlayer;
  final PatternExample spokenPatternExample;
  final Function(int count) onDone;
  final String currentPlayingId;
  final Function(String currentPlayingId) onCurrentPlayingIdChanged;
  final PlayerState? currentPlayerState;
  final Function(int exampleId, String answer) onAnswerChanged;

  @override
  State<SpokenPatternExamplePractice> createState() =>
      _SpokenPatternExamplePracticeState();
}

class _SpokenPatternExamplePracticeState
    extends State<SpokenPatternExamplePractice> {
  final _userAnswerController = TextEditingController();

  final Set<int> _usedWordIndices = {};
  final List<int> _usedOrder = [];
  @override
  void initState() {
    super.initState();
  }

  Future<void> _setAudioSourceIfNeeded(String url, int id) async {
    try {
      await widget.audioPlayer.stop();
      widget.onCurrentPlayingIdChanged("pattern-practice-$id");
      final source = widget.audioPlayer.audioSource;
      final currentTag = source?.sequence.first.tag as String?;
      if (currentTag != url) {
        await widget.audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(url), tag: url),
        );
      }
      widget.audioPlayer.play();
    } catch (e) {
      widget.onCurrentPlayingIdChanged("pattern-practice-$id");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCurrentAudio = widget.currentPlayingId ==
        "pattern-practice-${widget.spokenPatternExample.id}";
    final loading = (widget.currentPlayerState?.processingState ==
            ProcessingState.loading ||
        widget.currentPlayerState?.processingState ==
            ProcessingState.buffering);
    final isPlaying = widget.currentPlayerState?.playing ?? false;
    final completed =
        widget.currentPlayerState?.processingState == ProcessingState.completed;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Burmese",
            style: PmpTextStyles.body2Regular.copyWith(
              color: Colors.white,
            ),
          ),
          Text(
            widget.spokenPatternExample.burmeseText!,
            style: PmpTextStyles.body1Semi.copyWith(
              color: Colors.white,
            ),
          ),
          if (widget.spokenPatternExample.userAnswer != null) ...[
            const SizedBox(
              height: 8,
            ),
            Text(
              "English",
              style: PmpTextStyles.body2Regular.copyWith(
                color: Colors.white,
              ),
            ),
            Text(
              widget.spokenPatternExample.englishText,
              style: PmpTextStyles.body1Semi.copyWith(
                color: Colors.white,
              ),
            ),
            if (widget.spokenPatternExample.userAnswer != null &&
                widget.spokenPatternExample.audioUrl != null &&
                widget.spokenPatternExample.audioUrl!.isNotEmpty) ...[
              const SizedBox(
                height: 8,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    if (isCurrentAudio) {
                      if (completed) {
                        widget.audioPlayer.seek(Duration.zero);
                        widget.audioPlayer.play();
                      } else if (isPlaying) {
                        await widget.audioPlayer.pause();
                      } else {
                        await widget.audioPlayer.play();
                      }
                    } else {
                      _setAudioSourceIfNeeded(
                        widget.spokenPatternExample.audioUrl ?? '',
                        widget.spokenPatternExample.id,
                      );
                    }
                  },
                  child: Ink(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      color: Colors.blue.withValues(alpha: 0.8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                            child: Center(
                              child: (loading && isCurrentAudio)
                                  ? const SizedBox(
                                      width: 14,
                                      height: 14,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.blue),
                                      ),
                                    )
                                  : Icon(
                                      (completed && isCurrentAudio)
                                          ? Icons.replay
                                          : (isPlaying && isCurrentAudio)
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                      color: Colors.blue,
                                      size: 18,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Explanation",
                          style: PmpTextStyles.body2Semi
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(
              height: 12,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ],
          const SizedBox(
            height: 8,
          ),
          Text(
            "Your Answer",
            style: PmpTextStyles.body1Semi.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          if (widget.spokenPatternExample.userAnswer != null)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.spokenPatternExample.userAnswer!,
                style: PmpTextStyles.body1Semi.copyWith(color: Colors.white),
              ),
            ),
          if (widget.spokenPatternExample.userAnswer == null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              width: double.infinity,
              constraints: const BoxConstraints(
                minHeight: 44,
              ),
              decoration: BoxDecoration(
                color: Colors.white
                    .withValues(alpha: 0.08), // slightly more visible glass
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _userAnswerController.text.trim().isEmpty
                          ? "Tap the words"
                          : _userAnswerController.text.trim(),
                      key: ValueKey(_userAnswerController.text),
                      style: PmpTextStyles.body1Regular.copyWith(
                        color: Colors.white,
                        fontFamily: "ArchivoBlack Regular",
                      ),
                    ),
                  ),
                  if (widget.spokenPatternExample.userAnswer == null)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          setState(() {
                            final currentText =
                                _userAnswerController.text.trim();
                            if (currentText.isEmpty) return;

                            // remove last word textually
                            final words = currentText.split(' ');
                            final lastWord = words.removeLast();
                            _userAnswerController.text = words.join(' ');

                            // remove the last used index (the chip we want to unlock)
                            if (_usedOrder.isNotEmpty) {
                              final lastIdx = _usedOrder.removeLast();
                              _usedWordIndices.remove(lastIdx);
                            } else {
                              // fallback: if order list empty, try to find a used index matching lastWord
                              // (optional and defensive)
                              final fallbackIndex = _usedWordIndices.firstWhere(
                                (i) {
                                  // need access to the original words list; derive it:
                                  final allWords =
                                      (widget.spokenPatternExample.words ??
                                              widget.spokenPatternExample
                                                  .englishText)
                                          .trim()
                                          .split(' ');
                                  return allWords[i] == lastWord;
                                },
                                orElse: () => -1,
                              );
                              if (fallbackIndex >= 0) {
                                _usedWordIndices.remove(fallbackIndex);
                              }
                            }
                          });
                        },
                        child: Ink(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.undo,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(
            height: 12,
          ),
          if (widget.spokenPatternExample.userAnswer == null)
            Align(
              alignment: Alignment.center,
              child: WordChips(
                englishText: widget.spokenPatternExample.words ??
                    widget.spokenPatternExample.englishText,
                controller: _userAnswerController,
                usedWordIndices: _usedWordIndices,
                onTap: () => setState(() {}),
                markWordUsed: (word, index) {
                  setState(() {
                    _usedWordIndices.add(index);
                    _usedOrder.add(index);
                  });
                },
              ),
            ),
          if (widget.spokenPatternExample.userAnswer == null)
            const SizedBox(
              height: 12,
            ),
          if (widget.spokenPatternExample.userAnswer == null)
            Material(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF2C5364),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  // widget.onDone();
                  final answer = _userAnswerController.text.trim();
                  if (answer.isNotEmpty) {
                    _userAnswerController.text = answer;
                    widget.onAnswerChanged
                        .call(widget.spokenPatternExample.id, answer);
                  }
                },
                child: SizedBox(
                  height: 42,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Done",
                      style: PmpTextStyles.body1Semi.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<List<PatternVocabulary>> fetchVocabularies() async {
    try {
      final dataRes = await supabase
          .from("pattern_vocabularies")
          .select("*,pattern_examples_vocabularies_relation!inner()")
          .eq("pattern_examples_vocabularies_relation.pattern_example_id",
              widget.spokenPatternExample.id)
          .order("created_at", ascending: true);
      if (dataRes.isEmpty) {
        return <PatternVocabulary>[];
      }

      final patternExercises =
          dataRes.map((e) => PatternVocabulary.fromJson(e)).toList();

      return patternExercises;
    } catch (e) {
      debugPrint('_mapLoadPatternExercisesToState: errror: ${e.toString()}');
      return <PatternVocabulary>[];
    }
  }
}
