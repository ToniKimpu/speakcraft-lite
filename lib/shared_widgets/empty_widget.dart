import 'package:flutter/material.dart';

import '../config/pmp_text_styles.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/ic_empty.png",
            width: 200,
            height: 200,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            message,
            style: PmpTextStyles.body1Regular.copyWith(
              color: Colors.white,
              fontSize: 16,
              fontFamily: "ArchivoBlack Regular",
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
