import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/translation/translation_bloc.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

import '../../config/pmp_routes.dart';

class TranslationLevelList extends StatefulWidget {
  const TranslationLevelList({super.key});

  @override
  State<TranslationLevelList> createState() => _TranslationLevelListState();
}

class _TranslationLevelListState extends State<TranslationLevelList> {
  final _translationLevelBloc = TranslationBloc();

  @override
  void initState() {
    super.initState();
    _translationLevelBloc.add(const TranslationEvent.loadTranslationLevels());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation Level List'),
      ),
      body: BlocProvider<TranslationBloc>(
        create: (context) => _translationLevelBloc,
        child: BlocBuilder<TranslationBloc, TranslationState>(
          bloc: _translationLevelBloc,
          builder: (context, state) {
            return state.maybeWhen(
              loading: () {
                return const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              translationLevelsLoaded: (translationLevels) {
                if (translationLevels.isEmpty) {
                  return Center(
                    child: Text(
                      'မကြာခင် သင်ခန်းစာများထည့်ပေးပါမည်။',
                      style: PmpTextStyles.body2Semi.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: translationLevels.length,
                  itemBuilder: (context, index) {
                    return TranslationLevelWidget(
                      level: translationLevels[index].levelName,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          PmpRoutes.translationDayList,
                          arguments: {
                            'translation_level_id': translationLevels[index].id,
                          },
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 12,
                  ),
                );
              },
              orElse: () => Container(),
            );
          },
        ),
      ),
    );
  }
}

class TranslationLevelWidget extends StatelessWidget {
  const TranslationLevelWidget({
    super.key,
    required this.onTap,
    required this.level,
  });
  final VoidCallback onTap;
  final String level;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PmpColors.primary400,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onTap.call(),
        child: Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Text(
                level,
                style: PmpTextStyles.body1Semi.copyWith(
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.chevron_right,
                size: 24,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
