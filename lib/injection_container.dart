import 'core/network/network_info.dart';
import 'features/posts/data/data_resources/local_data_source.dart';
import 'features/posts/data/data_resources/remote_data_source.dart';
import 'features/posts/data/repositories/post_repository_impl.dart';
import 'features/posts/domain/repositories/posts_repository.dart';
import 'features/posts/domain/use_cases/add_post.dart';
import 'features/posts/domain/use_cases/delete_post.dart';
import 'features/posts/domain/use_cases/get_all_posts.dart';
import 'features/posts/domain/use_cases/update_post.dart';
import 'features/posts/presentaion/bloc/add_delete_update/add_delete_update_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/posts/presentaion/bloc/posts/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() =>
      AddDeleteUpdateBloc(addPost: sl(), updatePost: sl(), deletePost: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

// Repository

  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
