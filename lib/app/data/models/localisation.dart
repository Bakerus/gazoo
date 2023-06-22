class Localisation {
  int id = 0;
  double latitude = 0.0;
  double longitude = 0.0;

  Localisation({required this.id, required this.latitude, required this.longitude});

  Localisation.fromJson(Map<String, dynamic> json){
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> map = {};

    map['id'] = id;
    map['latitude'] = latitude;
    map['longitude'] = longitude;

    return map;
  }
}