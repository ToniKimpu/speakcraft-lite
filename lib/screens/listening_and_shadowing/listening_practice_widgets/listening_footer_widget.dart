import 'package:flutter/material.dart';
import 'package:pmp_english/model/listening_question/listening_question.dart';
import 'package:pmp_english/screens/listening_and_shadowing/model/subtitle_line.dart';

import '../../../../config/pmp_text_styles.dart';

class ListeningFooterWidget extends StatelessWidget {
  final List<ListeningQuestion> listeningQuestions;
  final int currentPage;
  final Function(int index, bool previous) onPageChanged;
  final bool nextEnabled;

  const ListeningFooterWidget({
    super.key,
    required this.listeningQuestions,
    required this.currentPage,
    required this.onPageChanged,
    required this.nextEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFF1C2C3C),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildPreviousButton(),
            _buildProgressIndicator(),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviousButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: currentPage <= 0
          ? null
          : () {
              // audioPlayer.stop();
              onPageChanged(currentPage - 1, true);
            },
      child: Ink(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: currentPage == 0 ? Colors.grey : Colors.blue,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.chevron_left,
          color: currentPage == 0 ? Colors.black38 : Colors.white,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            spreadRadius: 3,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        '${currentPage + 1}/${listeningQuestions.length}',
        style: PmpTextStyles.body2Semi.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(1, 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    final totalPatterns = listeningQuestions.length - 1;
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: (currentPage >= totalPatterns || !nextEnabled)
          ? null
          : () {
              // audioPlayer.stop();
              onPageChanged(currentPage + 1, false);
            },
      child: Ink(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: (currentPage >= totalPatterns || !nextEnabled)
              ? Colors.grey
              : Colors.blue,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          Icons.chevron_right,
          color: (currentPage >= totalPatterns || !nextEnabled)
              ? Colors.black38
              : Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
