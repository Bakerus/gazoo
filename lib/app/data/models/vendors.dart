import 'package:gazoo/app/data/models/timetables.dart';

import 'localisation.dart';
class Vendors {
  int id = 0;
  String name = "";
  String surname = "";
  String address = "";
  String phone = "";
  TimetablesList? timeTables;
  Localisation? localisation;

Vendors({required this.id ,required this.name, required this.surname, required this.address, required this.phone, required this.timeTables, required this.localisation});

Vendors.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  name = json['name'];
  surname = json['surname'];
  address = json['address'];
  phone = json['phone'];
  timeTables = json['timeTables'] !=null ? TimetablesList.fromJson(json['timeTables']) : null ;
  localisation = json['localisation'] != null ? Localisation.fromJson(json['localisation']) : null;
}

Map<String, dynamic> toJson(){
  final Map<String, dynamic> data = {};
 data['id'] = id;
 data['name'] = name;
 data['surname'] = surname;
 data['address'] = address;
 data['phone'] = phone;
 data['timetable'] = timeTables;
 data['localisation'] = localisation;
 return data;
}


}