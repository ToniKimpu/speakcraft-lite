// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_verb_agreement.freezed.dart';
part 'subject_verb_agreement.g.dart';

@freezed
class SubjectVerbAgreement with _$SubjectVerbAgreement {
  const factory SubjectVerbAgreement({
    int? id,
    required String title,
    @JsonKey(name: 'svg_data') required List<dynamic> svgData,
  }) = _SubjectVerbAgreement;

  factory SubjectVerbAgreement.fromJson(Map<String, dynamic> json) =>
      _$SubjectVerbAgreementFromJson(json);
}
