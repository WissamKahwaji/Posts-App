import '../entities/posts.dart';
import '../repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class UpdatePostUseCase {
  final PostsRepository repository;

  UpdatePostUseCase(this.repository);
  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
