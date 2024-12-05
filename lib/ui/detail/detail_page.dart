import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/ui/detail/detail_view_model.dart';
import 'package:flutter_firebase_blog_app/ui/write/write_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends ConsumerWidget {
  DetailPage(this.post);
  Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Family를 통해 전달된 Post 객체 가져와서 State에 저장
    final state = ref.watch(detailViewModelProvider(post));

    return Scaffold(
        appBar: AppBar(
          actions: [
            iconButton(Icons.delete, () async {
              print('삭제 아이콘 클릭');
              final vm = ref.read(detailViewModelProvider(post).notifier); // Viewmodel의 인스턴스를 가져옴
              final result = await vm.deletePost(); // 메서드 호출, 게시글 삭제 요청
              if(result) {
                Navigator.pop(context); // 삭제 성공하면 이전 화면으로 복귀
              }
            }),
            iconButton(Icons.edit, () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return WritePage(); // 편집 버튼 클릭 시 writepage로 이동
              }), 
              );
            }),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 500),
          children: [
            Image.network(
              state.imageUrl,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    state.writer,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    state.creatAt.toIso8601String(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    state.content,
                    style: const TextStyle(fontSize: 16),
                  ), // 곱셉연산자 넣으면 글자 반복
                ],
              ),
            ),
          ],
        ));
  }

  Widget iconButton(IconData icon, void Function() onTap) {
    // 파라미터로 뭘 받을까 1. 아이콘 버튼이 달라짐 2. onTap 눌렀을 때 들어갈 함수들이 다름
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        color: Colors.transparent,
        child: Icon(icon),
      ),
    );
  }
}
