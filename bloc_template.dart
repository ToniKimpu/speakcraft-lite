// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'category_bloc.freezed.dart';

// @freezed
// abstract class CategoryEvent with _$CategoryEvent {
// const factory CategoryEvent.load() = _Load;
//}

// @freezed
// abstract class CategoryState with _$CategoryState {
//   const factory CategoryState.initial() = _Initial;
//   const factory CategoryState.loading({String? message}) = _Loading;
//   const factory CategoryState.error(String message) = _Error;
// }

// class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
//   CategoryBloc() : super(const CategoryState.initial()) {
//     on<CategoryEvent>((event, emit) async {
//       // await event.when();
//     });
//   }
// }
