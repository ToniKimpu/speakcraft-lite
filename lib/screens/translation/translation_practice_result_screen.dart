import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/translation/translation_bloc.dart';
import 'package:pmp_english/model/translation/translation.dart';

import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';

class TranslationPracticeResultScreen extends StatefulWidget {
  const TranslationPracticeResultScreen({
    super.key,
    this.translations,
    this.translationDayId,
  });

  final List<Translation>? translations;
  final int? translationDayId;

  @override
  State<TranslationPracticeResultScreen> createState() =>
      _TranslationPracticeResultScreenState();
}

class _TranslationPracticeResultScreenState
    extends State<TranslationPracticeResultScreen> {
  final _translationBloc = TranslationBloc();
  @override
  void initState() {
    super.initState();
    if (widget.translationDayId != null) {
      _translationBloc.add(
        TranslationEvent.loadUserTranslations(widget.translationDayId!),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (widget.translationDayId != null) {
      return BlocProvider(
        create: (context) => _translationBloc,
        child: BlocBuilder<TranslationBloc, TranslationState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(),
                ),
              ),
              loaded: (translations) {
                if (translations.isEmpty) {
                  return const Center(
                    child: Text('No result'),
                  );
                }
                return _buildResultList(translations);
              },
              orElse: () => Container(),
            );
          },
        ),
      );
    }
    return _buildResultList(widget.translations!);
  }

  _buildResultList(List<Translation> translations) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: translations.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _buildResultItem(
            translations[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 12,
        ),
      ),
    );
  }

  _buildResultItem(Translation translation) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(
          color: PmpColors.neutral10.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Burmese',
                style: PmpTextStyles.body2Semi.copyWith(
                  color: Colors.black,
                ),
              ),
              if (translation.audioPath != null)
                Material(
                  borderRadius: BorderRadius.circular(12),
                  color: PmpColors.primary400,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: const SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Text(
            translation.burmeseText,
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'English',
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
            ),
          ),
          Text(
            translation.englishText,
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Your Answer:',
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
            ),
          ),
          Text(
            translation.userAnswer ?? "-",
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
