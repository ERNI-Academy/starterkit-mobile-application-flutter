// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_data_contract.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostDataContract _$PostDataContractFromJson(Map<String, dynamic> json) {
  return _PostDataContract.fromJson(json);
}

/// @nodoc
mixin _$PostDataContract {
  int get userId => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostDataContractCopyWith<PostDataContract> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostDataContractCopyWith<$Res> {
  factory $PostDataContractCopyWith(
          PostDataContract value, $Res Function(PostDataContract) then) =
      _$PostDataContractCopyWithImpl<$Res, PostDataContract>;
  @useResult
  $Res call({int userId, int id, String title, String body});
}

/// @nodoc
class _$PostDataContractCopyWithImpl<$Res, $Val extends PostDataContract>
    implements $PostDataContractCopyWith<$Res> {
  _$PostDataContractCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = null,
    Object? title = null,
    Object? body = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostDataContractCopyWith<$Res>
    implements $PostDataContractCopyWith<$Res> {
  factory _$$_PostDataContractCopyWith(
          _$_PostDataContract value, $Res Function(_$_PostDataContract) then) =
      __$$_PostDataContractCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int userId, int id, String title, String body});
}

/// @nodoc
class __$$_PostDataContractCopyWithImpl<$Res>
    extends _$PostDataContractCopyWithImpl<$Res, _$_PostDataContract>
    implements _$$_PostDataContractCopyWith<$Res> {
  __$$_PostDataContractCopyWithImpl(
      _$_PostDataContract _value, $Res Function(_$_PostDataContract) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = null,
    Object? title = null,
    Object? body = null,
  }) {
    return _then(_$_PostDataContract(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostDataContract implements _PostDataContract {
  const _$_PostDataContract(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory _$_PostDataContract.fromJson(Map<String, dynamic> json) =>
      _$$_PostDataContractFromJson(json);

  @override
  final int userId;
  @override
  final int id;
  @override
  final String title;
  @override
  final String body;

  @override
  String toString() {
    return 'PostDataContract(userId: $userId, id: $id, title: $title, body: $body)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostDataContract &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, id, title, body);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostDataContractCopyWith<_$_PostDataContract> get copyWith =>
      __$$_PostDataContractCopyWithImpl<_$_PostDataContract>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostDataContractToJson(
      this,
    );
  }
}

abstract class _PostDataContract implements PostDataContract {
  const factory _PostDataContract(
      {required final int userId,
      required final int id,
      required final String title,
      required final String body}) = _$_PostDataContract;

  factory _PostDataContract.fromJson(Map<String, dynamic> json) =
      _$_PostDataContract.fromJson;

  @override
  int get userId;
  @override
  int get id;
  @override
  String get title;
  @override
  String get body;
  @override
  @JsonKey(ignore: true)
  _$$_PostDataContractCopyWith<_$_PostDataContract> get copyWith =>
      throw _privateConstructorUsedError;
}
