

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Text('DetailPage'),
    );
  }

  Widget iconButton(IconData icon, void Function() onTap){ // 파라미터로 뭘 받을까 1. 아이콘 버튼이 달라짐 2. onTap 눌렀을 때 들어갈 함수들이 다름
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