# Entities

Entities are immutable model classes. They can contain business logics used within your domain.

At it's simplest form, entities can be PODOs (Plain Old Dart Objects):

```dart
class OtpVerificationEntity implements DomainEntity {
    const OtpVerificationEntity(this.code, this.email);

    final String code;
    final String email;
}
```

The blueprint uses entities as the representation of [Data Contracts](data_contracts.md) or [Data Objects](data_objects.md) in the Domain and UI layer.

:bulb: **<span style="color: green">TIP</span>**

Use the snippet shortcut `dome` to create a domain entity class.