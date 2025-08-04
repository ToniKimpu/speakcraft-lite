import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/listening/listening.dart';

import '../../../bloc/subtitle_detail/subtitle_detail_bloc.dart';
import '../../../model/subtitle/subtitle.dart';

class LyricsWidget extends StatefulWidget {
  const LyricsWidget({
    super.key,
    required this.subtitleParsingBloc,
    required this.selectedSubtitle,
    required this.mainController,
    required this.listening,
    required this.getSubtitleBoxHeights,
    required this.onTap,
    required this.enableMMSub,
  });
  final SubtitleBloc subtitleParsingBloc;
  final Subtitle selectedSubtitle;
  final Listening listening;
  final ScrollController mainController;
  final Function(Subtitle subtitle) onTap;
  final Function(List<Subtitle> subtitles) getSubtitleBoxHeights;
  final bool enableMMSub;

  @override
  State<LyricsWidget> createState() => _LyricsWidgetState();
}

class _LyricsWidgetState extends State<LyricsWidget> {
  final _lyrickeys = <GlobalKey>[];

  @override
  void initState() {
    super.initState();
  }

  void _calculateHeights(List<Subtitle> subtitles) {
    double offset = 0;
    final updatedSubtitles = <Subtitle>[];

    for (int i = 0; i < subtitles.length; i++) {
      final key = _lyrickeys[i];
      final context = key.currentContext;

      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final height = box.size.height;

        final updated = subtitles[i].copyWith(
          widgetHeight: height,
          scrollPosition: i == 0 ? 0.0 : offset,
        );
        updatedSubtitles.add(updated);

        if (i != 0) {
          offset += height + 12;
        }
      }
    }

    debugPrint(
        "_subtitleDetailparseInfo: ${updatedSubtitles.length} length from updated");

    widget.subtitleParsingBloc
        .add(SubtitleEvent.parseComplete(updatedSubtitles));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubtitleBloc, SubtitleState>(
      bloc: widget.subtitleParsingBloc,
      listener: (context, state) {
        state.maybeWhen(
          onParseCompleted: (subtitles) {
            widget.getSubtitleBoxHeights(subtitles);
          },
          orElse: () => -1,
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          onParsingSubtitle: (subtitles) {
            if (subtitles.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            // Ensure _lyrickeys has same length
            if (_lyrickeys.length != subtitles.length) {
              _lyrickeys.clear();
              _lyrickeys
                  .addAll(List.generate(subtitles.length, (_) => GlobalKey()));
            }

            // Delay to next frame so widgets are fully laid out
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _calculateHeights(subtitles);
            });

            return Stack(
              fit: StackFit.expand,
              children: [
                Offstage(
                  offstage: true,
                  child: SingleChildScrollView(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: subtitles.length,
                      itemBuilder: (context, index) {
                        final subtitle = subtitles[index];
                        return AnimatedContainer(
                          key: _lyrickeys[index],
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: const Color(0xFF203A43),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: (0.4)),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () => widget.onTap.call(subtitle),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(minHeight: 112),
                              child: Ink(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        _formatDuration(subtitle.start),
                                        style: PmpTextStyles.subBold
                                            .copyWith(color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        subtitle.english,
                                        style:
                                            PmpTextStyles.body2Regular.copyWith(
                                          color: Colors.white,
                                          fontFamily: "English Lyrics",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                    ),
                  ),
                ),
                const Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          },
          onParseCompleted: (subtitles) {
            return ListView.separated(
              controller: widget.mainController,
              itemCount: subtitles.length,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final subtitle = subtitles[index];
                final selected = subtitle.id == widget.selectedSubtitle.id;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white.withValues(alpha: 0.3)
                        : const Color(0xFF203A43),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: (0.4)),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => widget.onTap.call(subtitle),
                    child: Ink(
                      height: subtitle.widgetHeight,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Text(
                              _formatDuration(subtitle.start),
                              style: PmpTextStyles.subBold
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              subtitle.english,
                              style: PmpTextStyles.body2Regular.copyWith(
                                color: Colors.white,
                                fontFamily: "English Lyrics",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          orElse: () => Container(),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }
}
