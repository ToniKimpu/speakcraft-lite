import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/ai_sentence_practice/ai_sentence_practice_bloc.dart';
import 'package:pmp_english/bloc/app_ui/app_ui_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/ai_sentence_practice/ai_sentence_practice.dart';
import 'package:pmp_english/screens/practice_with_ai/widgets/ai_reponse_card.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

import '../../shared_widgets/practice_text_field.dart';

class AiPracticeScreen extends StatefulWidget {
  const AiPracticeScreen({super.key});

  @override
  State<AiPracticeScreen> createState() => _AiPracticeScreenState();
}

class _AiPracticeScreenState extends State<AiPracticeScreen> {
  final _aiSentencePracticeBloc = AiSentencePracticeBloc();

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
      child: MainScaffold(
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
                  context
                      .read<AppUIBloc>()
                      .add(const AppUIEvent.reloadAISentencePracticeList());
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
                  Card(
                    elevation: 3,
                    color: const Color(0xFF1C2C3C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Write your own sentence here",
                            style: PmpTextStyles.body2Semi.copyWith(
                              color: PmpColors.white,
                            ),
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
                          InkWell(
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
                                color: PmpColors.primary500,
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
                        ],
                      ),
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
