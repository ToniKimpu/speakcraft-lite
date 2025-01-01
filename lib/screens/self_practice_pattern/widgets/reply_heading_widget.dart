import 'package:flutter/material.dart';
import 'package:pmp_english/model/app_user/app_user.dart';

import '../../../config/pmp_text_styles.dart';

class ReplyHeadingWidget extends StatelessWidget {
  const ReplyHeadingWidget({
    super.key,
    required this.appUser,
    required this.comment,
  });
  final AppUser appUser;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/profiles/${appUser.profilePath}',
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appUser.name,
                style: PmpTextStyles.body2Regular.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                comment,
                style: PmpTextStyles.body2Regular.copyWith(
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
