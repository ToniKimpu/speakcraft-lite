import 'package:flutter/material.dart';

import '../../../config/common_extensions.dart';
import '../../../model/subtitle/subtitle.dart';

class LyricsWidget extends StatefulWidget {
  const LyricsWidget({super.key});

  @override
  State<LyricsWidget> createState() => _LyricsWidgetState();
}

class _LyricsWidgetState extends State<LyricsWidget> {
  late Future<List<Subtitle>> _subtitles;

  @override
  void initState() {
    super.initState();
    _subtitles =
        parseSrtFile("assets/temps/number-one-girl.srt"); // Load from assets
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

        return ListView.builder(
          itemCount: subtitles.length,
          itemBuilder: (context, index) {
            final subtitle = subtitles[index];
            return ListTile(
              title: Text(
                subtitle.text,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                "${_formatDuration(subtitle.start)} - ${_formatDuration(subtitle.end)}",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
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
