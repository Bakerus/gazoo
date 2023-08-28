import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/brand.dart';
import '../../core/widgets/snackbar.dart';

class BrandProvider {
  List<Brand> parseBrands(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Brand>((json) => Brand.fromJson(json)).toList();
  }

  Future<List<Brand>> getAllBrands() async {
  const String brandUrl = "https://gazoo.alwaysdata.net/gazoo/brands/all";

  final response = await http.get(Uri.parse(brandUrl));

  if (response.statusCode == 200) {
    final List<Brand> brandList = parseBrands(response.body);
    return brandList;
  } else {
    Snackbar.showSnackbar(
      title: "Erreur",
      message: "Pas de marque pour le moment",
    );
    return [];
  }
}

}