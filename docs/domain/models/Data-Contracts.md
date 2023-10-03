Data contract classes are models that represents REST API response JSON body.

The project uses [`json_annotation`](https://pub.dev/packages/json_serializable) to generate the serialization/deserialization code.

```dart
part 'post_data_contract.g.dart';

@JsonSerializable()
class PostDataContract extends JsonSerializableObject {
  const PostDataContract({required this.userId, required this.id, required this.title, required this.body});

  factory PostDataContract.fromJson(Map<String, dynamic> json) => _$PostDataContractFromJson(json);

  final int userId;

  final int id;

  final String title;

  final String body;
}
```

:bulb: **<span style="color: green">TIP</span>**

Use the code snippet shortcut `jsonc` to create a data contract class.