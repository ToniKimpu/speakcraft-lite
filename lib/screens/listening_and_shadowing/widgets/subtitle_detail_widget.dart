import 'package:flutter/material.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

class SubtitleDetailWidget extends StatefulWidget {
  const SubtitleDetailWidget({
    super.key,
    required this.showSubtitleDetail,
  });
  final ValueNotifier<bool> showSubtitleDetail;

  @override
  State<SubtitleDetailWidget> createState() => _SubtitleDetailWidgetState();
}

class _SubtitleDetailWidgetState extends State<SubtitleDetailWidget> {
  bool _streamData = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.showSubtitleDetail,
      builder: (context, show, child) {
        return Offstage(
          offstage: !show,
          child: child!,
        );
      },
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          // padding: const EdgeInsets.only(left: 0, right: 0, top: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF0F2027),
                Color(0xFF203A43),
                Color(0xFF2C5364),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: 0.3), // Slightly stronger shadow
                blurRadius: 12,
                spreadRadius: 6,
              ),
            ],
            border: Border.all(
              color: Colors.white
                  .withValues(alpha: 0.4), // Soft white border for contrast
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Stream',
                          style: PmpTextStyles.body2Semi.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Transform.scale(
                          scale:
                              0.75, // Adjust between 0.6 to 1.0 to fine-tune size
                          child: Switch(
                            value: _streamData,
                            onChanged: (value) {
                              setState(() {
                                _streamData = value;
                              });
                            },
                            activeColor: Colors.white,
                            inactiveThumbColor:
                                Colors.white.withValues(alpha: 0.8),
                            activeTrackColor: Colors.green,
                            inactiveTrackColor:
                                Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.white.withValues(alpha: 0.4),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'I was very young when I live in London.But compared to now, that times is very different.',
                        style: PmpTextStyles.body1Semi.copyWith(
                          color: Colors.white,
                          fontFamily: "English Lyrics",
                        ),
                      ),
                      Text(
                        'လန်ဒန်မှာ ငါနေတုန်းက ငါအရမ်းငယ်သေးတယ်။ ဒါပေမယ့် အခုလက်ရှိနဲ့ ယှည်ကြည့်မယ်ဆိုရင် လန်ဒန်က အရမ်းကွာခြားသွားပါပြီ။',
                        style: PmpTextStyles.body2Regular.copyWith(
                          color: Colors.amber,
                          fontFamily: "MM Lyrics Bold",
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
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
                                      style:
                                          PmpTextStyles.body1Regular.copyWith(
                                        color: Colors.white,
                                        fontFamily: "English Lyrics",
                                      ),
                                    ),
                                    Text(
                                      'အရမ်းကွာခြားသွားပါပြီ အခုနေအထားနဲ့ အရမ်းကွာသွားပါပြီ။',
                                      style:
                                          PmpTextStyles.body2Regular.copyWith(
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
                      const SizedBox(
                        height: 12,
                      ),
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
                                  'အရမ်းကွာခြားသွားပါပြီ',
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
                      const SizedBox(
                        height: 12,
                      ),
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
                                  'အရမ်းကွာခြားသွားပါပြီ',
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
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.white.withValues(alpha: 0.4),
              ),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_left),
                    ),
                    // const SizedBox(width: 4),
                    Text(
                      '100/100',
                      style: PmpTextStyles.labelSemi.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    // const SizedBox(width: 4),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chevron_right,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
