import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

import '../l10n/generated/l10n.dart';

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
                    PmpTextStyles.body1Regular.copyWith(color: PmpColors.black),
              ),
              if (subMessage.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  subMessage,
                  style: PmpTextStyles.body2Medium
                      .copyWith(color: PmpColors.black),
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
}

extension DurationExtension on Duration {
  String formatDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(inMinutes.remainder(60));
    final seconds = twoDigits(inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
