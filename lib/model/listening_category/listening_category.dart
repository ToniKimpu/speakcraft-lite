import 'package:freezed_annotation/freezed_annotation.dart';

part 'listening_category.freezed.dart';
part 'listening_category.g.dart';

@freezed
class ListeningCategory with _$ListeningCategory {
  const factory ListeningCategory({
    required int id,
    required String name,
  }) = _ListeningCategory;

  factory ListeningCategory.fromJson(Map<String, dynamic> json) => _$ListeningCategoryFromJson(json);
}
