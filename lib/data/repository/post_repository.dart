// Firebase firestore에서 데이터를 가져와요

import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepository {

    Future<void> getAll() async { // firestore에서 게시글 데이터를 가져오는 함수
    // 비동기 작업 - 데이터 가져오는 데 시간이 걸려도 앱이 멈추지 않음
        // 1. 파이어스토어 인스턴스 가지고오기
        final firestore = FirebaseFirestore.instance;
        // 2. 컬렉션 참조 만들기
        // posts라는 이름의 컬렉션에 게시글 데이터가 들어 있다고 가정하고, 참조를 만듦!
        final collectionRef = firestore.collection('posts');
        // 3. 값 불러오기
        final result = await collectionRef.get();

        final docs = result.docs; // docs라는 변수에 저장, 문서의 리스트로 반환

        for (var doc in docs) {
          print(doc.id);
          print(doc.data());
          
        }
    }
}