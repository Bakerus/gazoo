class Clients{

  int? id;
  String name = "";
  String surname = "";
  String address = "";
  String phone = "";

  Clients({this.id, required this.name,required this.surname, required this.address, required this.phone});

  Clients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    address = json['address'];
    phone = json['phone'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['address'] = address;
    data['phone'] = phone;

    return data;
  }

}