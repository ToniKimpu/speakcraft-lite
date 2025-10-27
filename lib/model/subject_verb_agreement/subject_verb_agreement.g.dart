// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_verb_agreement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubjectVerbAgreementImpl _$$SubjectVerbAgreementImplFromJson(
        Map<String, dynamic> json) =>
    _$SubjectVerbAgreementImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      svgData: json['svg_data'] as List<dynamic>,
    );

Map<String, dynamic> _$$SubjectVerbAgreementImplToJson(
        _$SubjectVerbAgreementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'svg_data': instance.svgData,
    };
