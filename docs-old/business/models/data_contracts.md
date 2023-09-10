# Data Contracts

Data contract classes are models that represents REST API response JSON body.

The blueprint uses [`json_annotation`](https://pub.dev/packages/json_serializable) to generate the serialization/deserialization code.

```dart
@JsonSerializable()
class UserProfileContract extends DataContract {
  UserProfileContract({
    required this.id,
    required this.email,
    required this.fullName,
    required this.isVerified,
    this.avatarUrl,
  });

  final String id;
  final String email;
  final String fullName;
  final String? avatarUrl;

  @JsonKey(defaultValue: false)
  final bool isVerified;

  factory UserProfileContract.fromJson(Map<String, dynamic> json) => _$UserProfileContractFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserProfileContractToJson(this);
}
```

:bulb: **<span style="color: green">TIP</span>**

Use the code snippet shortcut `jsonc` to create a data contract class.