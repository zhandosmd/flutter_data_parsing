import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:lazyload_working_with_data/domain/entity/post.dart';

//запрос для получения данных
class ApiClient{
  final client = HttpClient();

  Future<List<Post>> getPosts() async{
<<<<<<< HEAD
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    // same as  Uri(scheme: 'https', host: 'jsonplaceholder.typicode.com', path: 'posts');
    final request = await client.getUrl(url); // will return FUTURE, await will ждать пока реквест соберутся
=======
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts'); // same as  Uri(scheme: 'https', host: 'jsonplaceholder.typicode.com', path: 'posts');
    final request = await client.getUrl(url); // will return FUTURE, await will ждать пока реквест собереться
>>>>>>> da16e11 (after http lesson)
    final response = await request.close(); // отправили на сервер и ждем респонс
    final jsonStrings = await response.transform(utf8.decoder).toList(); // converting from Stream List<Byte> to String List
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as List<dynamic>;
    final posts = json
        .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
    return posts;
  }
<<<<<<< HEAD
}
=======

  Future<Post?> createPost({required String title, required String body}) async{
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final parameters = <String, dynamic>{
      'title': title,
      'body': body,
      'userId': 109
    };
    final request = await client.postUrl(url);
    request.headers.set('Content-type', 'application/json; charset=UTF-8');
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final post = Post.fromJson(json);
    return post;
  }

  Future<void> fileUpload(File file) async{
    final url = Uri.parse('https://example.com');

    final request = await client.postUrl(url);

    request.headers.set(HttpHeaders.contentTypeHeader, ContentType.binary);
    request.headers.add('filename', basename(file.path));
    request.contentLength = file.lengthSync();
    final fileStream = file.openRead();
    await request.addStream(fileStream);

    final httpResponse = await request.close();

    if(httpResponse.statusCode != 200){
      throw Exception('Error uploading file');
    }else{
      return;
    }
  }
}
>>>>>>> da16e11 (after http lesson)
