import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/config/pmp_text_styles.dart';
import 'package:pmp_english/model/pattern_user_comment/pattern_user_comment.dart';
import 'package:pmp_english/screens/self_practice_pattern/widgets/reply_heading_widget.dart';
import 'package:pmp_english/screens/self_practice_pattern/widgets/reply_widget.dart';

import '../../bloc/pattern_user_comment/pattern_user_comment_bloc.dart';
import 'widgets/comment_input_field.dart';

class PatternReplyScreen extends StatefulWidget {
  const PatternReplyScreen({
    super.key,
    required this.comment,
  });
  final PatternUserComment comment;

  @override
  State<PatternReplyScreen> createState() => _PatternReplyScreenState();
}

class _PatternReplyScreenState extends State<PatternReplyScreen> {
  late final ValueNotifier<double> _textFieldPositionNotifier;
  late final TextEditingController _commentController;
  late final ValueNotifier<bool> _commentNotifier;
  late ScrollController _scrollController;

  final _userCommentReplyBloc = PatternUserCommentBloc();
  final _addOrDeleteReplyBloc = PatternUserCommentBloc();

  bool _isDelete = false;

  @override
  void initState() {
    super.initState();
    _textFieldPositionNotifier = ValueNotifier<double>(10.0);
    _commentController = TextEditingController();
    _commentNotifier = ValueNotifier<bool>(false);
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
    _userCommentReplyBloc.add(
      PatternUserCommentEvent.loadReplies(true, widget.comment.id!),
    );
  }

  void _handleScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      _textFieldPositionNotifier.value = -200;
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      _textFieldPositionNotifier.value = 10;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldPositionNotifier.dispose();
    _commentController.dispose();
    _commentNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/profiles/Boy_01.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 12),
            const Text('John Doe'),
            const Spacer(),
            InkWell(
              borderRadius: BorderRadius.circular(9999),
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Icon(
                  Icons.close,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<PatternUserCommentBloc>(
            create: (context) => _userCommentReplyBloc,
          ),
          BlocProvider<PatternUserCommentBloc>(
            create: (context) => _addOrDeleteReplyBloc,
          ),
        ],
        child: BlocListener<PatternUserCommentBloc, PatternUserCommentState>(
          bloc: _addOrDeleteReplyBloc,
          listener: (context, state) {
            state.whenOrNull(
              commenting: () {
                _commentNotifier.value = true;
              },
              addComentSuccess: () {
                _userCommentReplyBloc.add(
                  PatternUserCommentEvent.loadReplies(
                    false,
                    widget.comment.id!,
                  ),
                );
              },
              deleting: () {
                // _isDelete = true;
                context.showAdvanceDialog(
                  dialog: const LoadingDialog(
                    message: 'Deleting...',
                  ),
                );
              },
              deleteCommentSuccess: () {
                _isDelete = true;
                _userCommentReplyBloc.add(
                  PatternUserCommentEvent.loadReplies(
                    false,
                    widget.comment.id!,
                  ),
                );
              },
            );
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReplyHeadingWidget(
                      appUser: widget.comment.user!,
                      comment: widget.comment.comment,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    BlocBuilder<PatternUserCommentBloc,
                        PatternUserCommentState>(
                      bloc: _userCommentReplyBloc,
                      builder: (context, state) {
                        return state.maybeWhen(
                          loading: () {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 24),
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          },
                          repliesLoaded: (replies) {
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) {
                                _commentNotifier.value = false;
                                _commentController.clear();
                              },
                            );
                            if (_isDelete) {
                              _isDelete = false;
                              context.hideLoadingDialog();
                            }
                            if (replies.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 120),
                                  child: Text(
                                    'There is no reply yet!',
                                    style: PmpTextStyles.body1Regular
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              );
                            }
                            return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: replies.length,
                              padding: const EdgeInsets.only(left: 40),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final reply = replies[index];
                                return ReplyWidget(
                                  appUser: reply.user!,
                                  reply: reply,
                                  deleteReplyBloc: _addOrDeleteReplyBloc,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 12,
                              ),
                            );
                          },
                          orElse: () => Container(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              CommentInputField(
                textFieldPositionNotifier: _textFieldPositionNotifier,
                commentController: _commentController,
                commentNotifier: _commentNotifier,
                addComment: (comment) {
                  _addOrDeleteReplyBloc.add(
                    PatternUserCommentEvent.addReply(
                      widget.comment.id!,
                      _commentController.text.trim(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
