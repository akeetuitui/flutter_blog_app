// 1. 상태 클래스 만들기
// => 디테일 페이지로 넘어올 때는 목록에서 Post 객체 그대로 가져오면 돼서 뷰모델 필요 없음!

// 2. 뷰모델 만들기
import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailViewModel extends AutoDisposeFamilyNotifier<Post, Post> {
  // Family를 통해 인자를 전달받는 Notifier
  // Autodispose는 사용되지 않는 상태를 자동으로 정리(메모리 해제)
  // Post 상태를 관리하고 반환
  @override
  Post build(Post arg) {
    listenStream();
    return arg;
  }
  // Family로 전달받은 인자를 초기 상태로 설정

  final postRepository = PostRepository();

  Future<bool> deletePost() async {
    // PostRepository 호출해서 Firestore에서 해당 게시글 삭제
    return await postRepository.delete(arg.id); // 상세페이지 해당 포스트의 id
  }

  void listenStream() {
    final stream = postRepository.postStream(arg.id);
    final streamSub = stream.listen((data) {
      if (data != null) {
        state = data;
      }
    });
    ref.onDispose(() {
      streamSub.cancel();
    });
  }
}

// 3. 뷰모델 관리자 만들기

final detailViewModelProvider =
    NotifierProvider.autoDispose.family<DetailViewModel, Post, Post>(() {
  return DetailViewModel(); // DetailViewModel 인스턴스 생성
});
