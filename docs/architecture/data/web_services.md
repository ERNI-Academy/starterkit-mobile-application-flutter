# Web Services

Web service classes are used for REST API calls. 

The blueprint uses [`retrofit`](https://pub.dev/packages/retrofit) to generate the code.

```dart
@lazySingleton
@RestApi()
abstract class PostService {
  @factoryMethod
  factory PostService(DioProvider dioProvider) {
    final dio = dioProvider.createDio(loggerName: 'PostService');
    return _PostService(dio, baseUrl: ApiEndpoints.baseUrl);
  }

  @GET(ApiEndpoints.allPosts)
  Future<List<PostContract>> getAllPosts(@AuthHeader() String authToken);

  @POST(ApiEndpoints.createPost)
  Future<void> createPost(@Body() CreateOrUpdatePostContract contract, @AuthHeader() String authToken);
}
```
- We can annotate the methods according to the HTTP method they will perform (i.e. `GET` or `POST`).
- The `@AuthHeader` annotates the parameter that will be passed as the request's authorization header.
- The `@Body` annotates the parameter that will be passed as the request's body.

:bulb: **<span style="color: green">TIP</span>**

Use the code snippet shortcut `webs` to create a web service class.