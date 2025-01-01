import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';

import '../../../bloc/pattern_user_comment/pattern_user_comment_bloc.dart';
import 'comment_widget.dart';

class CommentListWidget extends StatelessWidget {
  const CommentListWidget({
    super.key,
    required PatternUserCommentBloc patternUserCommentBloc,
    required ValueNotifier<bool> commentNotifier,
    required TextEditingController commentController,
    required this.deleteCommentBloc,
    required this.onDeleted,
  })  : _patternUserCommentBloc = patternUserCommentBloc,
        _commentNotifier = commentNotifier,
        _commentController = commentController;

  final PatternUserCommentBloc _patternUserCommentBloc;
  final ValueNotifier<bool> _commentNotifier;
  final TextEditingController _commentController;
  final PatternUserCommentBloc deleteCommentBloc;

  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatternUserCommentBloc, PatternUserCommentState>(
      bloc: _patternUserCommentBloc,
      builder: (context, state) {
        return state.maybeWhen(
          loading: () {
            return const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(),
              ),
            );
          },
          loaded: (comments) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                _commentNotifier.value = false;
                _commentController.clear();
              },
            );
            onDeleted.call();
            if (comments.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Text(
                    'There are no practices yet!',
                    style: PmpTextStyles.body1Regular
                        .copyWith(color: Colors.black),
                  ),
                ),
              );
            }
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CommentWidget(
                  comment: comments[index],
                  deleteCommentBloc: deleteCommentBloc,
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.black.withOpacity(0.1),
                  ),
                );
              },
            );
          },
          orElse: () => Container(),
        );
      },
    );
  }
}
