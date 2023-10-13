Mappers are domain classes that convert objects from one type to another. They are useful when we want to convert data from one layer to another.

```dart
abstract interface class ObjectMapper {
  T mapObject<S, T>(S? object);

  Iterable<T> mapObjects<S, T>(Iterable<S> objects);
}
```

- `mapObject` converts a single object from one type to another.
- `mapObjects` converts a list of objects from one type to another.
  

We use [`auto_mappr`](https://pub.dev/packages/auto_mappr) to generate mappers. This package uses [`build_runner`](https://pub.dev/packages/build_runner) to generate mappers.

Below is an example of a mapper class:


```dart
abstract interface class PostMapper implements ObjectMapper {}

@AutoMappr(<MapType<Object, Object>>[
  MapType<PostDataContract, PostEntity>(),
  MapType<PostDataContract, PostDataObject>(fields: <Field>[
    Field.from('postId', from: 'id'),
  ]),
  MapType<PostDataObject, PostEntity>(fields: <Field>[
    Field.from('id', from: 'postId'),
  ]),
])
@LazySingleton(as: PostMapper)
class PostMapperImpl extends $PostMapperImpl implements PostMapper {
  @override
  T mapObject<S, T>(S? object) => convert(object);

  @override
  Iterable<T> mapObjects<S, T>(Iterable<S> objects) => convertIterable(objects);
}
```

- `@AutoMappr` is used to annotate the class as a mapper. The `MapType` parameter is used to specify the mapping between two types. The `fields` parameter is used to specify the mapping between two fields. The `from` parameter is used to specify the name of the field to map from. The `to` parameter is used to specify the name of the field to map to. If the `to` parameter is not specified, the name of the field to map to will be the same as the name of the field to map from.
- We implicitly added a field mapping from `PostDataContract.id` to `PostDataObject.postId` and vice versa. This is because the `id` field of `PostDataContract` is mapped to the `postId` field of `PostDataObject` by default.
- After implementing `ObjectMapper`, we point the implemented methods to the generated methods from `$PostMapperImpl`.

:bulb: **<span style="color: green">TIP</span>**

- Use the code snippet shortcut `mapper` to create a mapper class.