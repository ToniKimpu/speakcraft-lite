import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/pattern/pattern_bloc.dart';
import '../../config/pmp_colors.dart';
import '../../config/pmp_routes.dart';
import '../../config/pmp_text_styles.dart';
import '../../model/pattern/pattern.dart';

class PatternList extends StatefulWidget {
  const PatternList({super.key});

  @override
  State<PatternList> createState() => _PatternListState();
}

class _PatternListState extends State<PatternList> {
  @override
  void initState() {
    super.initState();
    context.read<PatternBloc>().add(const PatternEvent.loadPatterns());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patterns'),
      ),
      body: BlocBuilder<PatternBloc, PatternState>(
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
                itemCount: patterns.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return _buildPatternItem(patterns[index], index + 1);
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
    );
  }

  Widget _buildPatternItem(Pattern pattern, int index) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: PmpColors.white,
        border: Border.all(
          color: PmpColors.neutral10.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "#",
                      style: PmpTextStyles.body1Regular.copyWith(
                        color: PmpColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const WidgetSpan(
                      child: SizedBox(width: 2),
                    ),
                    TextSpan(
                      text: "$index",
                      style: PmpTextStyles.body1Regular.copyWith(
                        color: PmpColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: pattern.hasComment ?? false
                      ? PmpColors.primary400
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.black.withOpacity(0.1),
            margin: const EdgeInsets.symmetric(vertical: 12),
          ),
          Text(
            pattern.pattern,
            style: PmpTextStyles.body2Regular.copyWith(color: Colors.black),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PmpRoutes.patternPracticeScreen,
                    arguments: {
                      'pattern': pattern,
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade100,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Start',
                        style: PmpTextStyles.labelMedium.copyWith(
                          color: Colors.black87,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
