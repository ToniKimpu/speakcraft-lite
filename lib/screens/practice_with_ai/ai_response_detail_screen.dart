import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/model/ai_sentence_practice/ai_sentence_practice.dart';

import '../../bloc/ai_sentence_practice/ai_sentence_practice_bloc.dart';
import 'widgets/ai_response_card.dart';

class AiResponseDetailScreen extends StatefulWidget {
  const AiResponseDetailScreen({
    super.key,
    required this.aiSentencePractice,
  });
  final AiSentencePractice aiSentencePractice;

  @override
  State<AiResponseDetailScreen> createState() => _AiResponseDetailScreenState();
}

class _AiResponseDetailScreenState extends State<AiResponseDetailScreen> {
  final _aiSentencePracticeBloc = AiSentencePracticeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _aiSentencePracticeBloc,
      child: BlocConsumer<AiSentencePracticeBloc, AiSentencePracticeState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (data) {
              Navigator.of(context).pop(true);
            },
            orElse: () => -1,
          );
        },
        builder: (context, state) {
          final isLoading =
              state.maybeWhen(loading: (_) => true, orElse: () => false);
          return Scaffold(
            appBar: AppBar(
              title: const Text('AI Response Detail'),
              actions: [
                if (!isLoading)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    iconSize: 20,
                    onPressed: () {
                      _aiSentencePracticeBloc.add(
                        AiSentencePracticeEvent.delete(
                            widget.aiSentencePractice),
                      );
                    },
                  ),
                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: AiReponseCard(
                aiSentencePractice: widget.aiSentencePractice,
              ),
            ),
          );
        },
      ),
    );
  }
}
