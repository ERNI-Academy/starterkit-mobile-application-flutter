# APIs

API classes are used for REST API calls. 

The blueprint uses [`retrofit`](https://pub.dev/packages/retrofit) to generate the code.

```dart
abstract class PostApi {
  Future<Iterable<PostContract>> getAllPosts(String authToken);

  Future<void> createPost(CreateOrUpdatePostContract contract, String authToken);
}

@LazySingleton(as: PostApi)
@RestApi()
abstract class PostApiImpl implements PostApi {
  @factoryMethod
  factory PostApiImpl(@apiBaseUrl String baseUrl) {
    final dio = DioProvider.createDio(apiName: 'PostApi');
    return _PostApiImpl(dio, baseUrl: baseUrl);
  }

  @GET(ApiEndpoints.allPosts)
  @override
  Future<List<PostContract>> getAllPosts(@AuthHeader() String authToken);

  @POST(ApiEndpoints.createPost)
  @override
  Future<void> createPost(@Body() CreateOrUpdatePostContract contract, @AuthHeader() String authToken);
}
```
- We can annotate the methods according to the HTTP method they will perform (i.e. `GET` or `POST`).
- The `@AuthHeader` annotates the parameter that will be passed as the request's authorization header.
- The `@Body` annotates the parameter that will be passed as the request's body.

:bulb: **<span style="color: green">TIP</span>**

- Use the code snippet shortcut `api` to create an API class.