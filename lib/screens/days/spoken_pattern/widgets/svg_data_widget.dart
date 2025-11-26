import 'package:flutter/material.dart';
import 'package:pmp_english/model/spoken_pattern/spoken_pattern.dart';

import '../../../../config/pmp_text_styles.dart';

class SvgDataWidget extends StatelessWidget {
  const SvgDataWidget({
    super.key,
    required this.spokenPattern,
  });
  final SpokenPattern spokenPattern;

  @override
  Widget build(BuildContext context) {
    bool svgData = spokenPattern.subjectVerbAgreement != null &&
        spokenPattern.subjectVerbAgreement!.svgData.isNotEmpty;
    if (!svgData && spokenPattern.description.isEmpty) {
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
          if (spokenPattern.description.isNotEmpty) ...[
            Text(
              '“ ${spokenPattern.description} ”',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontFamily: 'MM Lyrics Bold',
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.indigoAccent,
                  ),
                ],
              ),
            ),
          ],
          if (spokenPattern.description.isEmpty && svgData)
            const Text(
              'Subject Verb Agreement',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontFamily: 'ArchivoBlack Regular',
              ),
            ),
          if (svgData && spokenPattern.description.isNotEmpty) ...[
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ],
          const SizedBox(height: 8),
          if (svgData)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  spokenPattern.subjectVerbAgreement!.svgData.length, (index) {
                final data = spokenPattern.subjectVerbAgreement!.svgData[index];
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
              }),
            ),
        ],
      ),
    );
  }
}
