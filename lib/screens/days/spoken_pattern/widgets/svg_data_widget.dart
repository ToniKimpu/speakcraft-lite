import 'package:flutter/material.dart';

import '../../../../config/pmp_text_styles.dart';
import '../../../../model/spoken_pattern/spoken_pattern.dart';

class SubjectVerbAgreementCard extends StatefulWidget {
  const SubjectVerbAgreementCard({
    super.key,
    required this.spokenPattern,
  });

  final SpokenPattern spokenPattern;

  @override
  State<SubjectVerbAgreementCard> createState() =>
      _SubjectVerbAgreementCardState();
}

class _SubjectVerbAgreementCardState extends State<SubjectVerbAgreementCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final svgData = widget.spokenPattern.subjectVerbAgreement != null &&
        widget.spokenPattern.subjectVerbAgreement!.svgData.isNotEmpty;

    if (!svgData) {
      return const SizedBox();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Header (tap to expand/collapse)
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              setState(() => _expanded = !_expanded);
            },
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Subject Verb Agreement',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontFamily: 'ArchivoBlack Regular',
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: _expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          /// 🔹 Divider (only when expanded)
          if (_expanded) ...[
            const SizedBox(height: 8),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.white.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 8),
          ],

          /// 🔹 Collapsible Content
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                widget.spokenPattern.subjectVerbAgreement!.svgData.length,
                (index) {
                  final data =
                      widget.spokenPattern.subjectVerbAgreement!.svgData[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            data,
                            style: PmpTextStyles.body2Semi
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            secondChild: const SizedBox(),
          ),
        ],
      ),
    );
  }
}
