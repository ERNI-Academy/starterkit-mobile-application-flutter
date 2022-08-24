import 'package:erni_mobile/domain/models/entities/codable_entity.dart';
import 'package:erni_mobile_core/json.dart';

part 'user_profile_entity.g.dart';

@JsonSerializable()
class UserProfileEntity extends CodableEntity {
  const UserProfileEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.isAccountLocked = true,
    this.isConfirmed = false,
  });

  factory UserProfileEntity.fromJson(Map<String, dynamic> json) => _$UserProfileEntityFromJson(json);

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final bool isAccountLocked;
  final bool isConfirmed;

  String get fullName => '$firstName $lastName';

  @override
  Map<String, dynamic> toJson() => _$UserProfileEntityToJson(this);
}
