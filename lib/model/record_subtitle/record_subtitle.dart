import 'package:freezed_annotation/freezed_annotation.dart';

part 'record_subtitle.freezed.dart';
part 'record_subtitle.g.dart';

@freezed
class RecordSubtitle with _$RecordSubtitle {
  const factory RecordSubtitle({
    required String id,
    required double start,
    required double end,
    required List<RecordSubtitleItem> data,
  }) = _RecordSubtitle;

  factory RecordSubtitle.fromJson(Map<String, dynamic> json) =>
      _$RecordSubtitleFromJson(json);
}

@freezed
class RecordSubtitleItem with _$RecordSubtitleItem {
  const factory RecordSubtitleItem({
    required double start,
    required double end,
    required String text,
  }) = _RecordSubtitleItem;

  factory RecordSubtitleItem.fromJson(Map<String, dynamic> json) =>
      _$RecordSubtitleItemFromJson(json);
}
