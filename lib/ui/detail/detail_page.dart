import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            iconButton(Icons.delete, () {
              print('삭제 아이콘 클릭');
            }),
            iconButton(Icons.edit, () {
              print('수정 아이콘 클릭');
            }),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.only(bottom: 500),
          children: [
            Image.network(
              'https://picsum.photos/200/300',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today I learned',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    '이지원',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '2024.12.25 12:00',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    '플러터의 그리드뷰를 배웠습니다.' * 10,
                    style: TextStyle(fontSize: 16),
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
