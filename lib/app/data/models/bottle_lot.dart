import 'package:gazoo/app/data/models/brand.dart';

class BottleLot {
  int id = 0;
  double weight = 0.0;
  int? quantity;
  double price = 0.0;
  Brand brand = Brand(brandName: "", bottleImage: "");

  BottleLot ({required this.id, required this.weight, required this.quantity, required this.price, required this.brand});

  BottleLot.fromJson(Map<String, dynamic> json){
    id = json['id'];
    weight = json['weight'];
    quantity = json['quantity'];
    price = json['price'];
    brand = Brand.fromJson(json['brand']);
  }

  Map<String, dynamic> toJson(){
    final Map<String,dynamic> data = {};

    data['id'] = id;
    data['weight'] = weight;
    data['quantity'] = quantity;
    data['price'] = price;
    data['Brand'] = brand;

    return data;
  }
}