import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:speakcraft/core/logger/app_logger.dart';

class HtmlDayList extends StatefulWidget {
  const HtmlDayList({super.key});

  @override
  State<HtmlDayList> createState() => _HtmlDayListState();
}

class _HtmlDayListState extends State<HtmlDayList> {
  Map<String, List<String>> _groupedAssets = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    try {
      // Load the asset manifest to get the list of all assets
      final manifestContent =
          await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final grouped = <String, List<String>>{};

      // Filter for keys starting with assets/days/ and ending with .html
      final keys = manifestMap.keys.where((key) =>
          key.startsWith('assets/days/') &&
          key.toLowerCase().endsWith('.html'));

      for (final key in keys) {
        // Expected format: assets/days/day_xx/filename.html
        final parts = key.split('/');
        if (parts.length >= 4) {
          final dayName = parts[2]; // e.g., day_01
          if (!grouped.containsKey(dayName)) {
            grouped[dayName] = [];
          }
          grouped[dayName]!.add(key);
        }
      }

      // Sort the groups (days)
      final sortedKeys = grouped.keys.toList()..sort();
      final sortedMap = <String, List<String>>{};
      for (final key in sortedKeys) {
        final files = grouped[key]!;
        files.sort(); // Sort files within each day
        sortedMap[key] = files;
      }

      if (mounted) {
        setState(() {
          _groupedAssets = sortedMap;
          _isLoading = false;
        });
      }
    } catch (e) {
      AppLogger.instance.error('Error loading asset manifest: $e', error: e);
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Html Day List',
          style: TextStyle(
            color: Colors.amberAccent,
            fontFamily: 'ArchivoBlack Regular',
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.amberAccent),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _groupedAssets.isEmpty
              ? const Center(
                  child: Text(
                    'No HTML files found in assets/days/',
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _groupedAssets.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final dayKey = _groupedAssets.keys.elementAt(index);
                    final files = _groupedAssets[dayKey]!;

                    // Format display name: day_01 -> DAY 01
                    final displayDay =
                        dayKey.replaceAll('_', ' ').toUpperCase();

                    return Card(
                      elevation: 4,
                      color: Colors.white.withOpacity(0.05),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: ExpansionTile(
                        initiallyExpanded: index == 0,
                        shape: const Border(),
                        collapsedIconColor: Colors.black,
                        iconColor: Colors.black,
                        title: Text(
                          displayDay,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: 'ArchivoBlack Regular',
                            letterSpacing: 1.2,
                          ),
                        ),
                        children: files.map((filePath) {
                          final fileName = filePath.split('/').last;
                          return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.white.withOpacity(0.05),
                                ),
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.article_outlined,
                                  color: Colors.lightBlueAccent,
                                  size: 20,
                                ),
                              ),
                              title: Text(
                                fileName,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                filePath,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: Colors.black.withOpacity(0.3),
                              ),
                              onTap: () {
                                AppLogger.instance.debug('Selected HTML path: $filePath');
                                Navigator.pushNamed(
                                  context,
                                  '/html_preview',
                                  arguments: {
                                    'assetPath': filePath,
                                    'title': fileName,
                                  },
                                );
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
    );
  }
}
