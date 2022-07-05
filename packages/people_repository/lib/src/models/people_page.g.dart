// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeoplePage _$PeoplePageFromJson(Map<String, dynamic> json) => PeoplePage(
      page: json['page'] as int,
      totalPages: json['total_pages'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: json['total_results'] as int,
    );

Map<String, dynamic> _$PeoplePageToJson(PeoplePage instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_pages': instance.totalPages,
      'results': instance.results,
      'total_results': instance.totalResults,
    };
