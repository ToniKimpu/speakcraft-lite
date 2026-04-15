import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pmp_english/screens/listening_and_shadowing/sentence_explanation_json_view.dart';

class GritJsonPreview extends StatefulWidget {
  final String assetPath;

  const GritJsonPreview({super.key, required this.assetPath});

  @override
  State<GritJsonPreview> createState() => _GritJsonPreviewState();
}

class _GritJsonPreviewState extends State<GritJsonPreview> {
  Map<String, dynamic>? _data;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final raw = await rootBundle.loadString(widget.assetPath);
    if (mounted) {
      setState(() {
        _data = json.decode(raw) as Map<String, dynamic>;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final title =
        _data?['title'] as String? ?? widget.assetPath.split('/').last;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _data == null
              ? const Center(child: Text('Failed to load'))
              : SentenceExplanationJsonView(data: _data!),
    );
  }
}
