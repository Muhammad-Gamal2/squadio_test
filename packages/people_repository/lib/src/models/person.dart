import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person extends Equatable {
  const Person({
    required this.id,
    required this.name,
    required this.profilePath,
    this.knownAs,
    this.biography,
    this.birthday,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  final int id;
  final String name;
  @JsonKey(name: 'profile_path')
  final String profilePath;
  final String? biography;
  final String? birthday;
  @JsonKey(name: 'also_known_as')
  final List<String>? knownAs;

  @override
  List<Object?> get props =>
      [id, name, profilePath, biography, birthday, knownAs];

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
      knownAs: knownAs ?? this.knownAs,
    );
  }
}
