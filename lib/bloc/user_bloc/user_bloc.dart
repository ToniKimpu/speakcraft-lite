import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pmp_english/global_app_state.dart';
import 'package:pmp_english/model/app_user/app_user.dart';
import 'package:pmp_english/services/supabase_service.dart';

part 'user_bloc.freezed.dart';

@freezed
abstract class UserEvent with _$UserEvent {
  const factory UserEvent.updateUserName(String newName) = _UpdateUserName;
  const factory UserEvent.updateUserAvatar(String newAvatar) =
      _UpdateUserAvatar;
  const factory UserEvent.updateUserToken(int token) = _UpdateUserToken;
}

@freezed
abstract class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.onSuccess() = _OnSuccess;
  const factory UserState.error(String message) = _Error;
}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState.initial()) {
    on<UserEvent>((event, emit) async {
      try {
        await event.when(
          updateUserName: (newName) async {
            emit(const UserState.loading());
            final dataRes = await supabase
                .from("users")
                .update({"name": newName})
                .eq(
                  "id",
                  GlobalAppState().currentUser.id!,
                )
                .select();
            if (dataRes.isNotEmpty) {
              GlobalAppState().currentUser = AppUser.fromJson(dataRes.first);
            }
            emit(const UserState.onSuccess());
          },
          updateUserAvatar: (newAvatar) async {
            emit(const UserState.loading());
            final dataRes = await supabase
                .from("users")
                .update({"profile_path": newAvatar})
                .eq(
                  "id",
                  GlobalAppState().currentUser.id!,
                )
                .select();
            if (dataRes.isNotEmpty) {
              GlobalAppState().currentUser = AppUser.fromJson(dataRes.first);
            }
            emit(const UserState.onSuccess());
          },
          updateUserToken: (token) async {
            final appUser = GlobalAppState().currentUser;
            int totalTokenUsed = appUser.totalTokenUsed + token;
            GlobalAppState().currentUser = appUser.copyWith(
              totalTokenUsed: totalTokenUsed,
            );
            emit(const UserState.loading());
            final dataRes = await supabase
                .from("users")
                .update({"total_token_used": totalTokenUsed})
                .eq(
                  "id",
                  GlobalAppState().currentUser.id!,
                )
                .select();
            if (dataRes.isNotEmpty) {
              GlobalAppState().currentUser = AppUser.fromJson(dataRes.first);
            }
          },
        );
      } catch (e) {
        emit(UserState.error(e.toString()));
      }
    });
  }
}
