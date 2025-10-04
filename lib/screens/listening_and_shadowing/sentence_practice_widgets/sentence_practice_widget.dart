import 'package:flutter/material.dart';
import 'package:pmp_english/screens/listening_and_shadowing/model/subtitle_line.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../shared_widgets/practice_text_field.dart';
import '../model/sentence_check_result.dart';

class SentencePracticeWidget extends StatefulWidget {
  const SentencePracticeWidget({
    super.key,
    required this.subtitleLine,
    required this.onListenAudio,
    required this.controller,
  });
  final SubtitleLine subtitleLine;
  final Function(Duration start, Duration end) onListenAudio;
  final YoutubePlayerController controller;

  @override
  State<SentencePracticeWidget> createState() => _SentencePracticeWidgetState();
}

class _SentencePracticeWidgetState extends State<SentencePracticeWidget> {
  final _userAnswerController = TextEditingController();
  final _wordVisibleNotifier = ValueNotifier<bool>(false);

  @override
  initState() {
    super.initState();
    _userAnswerController.text = widget.subtitleLine.text;
  }

  @override
  dispose() {
    super.dispose();
    _userAnswerController.dispose();
    _wordVisibleNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: const Text(
                  "ကျွန်မ အသက် ၂၇ နှစ်အရွယ်မှာ အရမ်းပင်ပန်းတဲ့ စီမံခန့်ခွဲမှုဆိုင်ရာ အကြံပေးအလုပ်ကနေ ပိုပြီးတောင် ပင်ပန်းတဲ့ “ဆရာမ” အလုပ်ကို ပြောင်းခဲ့ပါတယ်။",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
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
                color: const Color(0xFF2C5364),
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    debugPrint(
                        "_sentencePracticeWidgetLogs: ${widget.controller.value.isReady} is Ready!");
                    debugPrint(
                        "_sentencePracticeWidgetLogs: $loading loading!");
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
                  child: SizedBox(
                    height: 52,
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
                            backgroundColor: Colors.blue,
                            child: loading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
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
                                    color: Colors.white,
                                  ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            "Listen Audio",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
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
                  hintText: "Type your answer here...",
                  englishOnly: true,
                  minLines: 3,
                  maxLines: 8,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.amber,
                    fontFamily: 'ArchivoBlack Regular',
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Error suggestion box
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Check spelling: 'evennn' → Did you mean 'even'?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.redAccent,
                          height: 1.4,
                          fontFamily: 'ArchivoBlack Regular',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Done Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'ArchivoBlack Regular',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Word chips toggle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text(
                      'Words',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'ArchivoBlack Regular',
                      ),
                    ),
                    const SizedBox(width: 8),
                    ValueListenableBuilder<bool>(
                      valueListenable: _wordVisibleNotifier,
                      builder: (_, showWords, __) => Transform.scale(
                        scale: 0.75,
                        child: Switch(
                          value: showWords,
                          onChanged: (v) => _wordVisibleNotifier.value = v,
                          activeColor: Colors.white,
                          inactiveThumbColor:
                              Colors.white.withValues(alpha: 0.8),
                          activeTrackColor: Colors.green,
                          inactiveTrackColor:
                              Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Word chips
              ValueListenableBuilder<bool>(
                valueListenable: _wordVisibleNotifier,
                builder: (_, showWords, __) {
                  if (!showWords) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.subtitleLine.text
                          .trim()
                          .split(' ')
                          .map((word) {
                        return ActionChip(
                          label: Text(
                            word,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.blue,
                          onPressed: () {
                            final current = _userAnswerController.text.trim();
                            _userAnswerController.text =
                                current.isEmpty ? word : "$current $word";
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
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
    debugPrint(
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
