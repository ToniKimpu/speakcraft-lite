import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/bloc/user_comment_reply/user_comment_reply.dart';

import '../../global_app_state.dart';
import '../../model/pattern_user_comment/pattern_user_comment.dart';
import '../../services/supabase_service.dart';

part 'pattern_user_comment_bloc.freezed.dart';

@freezed
abstract class PatternUserCommentEvent with _$PatternUserCommentEvent {
  const factory PatternUserCommentEvent.loadComments(
      bool withLoading, int patternId) = _LoadComments;
  const factory PatternUserCommentEvent.loadReplies(
      bool withLoading, int commentId) = _LoadReplies;
  const factory PatternUserCommentEvent.addComment(
      int patternId, String comment) = _AddComment;
  const factory PatternUserCommentEvent.addReply(int commentId, String reply) =
      _AddReply;
  const factory PatternUserCommentEvent.deleteComment(int commentId) =
      _DeleteComment;
  const factory PatternUserCommentEvent.deleteReply(int replyId) = _DeleteReply;
}

@freezed
abstract class PatternUserCommentState with _$PatternUserCommentState {
  const factory PatternUserCommentState.initial() = _Initial;
  const factory PatternUserCommentState.loading() = _Loading;
  const factory PatternUserCommentState.commenting() = _Commenting;
  const factory PatternUserCommentState.deleting() = _Deleting;
  const factory PatternUserCommentState.loaded(
      List<PatternUserComment> comments) = _Loaded;
  const factory PatternUserCommentState.repliesLoaded(
      List<UserCommentReply> replies) = _ReplyLoaded;
  const factory PatternUserCommentState.addComentSuccess() = _AddCommentSuccess;
  const factory PatternUserCommentState.deleteCommentSuccess() =
      _DeleteCommentSuccess;
  const factory PatternUserCommentState.error(String message) = _Error;
}

class PatternUserCommentBloc
    extends Bloc<PatternUserCommentEvent, PatternUserCommentState> {
  PatternUserCommentBloc() : super(const PatternUserCommentState.initial()) {
    on<PatternUserCommentEvent>(
      (event, emit) async {
        try {
          await event.when(
            loadComments: (withLoading, patternId) =>
                _mapLoadCommentsToState(withLoading, patternId, emit),
            addComment: (patternId, comment) =>
                _mapAddCommentToState(patternId, comment, emit),
            loadReplies: (withLoading, commentId) =>
                _mapLoadRepliesToState(withLoading, commentId, emit),
            addReply: (commentId, reply) =>
                _mapAddReplyToState(commentId, reply, emit),
            deleteComment: (commentId) =>
                _mapDeleteCommentToState(commentId, emit),
            deleteReply: (replyId) => _mapDeleteReplyToState(replyId, emit),
          );
        } catch (e) {
          debugPrint('PatternUserCommentBloc error: ${e.toString()}');
          emit(PatternUserCommentState.error(e.toString()));
        }
      },
    );
  }

  Future<void> _mapLoadCommentsToState(bool withLoading, int patternId,
      Emitter<PatternUserCommentState> emit) async {
    if (withLoading) {
      emit(const PatternUserCommentState.loading());
    }
    try {
      final dataRes = await supabase
          .from('pattern_user_comments')
          .select('*,users(*)')
          .eq('pattern_id', patternId)
          .order('created_at');
      if (dataRes.isEmpty) {
        emit(const PatternUserCommentState.loaded([]));
        return;
      }

      final comments = PatternUserComment.fromJsonList(dataRes);
      emit(PatternUserCommentState.loaded(comments));
    } catch (e) {
      debugPrint('Error loading comments: ${e.toString()}');
      emit(PatternUserCommentState.error(e.toString()));
    }
  }

  Future<void> _mapAddCommentToState(int patternId, String txtComment,
      Emitter<PatternUserCommentState> emit) async {
    emit(const PatternUserCommentState.commenting());
    try {
      final dataRes = await supabase.from('pattern_user_comments').insert({
        'pattern_id': patternId,
        'user_id': GlobalAppState().currentUser.id,
        'comment': txtComment,
      }).select();
      if (dataRes.isEmpty) {
        emit(const PatternUserCommentState.error("Failed to insert comment!"));
        return;
      }
      emit(const PatternUserCommentState.addComentSuccess());
    } catch (e) {
      debugPrint('Error adding comment: ${e.toString()}');
      emit(PatternUserCommentState.error(e.toString()));
    }
  }

  Future<void> _mapLoadRepliesToState(bool withLoading, int commentId,
      Emitter<PatternUserCommentState> emit) async {
    if (withLoading) {
      emit(const PatternUserCommentState.loading());
    }
    try {
      final dataRes = await supabase
          .from('user_comment_replies')
          .select('*,users(*)')
          .eq('pattern_user_comment_id', commentId)
          .order('created_at');
      if (dataRes.isEmpty) {
        emit(const PatternUserCommentState.repliesLoaded(<UserCommentReply>[]));
        return;
      }

      final replies = UserCommentReply.fromJsonList(dataRes);
      emit(PatternUserCommentState.repliesLoaded(replies));
    } catch (e) {
      debugPrint('Error loading comments: ${e.toString()}');
      emit(PatternUserCommentState.error(e.toString()));
    }
  }

  Future<void> _mapAddReplyToState(int commentId, String reply,
      Emitter<PatternUserCommentState> emit) async {
    emit(const PatternUserCommentState.commenting());
    try {
      final dataRes = await supabase.from('user_comment_replies').insert({
        'pattern_user_comment_id': commentId,
        'user_id': GlobalAppState().currentUser.id,
        'reply': reply,
      }).select();
      if (dataRes.isEmpty) {
        emit(const PatternUserCommentState.error(
            "Failed to insert comment reply!"));
        return;
      }
      emit(const PatternUserCommentState.addComentSuccess());
    } catch (e) {
      debugPrint('Error adding comment: ${e.toString()}');
      emit(PatternUserCommentState.error(e.toString()));
    }
  }

  Future<void> _mapDeleteCommentToState(
      int commentId, Emitter<PatternUserCommentState> emit) async {
    emit(const PatternUserCommentState.deleting());
    try {
      await supabase
          .from('user_comment_replies')
          .delete()
          .eq('pattern_user_comment_id', commentId);
      await supabase.from('pattern_user_comments').delete().eq('id', commentId);
      emit(const PatternUserCommentState.deleteCommentSuccess());
    } catch (e) {
      debugPrint('_mapDeleteCommentToState: ${e.toString()}');
      emit(PatternUserCommentState.error(e.toString()));
    }
  }

  Future<void> _mapDeleteReplyToState(
      int replyId, Emitter<PatternUserCommentState> emit) async {
    emit(const PatternUserCommentState.deleting());
    try {
      await supabase.from('user_comment_replies').delete().eq('id', replyId);
      emit(const PatternUserCommentState.deleteCommentSuccess());
    } catch (e) {
      debugPrint('_mapDeleteCommentToState: ${e.toString()}');
      emit(PatternUserCommentState.error(e.toString()));
    }
  }
}
