// ignore_for_file: prefer-static-class

import 'package:mockito/annotations.dart';
import 'package:starterkit_app/core/domain/result.dart';
import 'package:starterkit_app/features/posts/domain/entities/post_entity.dart';
import 'package:starterkit_app/features/posts/domain/services/posts_service.dart';

@GenerateNiceMocks([
  MockSpec<PostsService>(
    // We need to explicitly specify the method's return value since Mockito cannot mock final/sealed classes
    // See https://github.com/dart-lang/mockito/issues/635 for more details
    fallbackGenerators: {#getPosts: getPosts},
  ),
])
void main() {}

Future<Result<Iterable<PostEntity>>> getPosts() async => const Success([]);
