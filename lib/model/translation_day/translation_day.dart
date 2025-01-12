// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_day.freezed.dart';
part 'translation_day.g.dart';

@freezed
class TranslationDay with _$TranslationDay {
  const factory TranslationDay({
    required int id,
    @JsonKey(name: 'day_name') required String dayName,
    required bool isComplete,
  }) = _TranslationDay;

  factory TranslationDay.fromJson(Map<String, dynamic> json) =>
      _$TranslationDayFromJson(json);
  factory TranslationDay.fromJson1(Map<String, dynamic> json) {
    return TranslationDay(
      id: json['id'] as int,
      dayName: json['day_name'] as String,
      isComplete:
          (json['translation_days_users_relation'].isNotEmpty ?? false) as bool, // Default to false if missing
    );
  }
}
