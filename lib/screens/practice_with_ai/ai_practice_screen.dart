import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speakcraft/bloc/ai_sentence_practice/ai_sentence_practice_bloc.dart';
import 'package:speakcraft/config/common_extensions.dart';
import 'package:speakcraft/config/pmp_colors.dart';
import 'package:speakcraft/config/pmp_text_styles.dart';
import 'package:speakcraft/model/ai_sentence_practice/ai_sentence_practice.dart';
import 'package:speakcraft/screens/practice_with_ai/widgets/ai_response_card.dart';

import '../../bloc/user_bloc/user_bloc.dart';
import '../../shared_widgets/practice_text_field.dart';

class AiPracticeScreen extends StatefulWidget {
  const AiPracticeScreen({super.key});

  @override
  State<AiPracticeScreen> createState() => _AiPracticeScreenState();
}

class _AiPracticeScreenState extends State<AiPracticeScreen> {
  final _aiSentencePracticeBloc = AiSentencePracticeBloc();
  final _userBloc = UserBloc();

  late final TextEditingController _sentenceController;
  AiSentencePractice? _aiSentencePractice;

  @override
  initState() {
    super.initState();
    _sentenceController = TextEditingController();
  }

  @override
  void dispose() {
    _sentenceController.dispose();
    _userBloc.close();
    super.dispose();
  }

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: PmpColors.darkSurface,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _aiSentencePracticeBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Practice with AI'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AiSentencePracticeBloc, AiSentencePracticeState>(
            listener: (context, state) {
              state.maybeWhen(
                loading: (message) {
                  _aiSentencePractice = null;
                  setState(() {});
                },
                success: (data) {
                  _sentenceController.clear();
                  _aiSentencePractice = data;
                  setState(() {});
                  _userBloc
                      .add(UserEvent.updateUserToken(data.totalTokensUsed));
                },
                error: (message) {
                  showErrorSnackbar(message);
                },
                orElse: () => -1,
              );
            },
            builder: (context, state) {
              bool isLoading = state.maybeWhen(
                loading: (msg) => true,
                orElse: () => false,
              );
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2)),
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
                        Row(
                          children: [
                            const Icon(
                              Icons.smart_toy,
                              color: PmpColors.warning400,
                              size: 20,
                            ),
                            const SizedBox(
                                width: 8), // spacing between icon and text
                            Text(
                              "Write your own sentence here",
                              style: PmpTextStyles.body2Regular.copyWith(
                                color: PmpColors.warning400,
                                fontFamily: "ArchivoBlack Regular",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        PracticeTextField(
                          controller: _sentenceController,
                          hintText: "",
                          englishOnly: true,
                          minLines: 2,
                          maxLength: 100,
                          maxHeight: 120,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: isLoading
                                ? null
                                : () {
                                    FocusScope.of(context).unfocus();
                                    _aiSentencePracticeBloc.add(
                                      AiSentencePracticeEvent.reviewSentence(
                                        _sentenceController.text.trim(),
                                      ),
                                    );
                                  },
                            child: Ink(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: PmpColors.warning500,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  isLoading ? "Checking..." : "Check Now",
                                  style: PmpTextStyles.body2Semi.copyWith(
                                    color: Colors.white.withValues(
                                        alpha: isLoading ? 0.5 : 1.0),
                                  ),
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
                  if (_aiSentencePractice != null)
                    AiReponseCard(
                      aiSentencePractice: _aiSentencePractice!,
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
