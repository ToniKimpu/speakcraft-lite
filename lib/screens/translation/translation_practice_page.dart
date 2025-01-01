import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/translate_user_answer/translate_user_answer_bloc.dart';
import 'package:pmp_english/bloc/translation/translation_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/translation/translation.dart';
import 'package:pmp_english/model/translation_day/translation_day.dart';
import 'package:pmp_english/screens/translation/widgets/practice_translation_widget.dart';

import '../../bloc/translation_day/translation_day_bloc.dart';
import '../../config/pmp_routes.dart';

class TranslationPracticePage extends StatefulWidget {
  const TranslationPracticePage({
    super.key,
    required this.translationDay,
  });
  final TranslationDay translationDay;

  @override
  State<TranslationPracticePage> createState() =>
      _TranslationPracticePageState();
}

class _TranslationPracticePageState extends State<TranslationPracticePage> {
  late final TranslationBloc _translationBloc;
  late final TranslateUserAnswerBloc _userAnswerBloc;
  late final ValueNotifier<String?> _userAnswer;
  late List<FocusNode> _translationNodes;

  final List<Translation> _userTranslations = [];
  int _currentPage = 0;
  int totalPage = 0;

  @override
  void initState() {
    super.initState();
    _translationBloc = TranslationBloc()
      ..add(TranslationEvent.loadTranslations(widget.translationDay.id));
    _userAnswerBloc = TranslateUserAnswerBloc();
    _userAnswer = ValueNotifier<String?>(null);
    _translationNodes = [];
  }

  @override
  void dispose() {
    for (var node in _translationNodes) {
      node.dispose();
    }
    _userAnswer.dispose();
    super.dispose();
  }

  void _handlePageChange(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  void _addUserAnswer(Translation translation, String? answer) {
    if (answer == null) return;
    // FocusManager.instance.primaryFocus?.unfocus();
    _addOrUpdateExercise(translation, answer);
    if (_currentPage < totalPage - 1) {
      _handlePageChange(_currentPage + 1);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _userAnswer.value = null;
      });
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      debugPrint("_userTranslations: ${_userTranslations.length} Length!");
      for (final userTranslation in _userTranslations) {
        debugPrint(
            "_userTranslations: ${userTranslation.userAnswer} user Answer!");
      }
      _userAnswerBloc.add(
        TranslateUserAnswerEvent.addTranslateUserAnswerList(
          _userTranslations,
          widget.translationDay.id,
        ),
      );
    }
  }

  void _addOrUpdateExercise(Translation translation, String answer) {
    final index = _userTranslations.indexWhere((e) => e.id == translation.id);

    if (index != -1) {
      _userTranslations[index] =
          _userTranslations[index].copyWith(userAnswer: answer);
    } else {
      _userTranslations.add(translation.copyWith(userAnswer: answer));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_currentPage > 0) {
          setState(() {
            _currentPage--;
          });
          return;
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Translation Practice'),
        ),
        body: BlocListener<TranslateUserAnswerBloc, TranslateUserAnswerState>(
          bloc: _userAnswerBloc,
          listener: (context, state) {
            state.maybeWhen(
              loading: () {
                context.showLoadingDialog();
              },
              onSuccess: () {
                context.hideLoadingDialog();
                context
                    .read<TranslationDayBloc>()
                    .add(const TranslationDayEvent.loadTranslationDays(1));
                Navigator.pushReplacementNamed(
                  context,
                  PmpRoutes.translationPracticeResultScreen,
                  arguments: {
                    'translations': _userTranslations,
                  },
                );
              },
              orElse: () {
                context.hideLoadingDialog();
                _userTranslations.clear();
              },
            );
          },
          child: BlocBuilder<TranslationBloc, TranslationState>(
            bloc: _translationBloc,
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(),
                  ),
                ),
                loaded: (translations) =>
                    _buildTranslationsContent(translations),
                orElse: () => const SizedBox(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTranslationsContent(List<Translation> translations) {
    totalPage = translations.length;
    if (translations.isEmpty) {
      return Center(
        child: Text(
          "(မကြာခင် တင်ပေးပါမည်)",
          style: PmpTextStyles.body1Regular.copyWith(color: Colors.black),
        ),
      );
    }
    // Initialize FocusNodes only once
    if (_translationNodes.isEmpty) {
      _translationNodes =
          List.generate(translations.length, (_) => FocusNode());
    }
    return Column(
      children: [
        Expanded(
          child: _buildExercisePageView(translations),
        ),
        _buildFooter(translations),
      ],
    );
  }

  Widget _buildExercisePageView(List<Translation> translations) {
    return IndexedStack(
      index: _currentPage,
      children: List.generate(translations.length, (index) {
        if (index == _currentPage) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _translationNodes[index].requestFocus();
          });
        }
        return PracticeTranslationWidget(
          focusNode: _translationNodes[index],
          translation: translations[index],
          onUserInput: (value) => _userAnswer.value = value,
        );
      }),
    );
  }

  Widget _buildFooter(List<Translation> translations) {
    return Container(
      width: double.infinity,
      height: 48,
      color: PmpColors.primary400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPreviousButton(),
          _buildProgressIndicator(translations.length),
          _buildNextButton(translations),
        ],
      ),
    );
  }

  Widget _buildPreviousButton() {
    return IconButton(
      onPressed: _currentPage > 0
          ? () {
              _userAnswer.value =
                  _userTranslations[_currentPage - 1].userAnswer;
              _handlePageChange(_currentPage - 1);
            }
          : null,
      icon: Icon(
        Icons.chevron_left,
        color: _currentPage == 0 ? Colors.grey : Colors.white,
      ),
    );
  }

  Widget _buildProgressIndicator(int totalExercises) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: const BoxDecoration(
        color: PmpColors.primary400,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Text(
        '${_currentPage + 1}/$totalExercises',
        style: PmpTextStyles.body1Semi.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildNextButton(List<Translation> translations) {
    return ValueListenableBuilder<String?>(
      valueListenable: _userAnswer,
      builder: (context, userAnswer, child) {
        return IconButton(
          onPressed: userAnswer == null
              ? null
              : () => _addUserAnswer(translations[_currentPage], userAnswer),
          icon: Icon(
            Icons.chevron_right,
            color: userAnswer == null ? Colors.grey : Colors.white,
          ),
        );
      },
    );
  }
}
