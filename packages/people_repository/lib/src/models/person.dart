import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Person extends Equatable {
  const Person({
    required this.id,
    required this.name,
    required this.profilePath,
    this.biography,
    this.birthday,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  @JsonKey(name: 'profile_path')
  final String? profilePath;
  @HiveField(3)
  final String? biography;
  @HiveField(4)
  final String? birthday;

  @override
  List<Object?> get props =>
      [id, name, profilePath, biography, birthday];

  static const Person empty = Person(id: 0, name: '', profilePath: '');

  Person copyWith(
      {int? id,
      String? name,
      String? profilePath,
      String? biography,
      String? birthday,
      List<String>? knownAs}) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePath: profilePath ?? this.profilePath,
      biography: biography ?? this.biography,
      birthday: birthday ?? this.birthday,
    );
  }
}
