import 'package:flutter/material.dart';

class WritePage extends StatefulWidget {
  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  // 제목, 작성자, 내용
  TextEditingController writeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    writeController.dispose(); // dispose 해줘야 나간 후에 메모리에 떠돌지 않음!
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(),
          body: Form(
              child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              TextFormField(
                controller: writeController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(hintText: '작성자'),
                validator: (value) {
                  // trim: 문자열 앞 뒤로 공백 제거
                  if(value?.trim().isEmpty ?? true) { // Null 일 때에 true로 넣어 null 일 때에도 문구가 나오도록!
                    return '작성자를 입력해주세요';
                  }
                  return null; // 저 상황이 아니라면 유효성 검사 성공!
                },
              ),
              TextFormField(
                controller: titleController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(hintText: '제목'),
                validator: (value) {
                  // trim: 문자열 앞 뒤로 공백 제거
                  if(value?.trim().isEmpty ?? true) { // Null 일 때에 true로 넣어 null 일 때에도 문구가 나오도록!
                    return '제목을 입력해주세요';
                  }
                  return null; // 저 상황이 아니라면 유효성 검사 성공!
                },
              ),
              SizedBox(
                height: 200,
                child: TextFormField(
                  controller: contentController,
                  maxLines: null, // 반드시 null로 할당 (개행할 때)
                  expands: true, // sizedbox로 height설정 후 꼭 expands, 크기 늘릴 시 필수임!
                  textInputAction: TextInputAction.newline, // 내용 입력 시 여러 줄 입력할 때 필요! (newline)
                  decoration: InputDecoration(hintText: '내용'),
                  validator: (value) {
                    // trim: 문자열 앞 뒤로 공백 제거
                    if(value?.trim().isEmpty ?? true) { // Null 일 때에 true로 넣어 null 일 때에도 문구가 나오도록!
                      return '내용을 입력해주세요';
                    }
                    return null; // 저 상황이 아니라면 유효성 검사 성공!
                  },
                ),
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                  child: Icon(Icons.image),
                  ),
              ),
            ],
          ))),
    );
  }
}
