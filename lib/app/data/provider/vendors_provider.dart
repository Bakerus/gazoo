import 'dart:convert';
import 'package:gazoo/app/data/models/bottle_lot.dart';
import 'package:gazoo/app/data/models/vendors.dart';
import 'package:http/http.dart' as http;

class VendorsProvider {
  
  String urlBase = "http://gazoo.alwaysdata.net";

  List<Vendors> parseVendors({required String responseBody}){
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Vendors>((json) => Vendors.fromJson(json)).toList();
  }

    List<BottleLot> parseBottles({required String responseBody}){
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<BottleLot>((json) => BottleLot.fromJson(json)).toList();
  }

  Future<List<Vendors>> getAllvendors() async {
    final response = await http.get(Uri.parse("$urlBase/gazoo/vendors/all"));
    if (response.statusCode == 200) {
      // var listvendeurs = parseVendors(responseBody: response.body);
      return parseVendors(responseBody: response.body);
    }
    else {
      throw Exception('Failed to load Vendors');
    }
  }

  Future<List<BottleLot>> getBottleLot({required int? id}) async{
    final response = await http.get(Uri.parse("$urlBase/gazoo/vendors/bottles/$id") );

    if (response.statusCode == 200){
      return parseBottles(responseBody: response.body);
    }
    else {
      throw Exception('Failed to load Bottle lot');
    }

  }

}