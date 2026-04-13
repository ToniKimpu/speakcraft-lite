import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/core/logger/app_logger.dart';
import 'package:pmp_english/screens/listening_and_shadowing/model/subtitle_line.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../shared_widgets/dialogs/success_dialog.dart';
import '../../../shared_widgets/practice_text_field.dart';
import '../model/sentence_check_result.dart';

class SentencePracticeWidget extends StatefulWidget {
  const SentencePracticeWidget({
    super.key,
    required this.complete,
    required this.subtitleLine,
    required this.onListenAudio,
    required this.controller,
    required this.onDone,
  });
  final bool complete;
  final SubtitleLine subtitleLine;
  final Function(Duration start, Duration end) onListenAudio;
  final YoutubePlayerController controller;
  final Function(bool correct) onDone;

  @override
  State<SentencePracticeWidget> createState() => _SentencePracticeWidgetState();
}

class _SentencePracticeWidgetState extends State<SentencePracticeWidget> {
  final _userAnswerController = TextEditingController();
  final _errorMessageNotifier = ValueNotifier<String?>(null);

  @override
  initState() {
    super.initState();
    if (widget.complete) {
      _userAnswerController.text = widget.subtitleLine.text;
    }
  }

  @override
  dispose() {
    super.dispose();
    _userAnswerController.dispose();
    _errorMessageNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final loading =
        widget.controller.value.playerState == PlayerState.buffering ||
            !widget.controller.value.isReady;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Text(
                  widget.subtitleLine.burmese ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    height: 1.6,
                    fontFamily: 'MM Lyrics Bold',
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),

        // Sticky Listen Audio Card
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Material(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    if (loading) {
                      return;
                    }
                    if (widget.controller.value.isPlaying) {
                      widget.controller.pause();
                      return;
                    }
                    final startDuration = Duration(
                      milliseconds: (widget.subtitleLine.start * 1000).round(),
                    );
                    final endDuration = Duration(
                      milliseconds: (widget.subtitleLine.end * 1000).round(),
                    );
                    widget.onListenAudio.call(startDuration, endDuration);
                  },
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colorScheme.outlineVariant),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: colorScheme.primary,
                            child: loading
                                ? SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      color: colorScheme.onPrimary,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Icon(
                                    (widget.controller.value.playerState ==
                                            PlayerState.ended)
                                        ? Icons.replay
                                        : widget.controller.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                    size: 18,
                                    color: colorScheme.onPrimary,
                                  ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Play Audio',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Practice text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PracticeTextField(
                  controller: _userAnswerController,
                  hintText: "Type what you hear...",
                  englishOnly: true,
                  minLines: 2,
                  maxLines: 8,
                  readOnly: widget.complete,
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: colorScheme.onSurface,
                    fontFamily: 'ArchivoBlack Regular',
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Error suggestion box
              ValueListenableBuilder<String?>(
                  valueListenable: _errorMessageNotifier,
                  builder: (context, errorMessage, child) {
                    if (errorMessage == null) {
                      return const SizedBox();
                    }
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            PmpColors.destructive400.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: PmpColors.destructive400),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.error_outline,
                              color: PmpColors.destructive400, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              errorMessage,
                              style: const TextStyle(
                                fontSize: 14,
                                color: PmpColors.destructive400,
                                height: 1.4,
                                fontFamily: 'ArchivoBlack Regular',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              if (!widget.complete) const SizedBox(height: 24),

              // Done Button
              if (!widget.complete)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: () {
                        if (_userAnswerController.text.isEmpty) {
                          return;
                        }
                        _errorMessageNotifier.value = null;
                        FocusManager.instance.primaryFocus?.unfocus();
                        final sentenceCheckResult = checkSentenceSimple(
                          widget.subtitleLine.text,
                          _userAnswerController.text.trim(),
                        );
                        if (sentenceCheckResult.isCorrect) {
                          widget.onDone.call(true);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const AnimatedSuccessDialog();
                            },
                          );
                          return;
                        }
                        _errorMessageNotifier.value =
                            sentenceCheckResult.message;
                        AppLogger.instance.debug(
                            "_sentenceCheckResultLogs: ${sentenceCheckResult.message} message!");
                      },
                      child: const Text('Done'),
                    ),
                  ),
                ),

              const SizedBox(height: 20),
              // Word chips toggle
              if (!widget.complete)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Words',
                        style: TextStyle(
                          fontSize: 16,
                          color: colorScheme.onSurface,
                          fontFamily: 'ArchivoBlack Regular',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '[Tap what you hear]',
                        style: PmpTextStyles.body2Regular.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontFamily: 'ArchivoBlack Regular',
                        ),
                      ),
                    ],
                  ),
                ),
              // Word chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.subtitleLine.text.trim().split(' ').map(
                    (word) {
                      return ActionChip(
                        label: Text(
                          word,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        side: BorderSide(color: colorScheme.outlineVariant),
                        onPressed: () {
                          final current = _userAnswerController.text.trim();
                          _userAnswerController.text =
                              current.isEmpty ? word : "$current $word";
                        },
                      );
                    },
                  ).toList(),
                ),
              ),

              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }

  SentenceCheckResult checkSentenceSimple(String correct, String userInput) {
    // Normalize: trim, remove extra spaces, ignore final full stop
    String user = userInput.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (user.endsWith('.')) user = user.substring(0, user.length - 1);

    String answer = correct.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (answer.endsWith('.')) answer = answer.substring(0, answer.length - 1);

    // Tokenize: split words but keep punctuation (comma, quotes, etc.)
    List<String> correctWords = _tokenize(answer);
    List<String> userWords = _tokenize(user);

    //Step 1: length check
    AppLogger.instance.debug(
        "_sentenceCheckingResult: ${correctWords.length} total correct words and ${userWords.length} total user words!");
    if (correctWords.length != userWords.length) {
      return SentenceCheckResult(
          isCorrect: false,
          message: "Incorrect sentence ❌ (missing or extra words)");
    }

    // Step 2: compare each token
    for (int i = 0; i < correctWords.length; i++) {
      String cWord = correctWords[i];
      String uWord = userWords[i];

      if (cWord.toLowerCase() != uWord.toLowerCase()) {
        // Special case: missing space after comma
        if (cWord.endsWith(",") &&
            uWord
                .toLowerCase()
                .startsWith(cWord.replaceAll(",", "").toLowerCase())) {
          return SentenceCheckResult(
              isCorrect: false,
              message: "Add a space after the comma near '$cWord'.");
        }

        return SentenceCheckResult(
            isCorrect: false,
            message: "Check '$uWord', did you mean '$cWord'?");
      }
    }

    return SentenceCheckResult(isCorrect: true, message: "Perfect ✅");
  }

  List<String> _tokenize(String text) {
    // Match words, numbers, commas, quotes
    final regex = RegExp("[A-Za-z0-9]+|,|\"|'");
    return regex.allMatches(text).map((m) => m.group(0)!).toList();
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 52;

  @override
  double get maxExtent => 52;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
