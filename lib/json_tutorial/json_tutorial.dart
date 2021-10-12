import 'dart:convert';

import 'address.dart';
import 'human.dart';

class JsonExampleCoder{
  void encode(){
    final objects = humans.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(objects);
  }
  void decode(){
    try{
      final json = jsonDecode(jsonString) as List<dynamic>;
      final humans = json
          .map((dynamic e) => Human.fromJson(e as Map<String, dynamic>))
          .toList();
      print(humans);
    }catch(error){
      print(error);
    }
  }
}

final humans =[
  Human(
      name: 'Иван',
      surname: 'Иванов',
      age: 17,
      addreses: [
        Address(city: 'Москва', street: 'Баумана', house: '12a', flat: 12),
        Address(city: 'Москва', street: 'Баумана', house: '12a', flat: 12),
        Address(city: 'Москва', street: 'Баумана', house: '12a', flat: 12),
      ]
  ),
  Human(
      name: 'Иван',
      surname: 'Иванов',
      age: 17,
      addreses: [
        Address(city: 'Москва', street: 'Баумана', house: '12a', flat: 12),
        Address(city: 'Москва', street: 'Баумана', house: '12a', flat: 12),
        Address(city: 'Москва', street: 'Баумана', house: '12a', flat: 12),
      ]
  ),
];

const jsonString = '''
  [ 
    {
      "name": "Иван",
      "surname": "Иван",
      "age": "Иван",
      "addreses": [
        {
          "city": "Москва",
          "street": "Баумана",
          "house": "12а",
          "flat": 12,
        },
        {
          "city": "Новосибирск",
          "street": "Батурина",
          "house": "1",
          "flat": 1,
        },
        {
          "city": "Питер",
          "street": "Моховая",
          "house": "198г",
          "flat": 561,
        },
      ],
    },
    {
      "name": "Иван",
      "surname": "Иван",
      "age": "Иван",
      "addreses": [
        {
          "city": "Москва",
          "street": "Баумана",
          "house": "12а",
          "flat": 12,
        },
        {
          "city": "Новосибирск",
          "street": "Батурина",
          "house": "1",
          "flat": 1,
        },
        {
          "city": "Питер",
          "street": "Моховая",
          "house": "198г",
          "flat": 561,
        },
      ],
    },
  ]
''';