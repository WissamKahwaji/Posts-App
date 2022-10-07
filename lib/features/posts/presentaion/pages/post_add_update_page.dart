import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/posts.dart';
import '../bloc/add_delete_update/add_delete_update_bloc.dart';
import 'posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/snackbar_message.dart';
import '../widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(isUpdatePost ? 'Edit Post' : 'Add Post'),
    );
  }

  Widget _buildBody() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostsState) {
                return const LoadingWidget();
              }
              return FormWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
            },
            listener: ((context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostsPage()),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            }),
          ),
        ),
      ),
    );
  }
}
