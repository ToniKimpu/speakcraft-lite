import 'package:flutter/material.dart';

class PracticeLabelWidget extends StatelessWidget {
  const PracticeLabelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.checklist_outlined,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 8),
          const Text(
            'Practices',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontFamily: 'ArchivoBlack Regular',
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
        ],
      ),
    );
  }
}
