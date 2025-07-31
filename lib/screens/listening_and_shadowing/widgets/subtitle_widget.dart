import 'package:flutter/material.dart';
import 'package:pmp_english/model/subtitle/subtitle.dart';

import '../../../config/pmp_text_styles.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({
    super.key,
    required this.subtitle,
    required this.hasMMSub,
  });
  final Subtitle subtitle;
  final bool hasMMSub;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle.english,
            style: PmpTextStyles.body1Semi.copyWith(
              color: Colors.white,
              fontFamily: "English Lyrics",
            ),
          ),
          if (hasMMSub)
            Text(
              subtitle.burmese ?? "",
              style: PmpTextStyles.body2Regular.copyWith(
                color: Colors.amber,
                fontFamily: "MM Lyrics Bold",
              ),
            ),
          const SizedBox(
            height: 24,
          ),
          if (!hasMMSub)
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  color: Colors.transparent,
                ),
                child: Text(
                  "ဘာသာပြန်ဆိုချက်နှင့် ရှင်းပြချက်များ ပုံမှန်ထည့်ပေးသွားပါမည်။",
                  style: PmpTextStyles.body2Semi.copyWith(
                    color: Colors.white,
                    fontFamily: "MM Lyrics Bold",
                  ),
                ),
              ),
            ),
          if (hasMMSub)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'much differenct',
                            style: PmpTextStyles.body1Regular.copyWith(
                              color: Colors.white,
                              fontFamily: "English Lyrics",
                            ),
                          ),
                          Text(
                            'အရမ်းကွာခြားသွားပါပြီ အခုနေအထားနဲ့ အရမ်းကွာသွားပါပြီ။',
                            style: PmpTextStyles.body2Regular.copyWith(
                              color: Colors.white,
                              fontFamily: "MM Lyrics Bold",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "(ဒါပေမယ့် အခုလက်ရှိနဲ့ ယှည်ကြည့်မယ်ဆိုရင် လန်ဒန်က အရမ်းကွာခြားသွားပါပြီ။)",
                    style: PmpTextStyles.body2Regular.copyWith(
                      color: Colors.amber,
                      fontFamily: "MM Lyrics Bold",
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
