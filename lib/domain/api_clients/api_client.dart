import 'dart:convert';
import 'dart:io';

import 'package:lazyload_working_with_data/domain/entity/post.dart';

//запрос для получения данных
class ApiClient{
  final client = HttpClient();

  Future<List<Post>> getPosts() async{
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    // same as  Uri(scheme: 'https', host: 'jsonplaceholder.typicode.com', path: 'posts');
    final request = await client.getUrl(url); // will return FUTURE, await will ждать пока реквест собереться
    final response = await request.close(); // отправили на сервер и ждем респонс
    final jsonStrings = await response.transform(utf8.decoder).toList(); // converting from Stream List<Byte> to String List
    final jsonString = jsonStrings.join() as List<dynamic>;
    final posts = jsonString
        .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
    return posts;
  }
}