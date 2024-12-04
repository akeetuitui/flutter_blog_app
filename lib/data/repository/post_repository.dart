// Firebase firestore에서 데이터를 가져와요

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_blog_app/data/model/post.dart';

class PostRepository {
  Future<List<Post>?> getAll() async {
    // firestore에서 게시글 데이터를 가져오는 함수
    // 비동기 작업 - 데이터 가져오는 데 시간이 걸려도 앱이 멈추지 않음
    try {
      // 1. 파이어스토어 인스턴스 가지고오기
      final firestore = FirebaseFirestore.instance;
      // 2. 컬렉션 참조 만들기
      // posts라는 이름의 컬렉션에 게시글 데이터가 들어 있다고 가정하고, 참조를 만듦!
      final collectionRef = firestore.collection('posts');
      // 3. 값 불러오기
      final result = await collectionRef.get();
      final docs = result.docs; // docs라는 변수에 저장, 문서의 리스트로 반환
      return docs.map((doc) {
        final map = doc.data();
        final newMap = {
          'id': doc.id,
          ...map, // 스프레드 연산자, 새로운 맵을 기존 맵에 합쳐서 풀어서 쓰기!
        };
        return Post.fromJson(newMap);
      }).toList();
    } catch (e) {
      print(e); // Firebase 세팅에 에러가 났을 때, null 리턴!
      return null;
    }
  }

  // 1. Creat: 데이터 쓰기
  Future<bool> insert({
    required String title,
    required String content,
    required String writer,
    required String imageUrl,
    // 비동기니까 Return 타입은 Future!
    // Firestore의 'Posts' 컬렉션에 새 데이터 추가하는 함수
  }) async {
    try {
      // 1) 파이어스토어 인스턴스 가지고오기
      final firestore = FirebaseFirestore.instance;
      // 2) 컬렉션 참조 만들기
      final collectionRef = firestore.collection('posts');
      // 3) 문서 참조 만들기
      final docRef = collectionRef.doc(); // 비워놓아야 자동으로 고유ID를 만들어줌(posts 컬렉션 안에)
      // 4) 값 쓰기
      await docRef.set({
        'title': title,
        'content': content,
        'writer': writer,
        'imageUrl': imageUrl
      });
      return true; // 리턴타입에 bool, try문안에 잘 작동이 될 시 true
    } catch (e) {
      print(e);
      // 에러가 났을 때 e 값 출력, 에러 내용 출력!
      return false;
    }
  }

  // 2. Read: 특정 ID로 하나의 도큐먼트 가져오기

  // 3. Update : 도큐먼트 수정

  // 4. Delete: 도큐먼트 삭제
}
