import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmp_english/bloc/spoken_pattern/spoken_pattern_bloc.dart';
import 'package:pmp_english/bloc/pattern_user_comment/pattern_user_comment_bloc.dart';
import 'package:pmp_english/config/common_extensions.dart';
import 'package:pmp_english/screens/self_practice_pattern/widgets/practice_example_list.dart';

import '../../model/spoken_pattern/spoken_pattern.dart';
import 'widgets/comment_input_field.dart';
import 'widgets/comment_list_widget.dart';
import 'widgets/practice_vocabulary_list.dart';
import 'widgets/self_pattern_widget.dart';

class PatternPracticeScreen extends StatefulWidget {
  const PatternPracticeScreen({
    super.key,
    required this.spokenPattern,
  });
  final SpokenPattern spokenPattern;

  @override
  State<PatternPracticeScreen> createState() => _PatternPracticeScreenState();
}

class _PatternPracticeScreenState extends State<PatternPracticeScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late final ValueNotifier<double> _textFieldPositionNotifier;
  late final ValueNotifier<bool> _commentNotifier;
  late final TextEditingController _commentController;
  double _popupHeight = 1;

  final _showVocabularyNotifier = ValueNotifier<bool>(false);
  final _showExampleNotifier = ValueNotifier<bool>(false);
  final _vocabularyBloc = SpokenPatternBloc();
  final _exampleBloc = SpokenPatternBloc();

  final _patternContainerKey = GlobalKey();
  double patternContainerHeight = -1;

  final _bodyWidgetKey = GlobalKey();
  double _bodyHeight = -1;

  final _patternUserCommentBloc = PatternUserCommentBloc();
  final _addOrDeleteCommentBloc = PatternUserCommentBloc();

  bool _isDelete = false;

  @override
  void initState() {
    super.initState();
    _textFieldPositionNotifier = ValueNotifier<double>(10.0);
    _commentNotifier = ValueNotifier<bool>(false);
    _commentController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bodyBox =
          _bodyWidgetKey.currentContext!.findRenderObject() as RenderBox;
      _bodyHeight = bodyBox.size.height;
      final containerBox =
          _patternContainerKey.currentContext!.findRenderObject() as RenderBox;
      patternContainerHeight = containerBox.size.height;
      if (_bodyHeight != -1 && patternContainerHeight != -1) {
        setState(() {
          _popupHeight = _bodyHeight - (patternContainerHeight + 52);
        });
      }
    });
    _vocabularyBloc.add(
        SpokenPatternEvent.loadVocabulariesByPattern(widget.spokenPattern.id!));
    _exampleBloc.add(
        SpokenPatternEvent.loadExamplesByPattern(widget.spokenPattern.id!));
    _patternUserCommentBloc.add(
        PatternUserCommentEvent.loadComments(true, widget.spokenPattern.id!));
  }

  @override
  void dispose() {
    super.dispose();
    _showVocabularyNotifier.dispose();
    _showExampleNotifier.dispose();
    _commentController.dispose();
    _commentNotifier.dispose();
    _textFieldPositionNotifier.dispose();
  }

  void _handleScroll() {
    if (_showVocabularyNotifier.value) {
      _showVocabularyNotifier.value = false;
    }
    if (_showExampleNotifier.value) {
      _showExampleNotifier.value = false;
    }
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      _textFieldPositionNotifier.value = -200;
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      _textFieldPositionNotifier.value = 10;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_showVocabularyNotifier.value) {
          _showVocabularyNotifier.value = false;
          return;
        }
        if (_showExampleNotifier.value) {
          _showExampleNotifier.value = false;
          return;
        }
        Navigator.of(context).pop();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SpokenPatternBloc>(
            create: (context) => _vocabularyBloc,
          ),
          BlocProvider<SpokenPatternBloc>(
            create: (context) => _exampleBloc,
          ),
          BlocProvider<PatternUserCommentBloc>(
            create: (context) => _patternUserCommentBloc,
          ),
          BlocProvider<PatternUserCommentBloc>(
            create: (context) => _addOrDeleteCommentBloc,
          ),
        ],
        child: GestureDetector(
          onTap: () {
            if (_showVocabularyNotifier.value) {
              _showVocabularyNotifier.value = false;
            }
            if (_showExampleNotifier.value) {
              _showExampleNotifier.value = false;
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                widget.spokenPattern.pattern,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            body: BlocListener<PatternUserCommentBloc, PatternUserCommentState>(
              bloc: _addOrDeleteCommentBloc,
              listener: (context, state) {
                state.whenOrNull(
                  commenting: () {
                    _commentNotifier.value = true;
                  },
                  deleting: () {
                    _isDelete = true;
                    context.showAdvanceDialog(
                      dialog: const LoadingDialog(
                        message: 'Deleting...',
                      ),
                    );
                  },
                  deleteCommentSuccess: () {
                    _isDelete = true;
                    _patternUserCommentBloc.add(
                      PatternUserCommentEvent.loadComments(
                        false,
                        widget.spokenPattern.id!,
                      ),
                    );
                  },
                  addComentSuccess: () {
                    _patternUserCommentBloc.add(
                      PatternUserCommentEvent.loadComments(
                        false,
                        widget.spokenPattern.id!,
                      ),
                    );
                  },
                );
              },
              child: Stack(
                key: _bodyWidgetKey,
                fit: StackFit.expand,
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelfPatternWidget(
                          patternContainerKey: _patternContainerKey,
                          spokenPattern: widget.spokenPattern,
                          showVocabularyNotifier: _showVocabularyNotifier,
                          showExampleNotifier: _showExampleNotifier,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CommentListWidget(
                          patternUserCommentBloc: _patternUserCommentBloc,
                          commentNotifier: _commentNotifier,
                          commentController: _commentController,
                          deleteCommentBloc: _addOrDeleteCommentBloc,
                          onDeleted: () {
                            if (_isDelete) {
                              _isDelete = false;
                              context.hideLoadingDialog();
                            }
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
                      _addOrDeleteCommentBloc.add(
                        PatternUserCommentEvent.addComment(
                          widget.spokenPattern.id!,
                          _commentController.text.trim(),
                        ),
                      );
                    },
                  ),
                  PracticeVocabularyList(
                    showVocabularyNotifier: _showVocabularyNotifier,
                    popupHeight: _popupHeight,
                    vocabularyBloc: _vocabularyBloc,
                  ),
                  PracticeExampleList(
                    showExampleNotifier: _showExampleNotifier,
                    popupHeight: _popupHeight,
                    exampleBloc: _exampleBloc,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
