import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'grammar_explanation_json_view.dart';

/// Debug screen: lists all local spoken_patterns JSON assets for testing.
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
        .where((k) => k.startsWith('assets/spoken_patterns/') && k.endsWith('.json'))
        .toList()
      ..sort();

    final entries = <_AssetEntry>[];
    for (final key in keys) {
      final parts = key.split('/');
      // assets/spoken_patterns/day_01/want_to.json
      if (parts.length >= 4) {
        entries.add(_AssetEntry(
          dayFolder: parts[2],
          fileName: parts[3].replaceAll('.json', ''),
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
                    '${entry.dayFolder} / ${entry.fileName}',
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                  trailing: Icon(Icons.chevron_right,
                      color: colorScheme.onSurfaceVariant),
                  onTap: () => _openPattern(entry),
                );
              },
            ),
    );
  }

  void _openPattern(_AssetEntry entry) {
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
  Map<String, dynamic>? _data;

  @override
  void initState() {
    super.initState();
    _loadJson();
  }

  Future<void> _loadJson() async {
    final raw = await rootBundle.loadString(widget.entry.assetPath);
    setState(() => _data = json.decode(raw) as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entry.fileName),
      ),
      body: _data == null
          ? const Center(child: CircularProgressIndicator())
          : GrammarExplanationJsonView(
              pattern: _data!['pattern'] as String? ?? '',
              sections: (_data!['sections'] as List<dynamic>?) ?? [],
            ),
    );
  }
}

class _AssetEntry {
  final String dayFolder;
  final String fileName;
  final String assetPath;
  const _AssetEntry({
    required this.dayFolder,
    required this.fileName,
    required this.assetPath,
  });
}
