import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/ai_sentence_practice/ai_sentence_practice_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:pmp_english/config/pmp_routes.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/core/di/service_locator.dart';
import 'package:pmp_english/model/app_user/app_user.dart';
import 'package:pmp_english/screens/practice_with_ai/pages/ai_response_list.dart';
import 'package:pmp_english/screens/practice_with_ai/pages/user_correct_list.dart';
import 'package:pmp_english/screens/practice_with_ai/widgets/ai_practice_tab_selector.dart';
import 'package:pmp_english/shared_widgets/main_scaffold.dart';

class AiSentencePracticeListScreen extends StatefulWidget {
  const AiSentencePracticeListScreen({super.key});

  @override
  State<AiSentencePracticeListScreen> createState() =>
      _AiSentencePracticeListScreenState();
}

enum AiSentenceTabs {
  aiResponse,
  correct,
}

class _AiSentencePracticeListScreenState
    extends State<AiSentencePracticeListScreen> {
  final _aiResponseBloc = AiSentencePracticeBloc();
  final _aiCorrectResponseBloc = AiSentencePracticeBloc();
  AiSentenceTabs _aiSentenceTab = AiSentenceTabs.aiResponse;

  @override
  void initState() {
    super.initState();
    _aiResponseBloc.add(const AiSentencePracticeEvent.loadGroupData(false));
    _aiCorrectResponseBloc
        .add(const AiSentencePracticeEvent.loadGroupData(true));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _aiResponseBloc,
        ),
        BlocProvider(
          create: (context) => _aiCorrectResponseBloc,
        ),
      ],
      child: MainScaffold(
          appBar: AppBar(
            title: const Text('AI Practice'),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.blue,
            onPressed: () async {
              if (!(sl<ValueNotifier<AppUser>>().value.totalTokenUsed < 500000)) {
                showErrorSnackbar("You don't have enough tokens");
                return;
              }
              await Navigator.pushNamed(
                context,
                PmpRoutes.aiPracticeScreen,
              );
              _reloadAll();
            },
            label: Text(
              "Practice Now",
              style: PmpTextStyles.body2Semi.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              children: [
                AiPracticeTabSelector(
                  currentTabIndex: _aiSentenceTab.index,
                  onTabChanged: (index) {
                    setState(() {
                      _aiSentenceTab = index == 0
                          ? AiSentenceTabs.aiResponse
                          : AiSentenceTabs.correct;
                    });
                  },
                ),
                Expanded(
                  child: IndexedStack(
                    index: _aiSentenceTab.index,
                    children: [
                      AiReponseList(
                        aiSentencePracticeBloc: _aiResponseBloc,
                        onNeedReload: _reloadAll,
                      ),
                      UserCorrectList(
                        aiSentencePracticeBloc: _aiCorrectResponseBloc,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  void _reloadAll() {
    _aiResponseBloc
        .add(const AiSentencePracticeEvent.loadGroupData(false));
    _aiCorrectResponseBloc
        .add(const AiSentencePracticeEvent.loadGroupData(true));
  }
}
