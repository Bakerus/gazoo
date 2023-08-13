class Timetables {
   int id = 0;
 String day = "";
 String time = "";

 Timetables ({required this.id, required this.day, required this.time});

  Timetables.fromJson( Map<String, dynamic> json){
  id = json['id'];
  day = json['day'];
  time = json['time'];
 }

   Map<String, dynamic> toJson(){
    final Map<String, dynamic> map = {};

    map['id'] = id;
    map['day'] = day;
    map['time'] = time;

    return map;
  }

}