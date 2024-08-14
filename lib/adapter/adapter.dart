import 'dart:convert';

class Api1 {
  String getYoutube() {
    return '''
[
{

  "title": "Video 1",
  "description": "description1"},{

  "title": "Video 2",
  "description": "description2"}
  ]''';
  }
}

class Api2 {
  String getMedium() {
    return '''
[
{
  "title": "Blog 1",
  "description": "description1"},
  {
  "title": "Blog 2",
  "description": "description2"}
  ]''';
  }
}

abstract class IApi {
  List<Post> getPosts();
}

class Post {
  final String title;
  final String bio;
  Post({required this.title, required this.bio});
}

class Api1Adapter implements IApi {
  final api = Api1();
  @override
  List<Post> getPosts() {
    final data = jsonDecode(api.getYoutube()) as List;
    return data
        .map((e) => Post(title: e['title'], bio: e['description']))
        .toList();
  }
}

class Api2Adapter implements IApi {
  final api = Api2();
  @override
  List<Post> getPosts() {
    final data = jsonDecode(api.getMedium()) as List;
    return data
        .map((e) => Post(title: e['title'], bio: e['description']))
        .toList();
  }
}

class PostApi implements IApi {
  final api1 = Api1Adapter();
  final api2 = Api2Adapter();
  @override
  List<Post> getPosts() {
    return api1.getPosts() + api2.getPosts();
  }
}
