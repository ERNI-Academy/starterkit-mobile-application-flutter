# Mappers

Mappers are classes that transforms one object to another type. They are used in manager classes where web services and repositories return data and needs to be mapped to an entity, and vice versa.

The project uses [`smartstruct`](https://pub.dev/packages/smartstruct) which generates the mapping code for us. The package uses `build_runner`, read more about code generation [here](../../code_generation.md).

# Mapper types

## ContractFromEntityMapper

Returns a mapped `DataContract` from a `DomainEntity`.

```dart
abstract class ContractFromEntityMapper<D extends DataContract, E extends DomainEntity> implements ObjectMapper {
  D? fromEntity(E? entity);
}
```

:bulb: **<span style="color: green">TIP</span>**

Use the code snippet shortcut `mapde` to create this mapper type.

## ContractFromObjectMapper

Returns a mapped `DataContract` from a `DataClass`.

```dart
abstract class ContractFromObjectMapper<C extends DataContract, O extends DataClass> implements ObjectMapper {
  C? fromObject(O? object);
}
```

:bulb: **<span style="color: green">TIP</span>**

Use the code snippet shortcut `mapdo` to create this mapper type.

## EntityFromContractMapper

Returns a mapped `DomainEntity` from a `DataContract`.

```dart
abstract class EntityFromContractMapper<E extends DomainEntity, D extends DataContract> implements ObjectMapper {
  E? fromContract(D? contract);
}
```

:bulb: **<span style="color: green">TIP</span>**

Use the code snippet shortcut `maped` to create this mapper type.

## EntityFromObjectMapper

Returns a mapped `DomainEntity` from `DataClass`.

```dart
abstract class EntityFromObjectMapper<E extends DomainEntity, O extends DataClass> implements ObjectMapper {
  E? fromObject(O? object);
}
```

:bulb: **<span style="color: green">TIP</span>**

Use the code snippet shortcut `mapeo` to create this mapper type.

## ObjectFromEntityMapper

Returns a mapped `DataClass` from `DomainEntity`.

```dart
abstract class ObjectFromEntityMapper<O extends DataClass, E extends DomainEntity> implements ObjectMapper {
  O? fromEntity(E? entity);
}
```

:bulb: **<span style="color: green">TIP</span>**

Use the code snippet shortcut `mapoe` to create this mapper type.

## ObjectFromContractMapper

Returns a mapped `DataClass` from `DataContract`.

```dart
abstract class ObjectFromContractMapper<O extends DataClass, C extends DataContract> implements ObjectMapper {
  O? fromContract(C? contract);
}
```

:bulb: **<span style="color: green">TIP</span>**

Use the code snippet shortcut `mapod` to create this mapper type.


# Mapping from one class to another

For example, we need to map a data contract from the `web` layer to a domain entity:

UserLoginRequestContract 
```dart
class UserLoginRequestContract implements DataContract {
  UserLoginRequestContract({required this.email, required this.password});

  final String email;
  final String password;
}
```

UserLoginEntity 
```dart
class UserLoginRequestEntity implements DomainEntity {
  UserLoginRequestEntity({required this.email, required this.password});

  final String email;
  final String password;
}
```

UserLoginContractFromEntityMapper
```dart
@Mapper(useInjection: true)
abstract class UserLoginContractFromEntityMapper
    implements ContractFromEntityMapper<UserLoginRequestContract, UserLoginRequestEntity> {
  @override
  UserLoginRequestContract? fromEntity(UserLoginRequestEntity? entity);
}
```

- We are mapping the object of type `UserLoginRequestEntity` to `UserLoginRequestContract`.
- Make sure that each of the classes property name matches.
- The `useInjection` parameter in `@Mapper` annotation tells the generator to register this type using `injectable`.

# Mapping nested classes

For example, we need to map `PostContract` to `PostEntity`. Both classes have a property named `user`.

UserProfileEntity
```dart
class UserProfileEntity implements DomainEntity {
  UserProfileEntity({
    required this.id,
    required this.email,
    required this.fullName,
  });

  final String id;
  final String email;
  final String fullName;
}
```

UserProfileContract
```dart
class UserProfileContract implements DataContract {
  UserProfileContract({
    required this.id,
    required this.email,
    required this.fullName,
  });

  final String id;
  final String email;
  final String fullName;
}
```

PostEntity
```dart
class PostEntity implements DomainEntity {
  PostEntity({
    required this.id,
    required this.user,
    required this.content,
  });

  final String id;
  final UserProfileEntity user;
  final String content;
}
```

PostContract
```dart
class PostContract implements DataContract {
  PostContract({
    required this.id,
    required this.user,
    required this.content,
  });

  final String id;
  final UserProfileContract user;
  final String content;
}
```

We need to create mappers for the subclasses, in this case `UserProfileEntityFromContractMapper`

```dart
@Mapper(useInjection: true)
abstract class UserProfileEntityFromContractMapper
    implements EntityFromContractMapper<UserProfileEntity, UserProfileContract> {
  @override
  UserProfileEntity? fromContract(UserProfileContract? contract);
}
```

Next is our `PostEntityFromContractMapper`

```dart
@Mapper(useInjection: true)
abstract class PostEntityFromContractMapper implements EntityFromContractMapper<PostEntity, PostContract> {
  PostEntityFromContractMapper(this._userProfileEntityFromContractMapper);

  final UserProfileEntityFromContractMapper _userProfileEntityFromContractMapper;

  @override
  PostEntity? fromContract(PostContract? contract);

  @nonVirtual
  UserProfileEntity fromUserContract(UserProfileContract contract) =>
      _userProfileEntityFromContractMapper.fromContract(contract)!;
}
```

The generated code will be

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

@LazySingleton(as: PostEntityFromContractMapper)
class PostEntityFromContractMapperImpl extends PostEntityFromContractMapper {
  PostEntityFromContractMapperImpl(
      UserProfileEntityFromContractMapper _userProfileEntityFromContractMapper)
      : super(_userProfileEntityFromContractMapper);

  @override
  PostEntity? fromContract(PostContract? contract) {
    if (contract == null) {
      return null;
    }
    ;
    final postentity = PostEntity(
        user: fromUserContract(contract.user),
        id: contract.id,
        userId: contract.userId,
        userFullName: contract.userFullName,
        content: contract.content,
        updatedAt: contract.updatedAt,
        userAvatarUrl: contract.userAvatarUrl);
    return postentity;
  }
}
```

- We inject `UserProfileEntityFromContractMapper` to `PostEntityFromContractMapper` and create a method named `fromUserContract()` and use our `UserProfileEntityFromContractMapper`.
- It is important to annotate `fromUserContract()` with `@nonVirtual` to prevent the generator from overriding and creating another mapper.
- Make sure also that `fromUserContract()` returns a non-nullable value.