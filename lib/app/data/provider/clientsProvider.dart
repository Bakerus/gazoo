
import 'dart:convert';

import 'package:gazoo/app/data/models/clients.dart';
import 'package:http/http.dart' as http;

String urlBase = "http://gazoo.alwaysdata.net";
class ClientsProvider{


Future<Clients> createAccount({required String name, required String surname, required String address, required String phone}) async{
  final response = await http.post(
    Uri.parse("$urlBase/gazoo/clients/save"),
    headers: <String, String> {
     'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'name':name,
      'surname':surname,
      'address':address,
      'phone':phone
    }),
  );

  if(response.statusCode == 201 ){
    print(response.body);
    return Clients.fromJson(jsonDecode(response.body));
  }else{
    print(response.statusCode);
    throw Exception('Failed to create user Account');
  }

}

}