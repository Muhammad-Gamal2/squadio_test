// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeoplePageAdapter extends TypeAdapter<PeoplePage> {
  @override
  final int typeId = 1;

  @override
  PeoplePage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PeoplePage(
      page: fields[0] as int,
      totalPages: fields[1] as int,
      results: (fields[2] as List).cast<Person>(),
      totalResults: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PeoplePage obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.totalPages)
      ..writeByte(2)
      ..write(obj.results)
      ..writeByte(3)
      ..write(obj.totalResults);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeoplePageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
