import 'package:flutter/material.dart';
import 'package:pmp_english/bloc/pattern_user_comment/pattern_user_comment_bloc.dart';
import 'package:pmp_english/bloc/user_comment_reply/user_comment_reply.dart';
import 'package:pmp_english/model/app_user/app_user.dart';

import '../../../config/pmp_text_styles.dart';
import '../../../global_app_state.dart';
import 'comment_delete_dialog.dart';

class ReplyWidget extends StatelessWidget {
  const ReplyWidget({
    super.key,
    required this.appUser,
    required this.reply,
    required this.deleteReplyBloc,
  });
  final AppUser appUser;
  final UserCommentReply reply;

  final PatternUserCommentBloc deleteReplyBloc;

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = appUser.id == GlobalAppState().currentUser.id;
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
                appUser.name ?? appUser.email,
                style: PmpTextStyles.body2Regular.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                reply.reply,
                style: PmpTextStyles.body2Regular.copyWith(
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        if (isCurrentUser)
          Material(
            borderRadius: BorderRadius.circular(100),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const CommentDeleteDialog();
                  },
                ).then(
                  (value) {
                    if (value != null && value) {
                      deleteReplyBloc.add(
                        PatternUserCommentEvent.deleteReply(reply.id),
                      );
                    }
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.delete,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
