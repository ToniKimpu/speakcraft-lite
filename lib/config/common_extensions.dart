import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/services/supabase_service.dart';

import '../l10n/generated/l10n.dart';
import '../model/subtitle/subtitle.dart';

extension AiduPlayStateExtension on State {
  showSnackbar(String msg, Color textColor, Color bgColor) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: bgColor,
        closeIconColor: PmpColors.white,
        showCloseIcon: true,
      ));
  }

  showErrorSnackbar(String msg) {
    showSnackbar(msg, PmpColors.white, PmpColors.red);
  }

  showSuccessSnackbar(String msg) {
    showSnackbar(msg, PmpColors.white, PmpColors.primary400);
  }
}

extension LoadingDialogExtension on BuildContext {
  void showLoadingDialog({
    String message = 'Loading...',
    String subMessage = '',
  }) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => LoadingDialog(
        message: message,
        subMessage: subMessage,
      ),
    );
  }

  void hideLoadingDialog() {
    Navigator.of(this).pop();
  }

  Future showSimpleAlertDialog({
    required String title,
    required String message,
  }) {
    return showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          titleTextStyle: PmpTextStyles.body1Semi.copyWith(
            color: PmpColors.neutral100,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          contentTextStyle: PmpTextStyles.body2Regular.copyWith(
            color: PmpColors.neutral400,
          ),
          backgroundColor: PmpColors.neutral900,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          contentPadding: const EdgeInsets.all(16),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.all(8),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: OutlinedButton.styleFrom(
                  foregroundColor: PmpColors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: PmpColors.neutral800,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  )),
              child: Text(AppLocalizations.of(context).txtOk),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> showConfirmationAlertDialog(
      {required String title, required String message}) {
    return showDialog<bool>(
      context: this,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(AppLocalizations.of(context).txtOk),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(AppLocalizations.of(context).txtCancel),
          ),
        ],
      ),
    );
  }

  showAdvanceDialog({
    required Widget dialog,
    bool? isDismissible,
    Function(dynamic value)? onDismiss,
  }) {
    showDialog(
      context: this,
      barrierDismissible: isDismissible ?? false,
      builder: (context) => dialog,
    ).then((value) {
      if (onDismiss != null) {
        onDismiss(value);
      }
    });
  }
}

class LoadingDialog extends StatelessWidget {
  final String message;
  final String subMessage;

  const LoadingDialog(
      {super.key, this.message = 'Loading...', this.subMessage = ''});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Card(
        elevation: 2,
        color: const Color(0xFF1C2C3C),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style:
                    PmpTextStyles.body1Regular.copyWith(color: PmpColors.white),
              ),
              if (subMessage.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  subMessage,
                  style: PmpTextStyles.body2Medium
                      .copyWith(color: PmpColors.white),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String generateAccountID() {
    final random = Random();
    final passcode = List.generate(6, (_) => random.nextInt(10)).join();
    return 'PMP$passcode';
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: this))
        .then((value) => debugPrint('Text copied to clipboard: $this'))
        .catchError(
            (error) => debugPrint('Failed to copy text to clipboard: $error'));
  }
}

extension DurationExtension on Duration {
  String formatDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(inMinutes.remainder(60));
    final seconds = twoDigits(inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

Future<List<Subtitle>> parseJsonSubtitleFile(String fileUrl) async {
  const double fixedHeight = 112.0;
  double scrollPosition = 0;
  debugPrint("_parseJsonSubtitleFile: $fileUrl file Url!");
  try {
    final response = await http.get(Uri.parse(fileUrl));
    if (response.statusCode != 200) {
      throw Exception("Failed to load subtitles: ${response.statusCode}");
    }
    final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));
    debugPrint("_parseJsonSubtitleFile: ${jsonList.first.toString()} lenght!");
    final List<Subtitle> subtitles = [];

    for (int i = 0; i < jsonList.length; i++) {
      final jsonItem = jsonList[i];
      final startDuration = _parseJsonDuration(jsonItem['start']);
      final endDuration = _parseJsonDuration(jsonItem['end']);

      subtitles.add(
        Subtitle(
          id: jsonItem['id'],
          english: jsonItem['english'] ?? '',
          burmese: jsonItem['burmese'],
          description: jsonItem['description'],
          audioName: jsonItem["audioName"] == null
              ? ""
              : supabase.storage.from("contents").getPublicUrl(
                    "${SupabaseBucketFolders.listeningAndShadowingAudios.name}/${jsonItem["audioName"] as String}",
                  ),
          start: startDuration,
          end: endDuration,
          scrollPosition: i < 2 ? 0 : scrollPosition,
          vocabularies: (jsonItem['vocabulary'] as List<dynamic>?)
              ?.map((vocabJson) => SubtitleVocabulary.fromJson(vocabJson))
              .toList(),
        ),
      );

      if (i >= 1) {
        scrollPosition += fixedHeight;
      }
    }

    debugPrint("_subtitleInfo: ${subtitles.length} loaded!");
    return subtitles;
  } catch (e) {
    debugPrint(
        "_parseJsonSubtitleFile: error:  Error parsing subtitle JSON file: $e");
    return <Subtitle>[];
  }
}

Duration _parseJsonDuration(String time) {
  final parts = time.split(':'); // [hh, mm, ss.mmm]
  final hours = int.parse(parts[0]);
  final minutes = int.parse(parts[1]);

  final secParts = parts[2].split('.');
  final seconds = int.parse(secParts[0]);
  final milliseconds =
      int.parse(secParts[1].padRight(3, '0')); // ensure 3 digits

  return Duration(
    hours: hours,
    minutes: minutes,
    seconds: seconds,
    milliseconds: milliseconds,
  );
}
