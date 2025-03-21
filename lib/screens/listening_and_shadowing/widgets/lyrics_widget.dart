import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

import '../../../config/common_extensions.dart';
import '../../../model/subtitle/subtitle.dart';

class LyricsWidget extends StatefulWidget {
  const LyricsWidget({
    super.key,
    required this.selectedSubtitle,
    required this.startPosition,
    required this.endPosition,
    required this.mainController,
    required this.getSubtitleBoxHeights,
    required this.onTap,
  });
  final Subtitle selectedSubtitle;
  final int startPosition;
  final int endPosition;
  final ScrollController mainController;
  final Function(Subtitle subtitle) onTap;
  final Function(List<double> subtitleBoxHeights, List<Subtitle> subtitles)
      getSubtitleBoxHeights;

  @override
  State<LyricsWidget> createState() => _LyricsWidgetState();
}

class _LyricsWidgetState extends State<LyricsWidget> {
  late Future<List<Subtitle>> _subtitles;

  final List<GlobalKey> _subtitleKeys = [];
  final List<double> _subtitleBoxHeights = [];
  final List<Subtitle> _subtitleList = [];
  List<Subtitle> _tempSubtitleList = [];

  @override
  void initState() {
    super.initState();
    _subtitles = parseSrtFile(
        "assets/temps/number-one-girl.srt",
        Duration(seconds: widget.startPosition),
        Duration(seconds: widget.endPosition)); // Load from assets
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        double scrollPosition = 0;
        for (int i = 0; i < _subtitleKeys.length; i++) {
          final subtitleBox =
              _subtitleKeys[i].currentContext?.findRenderObject() as RenderBox?;
          if (subtitleBox != null) {
            final subtitleHeight = subtitleBox.size.height;
            _subtitleList.add(_tempSubtitleList[i].copyWith(
              widgetHeight: subtitleHeight,
              scrollPosition: scrollPosition,
            ));
            scrollPosition += subtitleHeight;
            // _subtitleBoxHeights.add(subtitleHeight);
          }
        }
        widget.getSubtitleBoxHeights(_subtitleBoxHeights, _subtitleList);
      });
    });
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
          return const Center(child: Text("No lyrics found"));
        }

        final subtitles = snapshot.data!;
        _tempSubtitleList = snapshot.data!;
        debugPrint(
            "_lyricsWidgetInfo: ${subtitles.length} total subtitle lines");

        for (int i = 0; i < subtitles.length; i++) {
          _subtitleKeys.add(GlobalKey());
        }

        return SingleChildScrollView(
          controller: widget.mainController,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: subtitles.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final subtitle = subtitles[index];
              final selected = subtitle.id == widget.selectedSubtitle.id;
              return ListTile(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
                selected: selected,
                selectedTileColor: const Color(0xFF0F2027),
                tileColor: const Color(0xFF203A43),
                onTap: () => widget.onTap.call(subtitle),
                key: _subtitleKeys[index],
                leading: Text(
                  _formatDuration(subtitle.start),
                  style: PmpTextStyles.body2Semi.copyWith(
                    color: !selected ? PmpColors.white : PmpColors.white,
                  ),
                ),
                title: Text(
                  subtitle.text,
                  style: PmpTextStyles.body2Semi.copyWith(
                    color: !selected ? PmpColors.white : Colors.white,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }
}
