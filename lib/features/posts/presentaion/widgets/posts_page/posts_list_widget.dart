import '../../../domain/entities/posts.dart';
import '../../pages/post_detail_page.dart';
import 'package:flutter/material.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostsListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PostDetailPage(post: posts[index]),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
      ),
      itemCount: posts.length,
    );
  }
}
