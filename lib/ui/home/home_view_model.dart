import 'dart:async';

import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// 1. 상태클래스 만들기
// List<Post>


// 2. 뷰모델 만들기
// firestroe의 게시글 리스트를 실시간으로 관리하는 뷰모델 구현
class HomeViewModel extends Notifier<List<Post>> { // state를 List<Post>로 관리하는 Notifier
  @override
  List<Post> build() { // 게시글 데이터를 가져오는 getAllPosts 메서드 실행
    getAllPosts();
   return [];
  }

  void getAllPosts() async {
    final postRepo = PostRepository();
    // final posts = await postRepo.getAll();
    // state = posts ?? [];
    final stream = postRepo.postListStream();
    final StreamSubscription = stream.listen((posts){ 
      // stream 데이터 구독, 새로운 데이터 올 때마다 상태 업데이트
      state = posts;
      // Notifier의 상태 업데이트, 상태 변경시 riverpod이 자동으로 Ui 업데이트
    });
     // 이 뷰모델이 없어질 때 넘겨준 함수 호출
    ref.onDispose((){
      // 구독하고 있는 Stream의 구독을 끊어줘야 메모리에서 안전하게 제거
      // 구독을 끊어주는 방법은 Stream listen할 때 리턴받는 StreamSubscription 클래스의
      // cancel 메서드 호출
      StreamSubscription.cancel(
      );
    });
  }
}

// 3. 뷰모델 관리자 만들기
final HomeViewModelProvider = NotifierProvider<HomeViewModel, List<Post>>((){
  return HomeViewModel();
});