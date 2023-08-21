import 'dart:convert';
import 'package:gazoo/app/data/models/clients.dart';
import 'package:http/http.dart' as http;

import '../../core/widgets/snackbar.dart';

String urlBase = "http://gazoo.alwaysdata.net";

class ClientsProvider {
  Future<Clients?> createAccount(
      {required String name,
      required String surname,
      required String address,
      required String phone}) async {
    final response = await http.post(
      Uri.parse("$urlBase/gazoo/clients/save"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': name,
        'surname': surname,
        'address': address,
        'phone': phone
      }),
    );

    if (response.statusCode == 201) {
      return Clients.fromJson(jsonDecode(response.body));
    } else {
      (Snackbar.showSnackbar(
          title: "Erreur",
          message: "Ce Compte est déjà utilisé"));
          return null;
    }
  }
}
