import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getCachedPost();
  Future<Unit> cachePosts(List<PostModel> postModels);
}

const cachedPost = 'CACHED_POSTS';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(cachedPost, json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPost() {
    final jsonString = sharedPreferences.getString(cachedPost);
    if (jsonString != null) {
      List decodJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
