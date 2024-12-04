// 게시글(Post)이라는 데이터를 만들고 관리하는 다트파일
// 게시글 정보를 쉽게 만들고 관리하기 위해 JSON 데이터 사용

class Post { // 포스트 클래스 생성!
  String id;
  String title;
  String content;
  String writer;
  String imageUrl;
  DateTime creatAt;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.writer,
    required this.imageUrl,
    required this.creatAt,
  });
  // 1. fromJson 네임드 생성자 만들기
  // 서버에서 받은 JSON 데이터를 게시글 객체(Post)로 변환! -> 앱에서 게시글 관리하고 다시 서버로 JSON 보내기(2번)
  Post.fromJson(Map<String,dynamic> map) : this(
    id: map['id'],
    title: map['title'],
    content: map['content'],
    writer: map['writer'],
    imageUrl: map['imageUrl'],
    creatAt: DateTime.parse(map['createdAt']),
  );

  // 2. toJson 메서드 만들기
  // 다시 JSON으로 변환해서 서버에 데이터 전송!
  Map<String, dynamic> toJson(){
    return {
      'id':id,
      'title':title,
      'content':content,
      'writer':writer,
      'imageUrl':imageUrl,
      'createdAt':creatAt.toIso8601String(), // ISO 8601 형식의 문자열로 변환! (예: 2023-12-01T12:34:56.789Z.)
    };
  }
}