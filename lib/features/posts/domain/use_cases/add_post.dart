import '../entities/posts.dart';
import '../repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class AddPostUseCase {
  final PostsRepository repository;

  AddPostUseCase(this.repository);
  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
