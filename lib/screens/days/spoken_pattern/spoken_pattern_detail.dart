import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SpokenPatternDetail extends StatefulWidget {
  const SpokenPatternDetail({
    super.key,
  });

  @override
  State<SpokenPatternDetail> createState() => _SpokenPatternDetailState();
}

class _SpokenPatternDetailState extends State<SpokenPatternDetail> {
  String? _htmlContent;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadHtml();
  }

  Future<void> _loadHtml() async {
    try {
      final html = await rootBundle.loadString(
        'assets/explanation/example_explanation.html',
        cache: false,
      );

      setState(() {
        _htmlContent = html;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load local explanation: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentence Explanation'),
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
                  padding: const EdgeInsets.all(16),
                  child: HtmlWidget(
                    _htmlContent!,
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: 1.8,
                        ),
                  ),
                ),
    );
  }
}
