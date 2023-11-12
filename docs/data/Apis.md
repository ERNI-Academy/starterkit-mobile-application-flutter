API classes are one of the (remote) data sources of our application. It is used for REST API calls. Typically we cached the data from the API calls in the database. This is important if you plan to support offline functionality in your application.

The project uses [`retrofit`](https://pub.dev/packages/retrofit) to generate the code needed for the API classes.

## Creating an API

```dart
// coverage:ignore-file

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:starterkit_app/core/data/api/dio_provider.dart';

part 'post_api.g.dart';

@lazySingleton
@RestApi()
abstract interface class PostApi {
  @factoryMethod
  factory PostApi(DioProvider dioProvider) => _PostApi(dioProvider.create<PostApi>());

  @GET('/posts')
  Future<List<PostDataContract>> getPosts();
}

```
- We can annotate the methods according to the HTTP method they will perform (i.e. `GET` or `POST`).
- The `@AuthHeader` annotates the parameter that will be passed as the request's authorization header.
- The `@Body` annotates the parameter that will be passed as the request's body.
- `@lazySingleton` is used to register the class in the dependency injection container as a single instance every time it is resolved.
- `DioProvider` is a class that provides a `Dio` instance with the necessary configurations for the API calls. This also sets the base URL for the API calls.

:bulb: **<span style="color: green">TIP</span>**

- Use the code snippet shortcut `api` to create an API class.