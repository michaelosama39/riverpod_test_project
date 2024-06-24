import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/api_service.dart';
import 'post_notifier.dart';
import 'post_state.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final postNotifierProvider =
    StateNotifierProvider<PostNotifier, PostState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PostNotifier(apiService);
});
