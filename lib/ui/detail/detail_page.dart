import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_blog_app/ui/write/write_page.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            iconButton(Icons.delete, () {
              print('삭제 아이콘 클릭');
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
              'https://picsum.photos/200/300',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Today I learned',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    '이지원',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Text(
                    '2024.12.25 12:00',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    '플러터의 그리드뷰를 배웠습니다.' * 10,
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
