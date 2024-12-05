import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_blog_app/data/model/post.dart';
import 'package:flutter_firebase_blog_app/ui/detail/detail_page.dart';
import 'package:flutter_firebase_blog_app/ui/home/home_view_model.dart';
import 'package:flutter_firebase_blog_app/ui/write/write_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLOG'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return WritePage(null); // 새로 작성이니까 Null
            }),
          );
        },
        child: const Icon(Icons.edit),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            const Text(
              '최근글',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Riverpod 사용해 최신 글 목록 표시
            Consumer(
              builder: (context, ref, child) {
                final posts = ref.watch(HomeViewModelProvider);
                // 홈뷰모델에서 가져온 게시글 데이터를 posts로 사용
                return Expanded(
                  child: ListView.separated(
                    // llistview 를 반복해서 보여주는데 사이즈드 박스를 넣는 것과 같이 구성!
                    itemCount: posts.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    itemBuilder: (context, index) { // 리스트에서 하나의 아이템을 그리는 함수 (itemBuilder)
                      final post = posts[index]; // posts에서 Index에 해당하는 데이터를 가져옴
                      return item(post); // 게시글 데이터를 받아서 개별 게시글 위젯을 만들어 반환
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget item(Post post) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          //
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailPage(post);
          }));
        },
        child: SizedBox(
          width: double.infinity,
          height: 120,
          child: Stack(
            children: [
              //
              Positioned(
                right: 0,
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                  post.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.only(right: 100),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      post.content,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Text(post.creatAt.toIso8601String(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
