import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'grammar_explanation_json_view.dart';

/// Debug screen: lists all local day_list JSON assets for testing.
class GrammarJsonTestList extends StatefulWidget {
  const GrammarJsonTestList({super.key});

  @override
  State<GrammarJsonTestList> createState() => _GrammarJsonTestListState();
}

class _GrammarJsonTestListState extends State<GrammarJsonTestList> {
  final _assets = <_AssetEntry>[];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAssetManifest();
  }

  Future<void> _loadAssetManifest() async {
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final keys = manifest
        .listAssets()
        .where((k) => k.startsWith('assets/day_list/') && k.endsWith('.json'))
        .toList()
      ..sort();

    final entries = <_AssetEntry>[];
    for (final key in keys) {
      final parts = key.split('/');
      // assets/day_list/day_01/lesson_01.json
      if (parts.length >= 4) {
        entries.add(_AssetEntry(
          dayFolder: parts[2],
          lessonFile: parts[3].replaceAll('.json', ''),
          assetPath: key,
        ));
      }
    }

    setState(() {
      _assets.addAll(entries);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Grammar JSON Test')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: _assets.length,
              padding: const EdgeInsets.symmetric(vertical: 12),
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: colorScheme.outlineVariant),
              itemBuilder: (context, index) {
                final entry = _assets[index];
                return ListTile(
                  title: Text(
                    '${entry.dayFolder} / ${entry.lessonFile}',
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                  trailing: Icon(Icons.chevron_right,
                      color: colorScheme.onSurfaceVariant),
                  onTap: () => _openLesson(entry),
                );
              },
            ),
    );
  }

  void _openLesson(_AssetEntry entry) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _GrammarJsonTestPreview(entry: entry),
      ),
    );
  }
}

class _GrammarJsonTestPreview extends StatefulWidget {
  const _GrammarJsonTestPreview({required this.entry});
  final _AssetEntry entry;

  @override
  State<_GrammarJsonTestPreview> createState() =>
      _GrammarJsonTestPreviewState();
}

class _GrammarJsonTestPreviewState extends State<_GrammarJsonTestPreview> {
  List<dynamic>? _patterns;
  int _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadJson();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadJson() async {
    final raw = await rootBundle.loadString(widget.entry.assetPath);
    setState(() => _patterns = json.decode(raw) as List<dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.entry.dayFolder} / ${widget.entry.lessonFile}'),
      ),
      body: _patterns == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _patterns!.length,
                    onPageChanged: (i) => setState(() => _currentIndex = i),
                    itemBuilder: (_, index) {
                      final p = _patterns![index] as Map<String, dynamic>;
                      return GrammarExplanationJsonView(
                        pattern: p['pattern'] as String? ?? '',
                        sections: (p['sections'] as List<dynamic>?) ?? [],
                      );
                    },
                  ),
                ),
                if (_patterns!.length > 1)
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: _currentIndex > 0
                              ? () => _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  )
                              : null,
                          icon: Icon(Icons.chevron_left,
                              color: cs.onSurface),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: cs.inverseSurface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '${_currentIndex + 1} / ${_patterns!.length}',
                            style: TextStyle(
                              color: cs.onInverseSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _currentIndex < _patterns!.length - 1
                              ? () => _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  )
                              : null,
                          icon: Icon(Icons.chevron_right,
                              color: cs.onSurface),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }
}

class _AssetEntry {
  final String dayFolder;
  final String lessonFile;
  final String assetPath;
  const _AssetEntry({
    required this.dayFolder,
    required this.lessonFile,
    required this.assetPath,
  });
}
