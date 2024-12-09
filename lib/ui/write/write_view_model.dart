// 1. 상태 클래스 만들기
import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WriteState {
  bool isWriting;
  WriteState(this.isWriting);
}

// 2. 뷰모델 만들기

class WriteViewModel extends AutoDisposeFamilyNotifier<WriteState, Post?> {
  @override
  WriteState build(Post? arg) {
    return WriteState(false);
  }

  Future<bool> insert({
    required String writer,
    required String title,
    required String content,
  }) async {
    final postRepository = PostRepository();

    state = WriteState(true);
    if (arg == null) {
      // 포스트 객체가 널이면 : 새로작성
      final result = await postRepository.insert(
        title: title,
        content: content,
        writer: writer,
        imageUrl: 'https://picsum.photos/200/300',
      );
      await Future.delayed(Duration(milliseconds: 500));
      state = WriteState(false);
      return result;
    } else {
      // 널이 아니면 : 수정
      final result = await postRepository.update(
        id: arg!.id, // 널일수도있으니 ! 사용 (어차피 널이 아닐 경우만 사용함)
        writer: writer,
        title: title,
        content: content,
        imageUrl: 'https://picsum.photos/200/300',
      );
      await Future.delayed(Duration(milliseconds: 500));
      return result;
    }
  }

   void uploadImage() async{
    // Firebase Storage 사용법
    // 1. FirebaseStorage 객체 가지고 오기
    // final storage = FirebaseStorage.instance;
    // 2. 스토리치 참조 만들기
    // Reference ref = storage.ref();
    // 3. 파일 참조 만들기
    // 4. 쓰기
    // 5. 파일에 접근할 수 있는 URL 만들기
  }
}

// 3. 뷰모델 관리자 만들기
final writeViewModelProvider = NotifierProvider.autoDispose.family<WriteViewModel, WriteState, Post?>(
  (){
    return WriteViewModel();
  }
);