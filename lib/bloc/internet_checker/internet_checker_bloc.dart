import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'internet_checker_bloc.freezed.dart';

class InternetCheckerBloc
    extends Bloc<InternetCheckerEvent, InternetCheckerState> {
  InternetCheckerBloc() : super(const InternetCheckerState.initial()) {
    on<InternetCheckerEvent>((event, emit) async {
      event.when(
        internetAccess: () {
          emit(const InternetCheckerState.accessInternet());
        },
        noInternetAccess: () {
          emit(const InternetCheckerState.noInternet());
        },
      );
    });
  }
}

@freezed
abstract class InternetCheckerEvent with _$InternetCheckerEvent {
  const factory InternetCheckerEvent.internetAccess() = _InternetAccess;
  const factory InternetCheckerEvent.noInternetAccess() = _NoInternetAccess;
}

@freezed
abstract class InternetCheckerState with _$InternetCheckerState {
  const factory InternetCheckerState.accessInternet() = _AccessInternet;
  const factory InternetCheckerState.initial() = _Initial;
  const factory InternetCheckerState.noInternet() = _NoInternet;
}
