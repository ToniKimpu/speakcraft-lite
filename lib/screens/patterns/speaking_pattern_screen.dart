import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/screens/patterns/widgets/pattern_widget.dart';

import '../../bloc/pattern/pattern_bloc.dart';
import '../../config/pmp_colors.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/lesson/lesson.dart';

class SpeakingPatternScreen extends StatefulWidget {
  const SpeakingPatternScreen({
    super.key,
    required this.lesson,
  });
  final Lesson lesson;

  @override
  State<SpeakingPatternScreen> createState() => _SpeakingPatternScreenState();
}

class _SpeakingPatternScreenState extends State<SpeakingPatternScreen> {
  final _patternBloc = PatternBloc();
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _patternBloc.add(const PatternEvent.loadPatternsByLesson(1));
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.lesson.lessonName),
        ),
        body: BlocProvider(
          create: (context) => _patternBloc,
          child: BlocBuilder<PatternBloc, PatternState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () {
                  return const Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                loaded: (patterns) {
                  if (patterns.isEmpty) {
                    return const Center(
                      child: Text('No patterns found'),
                    );
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: IndexedStack(
                          index: _currentPage,
                          children: List.generate(patterns.length, (index) {
                            return PatternWidget(
                              pattern: patterns[index],
                            );
                          }),
                        ),
                      ),
                      _buildFooter(patterns.length),
                    ],
                  );
                },
                orElse: () => Container(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(int totalPatterns) {
    return Container(
      width: double.infinity,
      height: 48,
      color: PmpColors.primary400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPreviousButton(totalPatterns - 1),
          _buildProgressIndicator(totalPatterns),
          _buildNextButton(totalPatterns - 1),
        ],
      ),
    );
  }

  Widget _buildPreviousButton(int totalPatterns) {
    return IconButton(
      onPressed: _currentPage <= 0
          ? null
          : () {
              setState(() {
                _currentPage--;
              });
            },
      icon: Icon(
        Icons.chevron_left,
        color: _currentPage <= 0 ? Colors.grey : Colors.white,
      ),
    );
  }

  Widget _buildProgressIndicator(int totalPatterns) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: const BoxDecoration(
        color: PmpColors.primary400,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Text(
        '${_currentPage + 1}/$totalPatterns',
        style: PmpTextStyles.body1Semi.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildNextButton(int totalPatterns) {
    return IconButton(
      onPressed: _currentPage >= totalPatterns
          ? null
          : () {
              setState(() {
                _currentPage++;
              });
            },
      icon: Icon(
        Icons.chevron_right,
        color: _currentPage >= totalPatterns ? Colors.grey : Colors.white,
      ),
    );
  }
}
