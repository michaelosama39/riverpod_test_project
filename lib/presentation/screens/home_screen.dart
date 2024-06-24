import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/post_provider.dart';
import '../notifiers/post_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postState = ref.watch(postNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(postNotifierProvider.notifier).fetchPosts(),
      ),
      body: postState is PostLoading
          ? const Center(child: CircularProgressIndicator())
          : postState is PostLoaded
              ? ListView.builder(
                  itemCount: postState.posts.length,
                  itemBuilder: (context, index) {
                    final post = postState.posts[index];
                    return ListTile(
                      title: Text(post['title']),
                      subtitle: Text(post['body']),
                    );
                  },
                )
              : postState is PostError
                  ? Center(child: Text('Error: ${postState.message}'))
                  : const Center(child: Text('Press the button to load posts')),
      // body: postsAsyncValue.when(
      //   data: (posts) {
      //     return ListView.builder(
      //       itemCount: posts.length,
      //       itemBuilder: (context, index) {
      //         final post = posts[index];
      //         return ListTile(
      //           title: Text(post['title']),
      //           subtitle: Text(post['body']),
      //         );
      //       },
      //     );
      //   },
      //   loading: () => const Center(child: CircularProgressIndicator()),
      //   error: (err, stack) => Center(child: Text('Error: $err')),
      // ),
    );
  }
}
