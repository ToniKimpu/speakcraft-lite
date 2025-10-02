import 'package:flutter/material.dart';
import 'package:pmp_english/shared_widgets/dialogs/success_dialog.dart';

import '../../shared_widgets/practice_text_field.dart';

class ListeningSentencePracticePage extends StatefulWidget {
  const ListeningSentencePracticePage({super.key});

  @override
  State<ListeningSentencePracticePage> createState() =>
      _ListeningSentencePracticePageState();
}

class _ListeningSentencePracticePageState
    extends State<ListeningSentencePracticePage> {
  String englishText =
      "When I was 27 years old, I left a very demanding job in management consulting.";
  final _userAnswerController = TextEditingController();
  final _wordVisibleNotifier = ValueNotifier<bool>(false);

  @override
  initState() {
    super.initState();
    _userAnswerController.text = englishText;
  }

  @override
  dispose() {
    super.dispose();
    _userAnswerController.dispose();
    _wordVisibleNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listening Sentence Practice'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "ကျွန်မ အသက် ၂၇ နှစ်အရွယ်မှာ အရမ်းပင်ပန်းတဲ့ စီမံခန့်ခွဲမှုဆိုင်ရာ အကြံပေးအလုပ်ကနေ ပိုပြီးတောင် ပင်ပန်းတဲ့ “ဆရာမ” အလုပ်ကို ပြောင်းခဲ့ပါတယ်။",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontFamily: 'MM Lyrics Bold',
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
                const Text(
                  "Translate in English",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: 'ArchivoBlack Regular',
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: PracticeTextField(
                controller: _userAnswerController,
                hintText: "type here....",
                englishOnly: true,
                minLines: 2,
                maxLines: 8,
                // maxHeight: 220,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.amber,
                  fontFamily: 'ArchivoBlack Regular',
                ),
              ),
            ),
            // "Check 'evennn', did you mean 'even'?",
            // "Oops! Your sentence is incorrect.\nCheck for missing or extra words.",
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Icon(
            //         Icons.error_outline,
            //         color: Colors.red,
            //         size: 20,
            //       ),
            //       SizedBox(width: 8),
            //       Expanded(
            //         child: Text(
            //           "Check 'evennn', did you mean 'even'?",
            //           style: TextStyle(
            //             fontSize: 14,
            //             color: Colors.redAccent,
            //             height: 1.3,
            //             fontFamily: 'ArchivoBlack Regular',
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: Colors.redAccent,
                          fontFamily: 'ArchivoBlack Regular',
                        ),
                        children: [
                          TextSpan(text: "Check your spelling: "),
                          TextSpan(
                            text: "'evennn'",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber, // highlight the wrong word
                            ),
                          ),
                          TextSpan(text: ", did you mean "),
                          TextSpan(
                            text: "'even'",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .amber, // highlight the correct suggestion
                            ),
                          ),
                          TextSpan(text: "?"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  final sentenceResult = checkSentenceSimple(
                      englishText, _userAnswerController.text);
                  if (sentenceResult.isCorrect) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AnimatedSuccessDialog();
                      },
                    );
                  }
                  debugPrint(
                      "_sentenceCheckingResult: ${sentenceResult.message} message!");
                },
                child: Ink(
                  width: double.infinity,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue,
                  ),
                  child: const Center(
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'ArchivoBlack Regular',
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _wordVisibleNotifier,
              builder: (context, showWords, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    const Text(
                      'Words',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'ArchivoBlack Regular',
                      ),
                    ),
                    const SizedBox(width: 4),
                    Transform.scale(
                      scale: 0.75,
                      child: Switch(
                        padding: EdgeInsets.zero,
                        value: showWords,
                        onChanged: (value) {
                          _wordVisibleNotifier.value = value;
                        },
                        activeColor: Colors.white,
                        inactiveThumbColor: Colors.white.withValues(alpha: 0.8),
                        activeTrackColor: Colors.green,
                        inactiveTrackColor: Colors.white.withValues(alpha: 0.4),
                      ),
                    ),
                  ],
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _wordVisibleNotifier,
              builder: (context, showWords, child) {
                if (!showWords) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: englishText
                        .split(' ')
                        .map(
                          (word) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: wordItem(
                              word,
                              () {
                                final currentText =
                                    _userAnswerController.text.trim();
                                if (currentText.isEmpty) {
                                  _userAnswerController.text = word;
                                } else {
                                  _userAnswerController.text =
                                      "$currentText $word";
                                }
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
                // return Wrap(
                //   runSpacing: 16,
                //   spacing: 16,
                //   children: englishText
                //       .split(' ')
                //       .map(
                //         (e) => Padding(
                //           padding: const EdgeInsets.only(right: 8),
                //           child: wordItem(e),
                //         ),
                //       )
                //       .toList(),
                // );
              },
            ),
            // Container(
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12),
            //     color: const Color(0xFF1C3B2C),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget wordItem(String word, VoidCallback onWordTap) => InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onWordTap.call(),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 40),
          child: Ink(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue,
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              word,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'MM Lyrics Bold',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

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

class SentenceCheckResult {
  final bool isCorrect;
  final String message;
  SentenceCheckResult({required this.isCorrect, required this.message});
}
