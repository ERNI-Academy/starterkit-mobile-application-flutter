// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_data_object.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PostDataObject {
  int get userId => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PostDataObjectCopyWith<PostDataObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostDataObjectCopyWith<$Res> {
  factory $PostDataObjectCopyWith(
          PostDataObject value, $Res Function(PostDataObject) then) =
      _$PostDataObjectCopyWithImpl<$Res, PostDataObject>;
  @useResult
  $Res call({int userId, int id, String title, String body});
}

/// @nodoc
class _$PostDataObjectCopyWithImpl<$Res, $Val extends PostDataObject>
    implements $PostDataObjectCopyWith<$Res> {
  _$PostDataObjectCopyWithImpl(this._value, this._then);

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
abstract class _$$_PostDataObjectCopyWith<$Res>
    implements $PostDataObjectCopyWith<$Res> {
  factory _$$_PostDataObjectCopyWith(
          _$_PostDataObject value, $Res Function(_$_PostDataObject) then) =
      __$$_PostDataObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int userId, int id, String title, String body});
}

/// @nodoc
class __$$_PostDataObjectCopyWithImpl<$Res>
    extends _$PostDataObjectCopyWithImpl<$Res, _$_PostDataObject>
    implements _$$_PostDataObjectCopyWith<$Res> {
  __$$_PostDataObjectCopyWithImpl(
      _$_PostDataObject _value, $Res Function(_$_PostDataObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? id = null,
    Object? title = null,
    Object? body = null,
  }) {
    return _then(_$_PostDataObject(
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

class _$_PostDataObject implements _PostDataObject {
  const _$_PostDataObject(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

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
    return 'PostDataObject(userId: $userId, id: $id, title: $title, body: $body)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostDataObject &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, id, title, body);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostDataObjectCopyWith<_$_PostDataObject> get copyWith =>
      __$$_PostDataObjectCopyWithImpl<_$_PostDataObject>(this, _$identity);
}

abstract class _PostDataObject implements PostDataObject {
  const factory _PostDataObject(
      {required final int userId,
      required final int id,
      required final String title,
      required final String body}) = _$_PostDataObject;

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
  _$$_PostDataObjectCopyWith<_$_PostDataObject> get copyWith =>
      throw _privateConstructorUsedError;
}
