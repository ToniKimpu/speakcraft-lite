import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

class CheckingUserAnswersDialog extends StatelessWidget {
  const CheckingUserAnswersDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF203A43),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 2,
            color: Colors.white,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              "Checking your answers",
              style: PmpTextStyles.body1Regular.copyWith(
                color: Colors.white,
                fontFamily: 'ArchivoBlack Regular',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
