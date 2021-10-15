import 'package:flutter/material.dart';
import 'package:lazyload_working_with_data/domain/api_clients/api_client.dart';
import 'package:lazyload_working_with_data/inherited/inherited_example.dart';
import 'package:lazyload_working_with_data/widgets/example/example.dart';

import 'json_tutorial/json_tutorial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final post = ApiClient().getPosts();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExampleHttp(),
    );
  }
}
