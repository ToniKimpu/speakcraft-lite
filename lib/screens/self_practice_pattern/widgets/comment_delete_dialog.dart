import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_colors.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

class CommentDeleteDialog extends StatelessWidget {
  const CommentDeleteDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.all(16),
      surfaceTintColor: PmpColors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delete!',
            style: PmpTextStyles.body1Semi.copyWith(color: Colors.black),
          ),
          Text(
            'Are you sure you want to delete this comment?',
            style: PmpTextStyles.body2Regular,
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: PmpColors.black,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: PmpTextStyles.body2Medium.copyWith(
                          color: PmpColors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Material(
                  borderRadius: BorderRadius.circular(6),
                  color: PmpColors.primary400,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                    child: SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          'Confirm',
                          style: PmpTextStyles.body2Medium.copyWith(
                            color: PmpColors.neutral100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
