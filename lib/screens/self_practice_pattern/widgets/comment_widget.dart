import 'package:flutter/material.dart';
import 'package:pmp_english/bloc/pattern_user_comment/pattern_user_comment_bloc.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/model/pattern_user_comment/pattern_user_comment.dart';
import 'package:pmp_english/screens/self_practice_pattern/widgets/comment_delete_dialog.dart';

import '../../../config/pmp_colors.dart';
import '../../../config/pmp_routes.dart';
import '../../../config/pmp_text_styles.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.comment,
    required this.deleteCommentBloc,
  });

  final PatternUserComment comment;
  final PatternUserCommentBloc deleteCommentBloc;

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = comment.user!.id == GlobalAppState().currentUser.id;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/profiles/${comment.user!.profilePath}',
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.user?.name ?? '',
                style: PmpTextStyles.body2Regular.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                comment.comment,
                style: PmpTextStyles.body2Regular.copyWith(
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.comment,
                      color: PmpColors.primary400,
                      size: 18,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pushNamed(
                        context,
                        PmpRoutes.patternReplyScreen,
                        arguments: {
                          'comment': comment,
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Text(
                        'Reply',
                        style: PmpTextStyles.caption,
                      ),
                    ),
                  ),
                ],
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
                      deleteCommentBloc.add(
                        PatternUserCommentEvent.deleteComment(comment.id!),
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
