import 'package:gazoo/app/data/models/time_tables_2.dart';

class TimetablesList {

 List<Timetables> timeTables ;

  TimetablesList({required this.timeTables});

  factory TimetablesList.fromJson(List<dynamic> json) {
    
    List<Timetables> timeTables = [];
    timeTables = json.map((i) => Timetables.fromJson(i)).toList();
    return TimetablesList(timeTables: timeTables);
  }


}

