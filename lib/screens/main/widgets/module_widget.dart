import 'package:flutter/material.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_text_styles.dart';

class ModuleWidget extends StatelessWidget {
  const ModuleWidget({
    super.key,
    required this.title,
    required this.label1,
    required this.label2,
    required this.onPressed,
  });
  final String title;
  final String label1, label2;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: PmpColors.white,
        border: Border.all(
          color: PmpColors.neutral10.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: PmpTextStyles.body1Regular.copyWith(
              color: PmpColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.black.withOpacity(0.1),
            margin: const EdgeInsets.symmetric(vertical: 12),
          ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  label1,
                  style:
                      PmpTextStyles.body2Regular.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  label2,
                  style:
                      PmpTextStyles.body2Regular.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
          // const SizedBox(
          //   height: 16,
          // ),
          // LinearProgressIndicator(
          //   color: Colors.green,
          //   value: 0.6,
          //   minHeight: 8,
          //   borderRadius: BorderRadius.circular(8),
          // ),
          // const SizedBox(
          //   height: 6,
          // ),
          // Text(
          //   'Completed - 6/10',
          //   style: PmpTextStyles.caption.copyWith(
          //     color: Colors.black,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),

          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () => onPressed(),
              child: const Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('Start'),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
