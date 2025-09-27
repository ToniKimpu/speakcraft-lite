import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pmp_english/screens/days/spoken_pattern/widgets/spoken_pattern_examples.dart';

import '../../../bloc/audio_player/audio_player_bloc.dart';
import '../../../config/pmp_text_styles.dart';
import '../../../model/pattern_example/pattern_example.dart';
import '../../../model/spoken_pattern/spoken_pattern.dart';
import 'widgets/spoken_pattern_example.dart';

class SpokenPatternWidget extends StatefulWidget {
  const SpokenPatternWidget({
    super.key,
    required this.audioPlayer,
    required this.spokenPattern,
    required this.audioPositionTrackerBloc,
    required this.audioPlayerStateTrackerBloc,
    required this.onNextEnabledChanged,
  });
  final AudioPlayer audioPlayer;
  final SpokenPattern spokenPattern;
  final AudioPlayerBloc audioPositionTrackerBloc, audioPlayerStateTrackerBloc;
  final Function(int spokenpatternId) onNextEnabledChanged;

  @override
  State<SpokenPatternWidget> createState() => _SpokenPatternWidgetState();
}

class _SpokenPatternWidgetState extends State<SpokenPatternWidget> {
  List<PatternExample> patternExamples = [];
  List<PatternExample> practicePatternExamples = [];

  int _userAnswerCount = 0;

  @override
  initState() {
    super.initState();
    debugPrint("_spokenPatternWidget: spoken pattern widget...");
    patternExamples =
        List.of(widget.spokenPattern.patternExamples ?? <PatternExample>[])
            .where((patternExample) => patternExample.practicable == false)
            .toList()
          ..sort((a, b) {
            final aDate = a.createdAt ?? DateTime(0);
            final bDate = b.createdAt ?? DateTime(0);
            return aDate.compareTo(bDate); // ascending
          });
    practicePatternExamples =
        List.of(widget.spokenPattern.patternExamples ?? <PatternExample>[])
            .where((patternExample) => patternExample.practicable == true)
            .toList()
          ..sort((a, b) {
            final aDate = a.createdAt ?? DateTime(0);
            final bDate = b.createdAt ?? DateTime(0);
            return aDate.compareTo(bDate); // ascending
          });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            // color: Colors.white.withValues(alpha: 0.08),
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.spokenPattern.pattern,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontFamily: "ArchivoBlack Regular",
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (widget.spokenPattern.title != null &&
                            widget.spokenPattern.title!.isNotEmpty)
                          Text(
                            widget.spokenPattern.title!,
                            style: PmpTextStyles.body2Semi.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            spreadRadius: 3,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.pause,
                        color: Colors.blue,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ],
          ),
        ),
        if (patternExamples.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Subject Verb Agreement",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: "ArchivoBlack Regular",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.2),
                                      spreadRadius: 3,
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            widget.spokenPattern.svgData?.length ?? 0,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ), // space between items
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.only(
                                        top: 6), // center the dot with text
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      widget.spokenPattern.svgData![
                                          index], // each string from your JSON array
                                      style: PmpTextStyles.body2Semi
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                      ],
                    ),
                  ),
                  SpokenPatternExamples(
                    patternExamples: patternExamples,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Icon(
                          Icons.checklist_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          "Practices",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontFamily: "ArchivoBlack Regular",
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: practicePatternExamples.length,
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final patternExample = practicePatternExamples[index];
                      return SpokenPatternExample(
                        spokenPatternExample: patternExample,
                        onDone: (count) {
                          _userAnswerCount += 1;
                          if (_userAnswerCount >= patternExamples.length) {
                            widget
                                .onNextEnabledChanged(widget.spokenPattern.id!);
                          }
                          debugPrint(
                              "_userAnswerCount: $_userAnswerCount user answer count!");
                          if (_userAnswerCount >= patternExamples.length) {}
                          debugPrint("Example done pressed!");
                        },
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
