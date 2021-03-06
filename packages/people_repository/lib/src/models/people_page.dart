import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'people_page.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class PeoplePage extends Equatable {
  const PeoplePage({
    required this.page,
    required this.totalPages,
    required this.results,
    required this.totalResults,
  });

  @HiveField(0)
  final int page;
  @HiveField(1)
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @HiveField(2)
  final List<Person> results;
  @HiveField(3)
  @JsonKey(name: 'total_results')
  final int totalResults;

  factory PeoplePage.fromJson(Map<String, dynamic> json) =>
      _$PeoplePageFromJson(json);

  Map<String, dynamic> toJson() => _$PeoplePageToJson(this);

  @override
  List<Object?> get props => [page, totalPages, results, totalResults];

  static const PeoplePage empty = PeoplePage(
    page: 0,
    totalPages: 0,
    results: [],
    totalResults: 0,
  );

  PeoplePage copyWith({
    int? page,
    int? totalPages,
    List<Person>? results,
    int? totalResults,
  }) {
    return PeoplePage(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      results: results ?? this.results,
      totalResults: totalResults ?? this.totalResults,
    );
  }
}
