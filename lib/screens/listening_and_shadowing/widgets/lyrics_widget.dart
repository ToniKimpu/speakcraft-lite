import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/listening/listening.dart';

import '../../../config/common_extensions.dart';
import '../../../model/subtitle/subtitle.dart';

class LyricsWidget extends StatefulWidget {
  const LyricsWidget({
    super.key,
    required this.selectedSubtitle,
    required this.mainController,
    required this.listening,
    required this.getSubtitleBoxHeights,
    required this.onTap,
    required this.enableMMSub,
  });
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
  late Future<List<Subtitle>> _subtitles;

  @override
  void initState() {
    super.initState();
    _subtitles = parseSrtFile(
      widget.listening.subtitlePath,
      Duration(seconds: widget.listening.start),
      Duration(seconds: widget.listening.end),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Subtitle>>(
      future: _subtitles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading subtitles"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text(
            "No lyrics found",
            style: PmpTextStyles.body2Semi.copyWith(
              color: Colors.white,
            ),
          ));
        }

        final subtitles = snapshot.data!;
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            widget.getSubtitleBoxHeights(subtitles);
          },
        );
        return ListView.builder(
          controller: widget.mainController,
          itemCount: subtitles.length,
          itemBuilder: (context, index) {
            final subtitle = subtitles[index];
            final selected = subtitle.id == widget.selectedSubtitle.id;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Material(
                color: selected
                    // ? const Color(0xFF0F2027)
                    ? Colors.white.withValues(alpha: 0.3)
                    : const Color(0xFF203A43),
                borderRadius: BorderRadius.circular(12),
                shadowColor: Colors.black.withValues(alpha: 0.4),
                elevation: 6,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => widget.onTap.call(subtitle),
                  child: Ink(
                    height: 100,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(12),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.black.withValues(alpha: 0.4),
                    //       blurRadius: 6,
                    //       offset: const Offset(0, 3),
                    //     ),
                    //   ],
                    // ),
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
                            subtitle.text,
                            style: PmpTextStyles.body2Semi.copyWith(
                              color: Colors.white,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }
}
