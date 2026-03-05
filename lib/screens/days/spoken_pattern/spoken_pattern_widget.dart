import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:http/http.dart' as http;

import '../../../model/spoken_pattern/spoken_pattern.dart';

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
  String? _error;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadHtml();
  }

  Future<void> _loadHtml() async {
    try {
      String url = widget.spokenPattern.filePath ?? "";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to load explanation');
      }
      // ✅ Force UTF-8 decoding (important!)
      final decodedHtml = utf8.decode(response.bodyBytes);

      setState(() {
        _htmlContent = decodedHtml;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: _error != null
          ? Center(
              child: Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
            )
          : _htmlContent == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: HtmlWidget(
                    _htmlContent!,
                    // textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    //       height: 1.8,
                    //     ),
                  ),
                ),
    );
  }
}
