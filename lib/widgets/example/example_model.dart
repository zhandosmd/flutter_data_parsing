import 'package:flutter/material.dart';
import 'package:lazyload_working_with_data/domain/api_clients/api_client.dart';
import 'package:lazyload_working_with_data/domain/entity/post.dart';

class ExampleWidgetModel extends ChangeNotifier{
  final apiClient = ApiClient();
  var _posts = <Post>[];
  List<Post> get posts => _posts;

  Future<void> reloadPosts() async{
    final posts = await apiClient.getPosts();
    _posts += posts;
    notifyListeners();
  }
  Future<void> createPosts() async{
    final posts = await apiClient.createPost(title: 'dsads', body: 'zhai post');
  }
}

class ExampleModelProvider extends InheritedNotifier {
  final ExampleWidgetModel model;
  const ExampleModelProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(key: key, notifier: model, child: child);

  static ExampleModelProvider? watch(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<ExampleModelProvider>();
  }  // subcribe to changes
  static ExampleModelProvider? read(BuildContext context){
    final widget =  context
        .getElementForInheritedWidgetOfExactType<ExampleModelProvider>()
        ?.widget;
    return widget is ExampleModelProvider ? widget : null;
  } // just get data
}