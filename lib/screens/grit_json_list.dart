import 'dart:convert';

import 'package:flutter/material.dart';

class GritJsonList extends StatefulWidget {
  const GritJsonList({
    super.key,
    this.assetFolder = 'assets/grit/',
    this.title = 'Grit — JSON Files',
  });

  final String assetFolder;
  final String title;

  @override
  State<GritJsonList> createState() => _GritJsonListState();
}

class _GritJsonListState extends State<GritJsonList> {
  List<String> _files = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifest = json.decode(manifestContent);

    final files = manifest.keys
        .where((k) =>
            k.startsWith(widget.assetFolder) &&
            k.toLowerCase().endsWith('.json'))
        .toList()
      ..sort();

    if (mounted) {
      setState(() {
        _files = files;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _files.isEmpty
              ? Center(
                  child:
                      Text('No JSON files found in ${widget.assetFolder}'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _files.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final path = _files[index];
                    final name = path.split('/').last.replaceAll('.json', '');
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: colorScheme.outlineVariant,
                        ),
                      ),
                      leading: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                      title: Text(
                        name,
                        style: const TextStyle(fontSize: 13),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/grit_json_preview',
                          arguments: {'assetPath': path},
                        );
                      },
                    );
                  },
                ),
    );
  }
}
