import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

List userList = [];

void callAllFun() async {
  await createDataBase();
  userList = await getToDoData();
}

class UserData {
  int? id;
  String title;
  String discription;
  String date;
  int complete;
  UserData(
      {this.id,
      required this.title,
      required this.discription,
      required this.date,
      this.complete = 0});

  Map<String, dynamic> userDataMap() {
    return {
      "id": id,
      "title": title,
      "discription": discription,
      "date": date,
      "complete": complete,
    };
  }

  // @override
  // String toString() {
  //   return "id:$id title:$title discription:$discription date:$date complete:$complete";
  // }
}

dynamic database;
Future<void> createDataBase() async {
  database = openDatabase(
    join(await getDatabasesPath(), "Todolist6DB.db"),
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''CREATE TABLE todolistable(
          id INTEGER PRIMARY KEY,
          title TEXT,
          discription TEXT,
          date TEXT,
          complete BOOL
      )''');
    },
  );
}

Future<void> updateToDo(UserData obj) async {
  dynamic localDb = await database;
  await localDb.update('todolistable', obj.userDataMap(),
      where: "id=?", whereArgs: [obj.id]);
}

Future<void> insertData(UserData obj) async {
  dynamic localDB = await database;

  await localDB.insert("todolistable", obj.userDataMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<void> deleteData(UserData obj) async {
  dynamic localDb = await database;
  await localDb.delete('todolistable', where: "id=?", whereArgs: [obj.id]);
}

Future<List<UserData>> getToDoData() async {
  final localDB = await database;
  List<Map<String, dynamic>> mapEntry = await localDB.query("todolistable");
  return List.generate(mapEntry.length, (i) {
    return UserData(
        id: mapEntry[i]["id"],
        title: mapEntry[i]["title"],
        discription: mapEntry[i]["discription"],
        date: mapEntry[i]["date"],
        complete: mapEntry[i]["complete"]);
  });
}


//

///
///
// List databaseList = [
//   UserData(
//     title: "Prepare Quarterly Sales Report",
//     discription:
//         " Compile sales data from all regions and create a comprehensive report detailing quarterly performance, including key metrics and analysis.",
//     date: "Feb 26, 2024",
//   ),
//   UserData(
//     title: "Conduct Market Research",
//     discription:
//         " Research current market trends, competitor strategies, and consumer preferences to inform product development and marketing strategies. ",
//     date: "Feb 26, 2024",
//   ),
//   UserData(
//     title: "Client Presentation Preparation",
//     discription:
//         " Prepare a visually engaging and informative presentation for an upcoming client meeting, highlighting project progress, milestones achieved, and future plans.",
//     date: "Feb 26, 2024",
//   ),
//   UserData(
//     title: "Develop Marketing Campaign",
//     discription:
//         "Create and execute a multi-channel marketing campaign to increase brand visibility and drive customer engagement.",
//     date: "Feb 29, 2024",
//   ),
//   UserData(
//     title: "Strategic Business Analysis",
//     discription:
//         "Conduct in-depth analysis of market trends, competitor strategies, and internal operations to identify opportunities for growth and optimization.",
//     date: "Feb 29, 2024",
//   ),
//   UserData(
//     title: "Financial Forecasting",
//     discription:
//         "Utilize historical financial data and industry insights to forecast future revenue and expenses, enabling informed decision-making and resource allocation.",
//     date: "Feb 29, 2024",
//   ),
// ];

//
//
//
//
//

//login user name
