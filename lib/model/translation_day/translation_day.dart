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
}
