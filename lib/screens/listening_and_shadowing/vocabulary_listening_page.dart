import 'package:flutter/material.dart';

import '../../config/pmp_text_styles.dart';

class VocabularyListeningPage extends StatefulWidget {
  const VocabularyListeningPage({super.key});

  @override
  State<VocabularyListeningPage> createState() =>
      _VocabularyListeningPageState();
}

class _VocabularyListeningPageState extends State<VocabularyListeningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabularies'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 30,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
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
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Demanding job",
                            style: PmpTextStyles.body2Semi
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "အားစိုက်ထုတ်ရသော အလုပ်",
                            style: PmpTextStyles.body2Semi
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    // InkWell(
                    //   borderRadius: BorderRadius.circular(20),
                    //   onTap: () async {},
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(4),
                    //     child: Container(
                    //       width: 18,
                    //       height: 18,
                    //       decoration: BoxDecoration(
                    //         color: Colors.blue,
                    //         shape: BoxShape.circle,
                    //         boxShadow: [
                    //           BoxShadow(
                    //             color: Colors.black.withValues(alpha: 0.2),
                    //             spreadRadius: 3,
                    //             blurRadius: 8,
                    //             offset: const Offset(0, 4),
                    //           ),
                    //         ],
                    //       ),
                    //       child: const Center(
                    //         child: Icon(
                    //           Icons.pause,
                    //           color: Colors.white,
                    //           size: 14,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Demanding job",
                            style: PmpTextStyles.body2Semi
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "အားစိုက်ထုတ်ရသော အလုပ်",
                            style: PmpTextStyles.body2Semi
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () async {},
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Colors.blue,
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
                          child: const Center(
                            child: Icon(
                              Icons.pause,
                              color: Colors.white,
                              size: 14,
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
        },
        separatorBuilder: (_, __) => const SizedBox(
          height: 12,
        ),
      ),
    );
  }
}
