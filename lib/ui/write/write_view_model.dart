// 1. 상태 클래스 만들기
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class WriteState {
  bool isWriting;
  String? imageUrl;
  WriteState(this.isWriting, this.imageUrl);
}

// 2. 뷰모델 만들기
class WriteViewModel extends AutoDisposeFamilyNotifier<WriteState, Post?> {
  @override
  WriteState build(Post? arg) {
    return WriteState(false, arg?.imageUrl);
  }

  Future<bool> insert({
    required String writer,
    required String title,
    required String content,
  }) async {
    if (state.imageUrl == null) {
      return false;
    }
    final postRepository = PostRepository();

    state = WriteState(true, state.imageUrl);
    if (arg == null) {
      // 포스트 객체가 널이면 : 새로작성
      final result = await postRepository.insert(
        title: title,
        content: content,
        writer: writer,
        imageUrl: state.imageUrl!,
      );
      await Future.delayed(Duration(milliseconds: 500));
      state = WriteState(false, state.imageUrl);
      return result;
    } else {
      // 널이 아니면 : 수정
      final result = await postRepository.update(
        id: arg!.id, // 널일수도있으니 ! 사용 (어차피 널이 아닐 경우만 사용함)
        writer: writer,
        title: title,
        content: content,
        imageUrl: state.imageUrl!,
      );
      await Future.delayed(Duration(milliseconds: 500));
      return result;
    }
  }

  void uploadImage(XFile xFile) async {
    try {
      // Firebase Storage 사용법
      // 1. FirebaseStorage 객체 가지고 오기
      final storage = FirebaseStorage.instance;
      // 2. 스토리치 참조 만들기
      Reference ref = storage.ref();
      // 3. 파일 참조 만들기
      Reference fileRef =
          ref.child('${DateTime.now().microsecondsSinceEpoch}_${xFile.name}');
      // 4. 쓰기!
      await fileRef.putFile(File(xFile.path));
      // 5. 파일에 접근할 수 있는 URL 만들기
      String imageUrl = await fileRef.getDownloadURL();
      state = WriteState(state.isWriting, imageUrl);
    } catch (e) {
      print(e);
    }
  }
}

// 3. 뷰모델 관리자 만들기
final writeViewModelProvider =
    NotifierProvider.autoDispose.family<WriteViewModel, WriteState, Post?>(() {
  return WriteViewModel();
});
