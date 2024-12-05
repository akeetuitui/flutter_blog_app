import 'package:flutter/material.dart';
import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/ui/write/write_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WritePage extends ConsumerStatefulWidget {
  WritePage(this.post);

  Post? post; // 새로 작성할 땐 Null로 넘어 옴

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  // 제목, 작성자, 내용
  late TextEditingController writeController = TextEditingController(
    text: widget.post?.writer ?? '', // 편집할 게시글이 있는 경우 post, 없는 경우 빈 문자열로 초기화
  );
  late TextEditingController titleController = TextEditingController(
    text: widget.post?.title ?? '',
  );
  late TextEditingController contentController = TextEditingController(
    text: widget.post?.content ?? '',
  );

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
    final writeState = ref.watch(writeViewModelProvider(widget.post));
    if (writeState.isWriting){
      return Scaffold(
        appBar:  AppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return GestureDetector(
      onTap: () {
        //
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            actions: [
              GestureDetector(
                onTap: ()async{
                  print('완료 버튼 클릭'); // onTap 시에는 꼭 이런 형태의 출력문 넣기!
                  final result = formKey.currentState?.validate() ?? false; // return이 불리언 타입 (모든 필드가 성공했을때)!
                  if (result){
                    final vm = ref.read(writeViewModelProvider(widget.post).notifier);
                    final insertResult = await vm.insert(
                      writer: writeController.text,
                      title: titleController.text,
                      content: contentController.text,
                      );
                      if (insertResult){
                        Navigator.pop(context);
                      }
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: const Text(
                    '완료',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: Form(
            key: formKey,
              child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              TextFormField(
                controller: writeController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(hintText: '작성자'),
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
                decoration: const InputDecoration(hintText: '제목'),
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
                  decoration: const InputDecoration(hintText: '내용'),
                  validator: (value) {
                    // trim: 문자열 앞 뒤로 공백 제거
                    if(value?.trim().isEmpty ?? true) { // Null 일 때에 true로 넣어 null 일 때에도 문구가 나오도록!
                      return '내용을 입력해주세요';
                    }
                    return null; // 저 상황이 아니라면 유효성 검사 성공!
                  },
                ),
              ),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                  child: const Icon(Icons.image),
                  ),
              ),
            ],
          ))),
    );
  }
}
