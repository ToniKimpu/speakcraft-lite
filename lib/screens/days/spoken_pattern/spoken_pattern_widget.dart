import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;

import '../../../model/spoken_pattern/spoken_pattern.dart';
import 'grammar_explanation_json_view.dart';

class SpokenPatternWidget extends StatefulWidget {
  const SpokenPatternWidget({
    super.key,
    required this.spokenPattern,
  });

  final SpokenPattern spokenPattern;

  @override
  State<SpokenPatternWidget> createState() => _SpokenPatternWidgetState();
}

class _SpokenPatternWidgetState extends State<SpokenPatternWidget>
    with AutomaticKeepAliveClientMixin {
  String? _htmlContent;
  Map<String, dynamic>? _jsonData;
  String? _error;
  bool _isJson = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final path = widget.spokenPattern.filePath ?? '';
    _isJson = path.endsWith('.json');
    _loadContent();
  }

  Future<void> _loadContent() async {
    try {
      final url = widget.spokenPattern.filePath ?? '';
      if (url.isEmpty) throw Exception('No file path');
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to load explanation');
      }
      final decoded = utf8.decode(response.bodyBytes);

      if (_isJson) {
        setState(() {
          _jsonData = json.decode(decoded) as Map<String, dynamic>;
        });
      } else {
        setState(() {
          _htmlContent = decoded;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colorScheme = Theme.of(context).colorScheme;

    if (_error != null) {
      return Center(
        child: Text(
          _error!,
          style: TextStyle(color: colorScheme.error),
        ),
      );
    }

    if (_isJson) {
      if (_jsonData == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return GrammarExplanationJsonView(
        pattern: _jsonData!['pattern'] as String? ?? '',
        sections: (_jsonData!['sections'] as List<dynamic>?) ?? [],
      );
    }

    // Legacy HTML path
    if (_htmlContent == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: HtmlWidget(_htmlContent!),
      ),
    );
  }
}
