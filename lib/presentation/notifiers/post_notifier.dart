import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/api_service.dart';
import 'post_state.dart';

class PostNotifier extends StateNotifier<PostState> {
  final ApiService apiService;

  PostNotifier(this.apiService) : super(PostInitial());

  Future<void> fetchPosts() async {
    try {
      state = PostLoading();
      final posts = await apiService.fetchPosts();
      state = PostLoaded(posts);
    } catch (e) {
      state = PostError(e.toString());
    }
  }
}
