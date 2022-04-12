import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'list_of_users.dart';
import 'package:json_annotation/json_annotation.dart';

class UserID {
  late final int? id;
  late final String? name;
  late final String? username;
  late final String? email;
  late final String? street;
  late final String? suite;
  late final String? city;
  late final String? zipcode;
  late final String? lat;
  late final String? lng;
  late final String? phone;
  late final String? website;
  late final String? cname;
  late final String? catchPhrase;
  late final String? bs;

  UserID(
      this.id,
      this.name,
      this.username,
      this.email,
      this.street,
      this.suite,
      this.city,
      this.zipcode,
      this.lat,
      this.lng,
      this.phone,
      this.website,
      this.cname,
      this.catchPhrase,
      this.bs);
}

Check _$CheckFromJson(Map<String, dynamic> json) => Check(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      completed: json['completed'] as bool?,
    );

Map<String, dynamic> _$CheckToJson(Check instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'completed': instance.completed,
    };

@JsonSerializable()
class Check {
  int? userId;
  int? id;
  String? title;
  bool? completed;
  Check({this.userId, this.id, this.title, this.completed});
  factory Check.fromJson(Map<String, dynamic> json) => _$CheckFromJson(json);
  Map<String, dynamic> toJson() => _$CheckToJson(this);
}

class InfoUser extends StatelessWidget {
  late final UserID currentUser;

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    currentUser = settings.arguments as UserID;

    return Scaffold(
      drawer: const DrawerCase(),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            tooltip: 'НА ПРЕДЫДУЩУЮ СТРАНИЦУ',
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: const Text('ЗАДАЧИ ПОЛЬЗОВАТЕЛЯ'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${currentUser.name}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('${currentUser.username}'),
            TextButton(
              child: Text('${currentUser.email}'),
              onPressed: () {},
            ),
            const Text(''),
            Text(
                '${currentUser.zipcode}, ${currentUser.city}, ${currentUser.street}, ${currentUser.suite}. '),
            Text('${currentUser.phone}'),
            const Text(''),
            Text('${currentUser.website}',
                style: const TextStyle(color: Colors.blueAccent)),
            Text('${currentUser.cname}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('${currentUser.catchPhrase}',
                style: const TextStyle(fontStyle: FontStyle.italic)),
            Text('${currentUser.bs}', style: TextStyle(color: Colors.white10)),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ToDos('${currentUser.id}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToDos extends StatefulWidget {
  final String _id;
  const ToDos(this._id, {Key? key}) : super(key: key);
  @override
  _ToDosState createState() => _ToDosState();
}

class _ToDosState extends State<ToDos> {
  late Future<List<Check>> checklist;
  @override
  void initState() {
    super.initState();
    String id = widget._id;
    checklist = getTasks(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Check>>(
      future: checklist,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var isDone = snapshot.data![index].completed as bool;
              return Card(
                color: isDone ? Colors.white70 : Colors.white, // цвет завитсит от состояния флага
                child:
                ListTile(
                  title: Text('${snapshot.data![index].title}'),
                  leading: Text('№${index + 1}'),
                  trailing: Checkbox(value: isDone, onChanged: null),

                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<List<Check>> getTasks(String id) async {
    List<Check> prodList = [];
    String url = 'https://jsonplaceholder.typicode.com/todos?userId=$id';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      for (var prod in jsonList) {
        prodList.add(Check.fromJson(prod));
      }
      return prodList;
    } else {
      throw Exception('ОШИБКА: ${response.reasonPhrase}');
    }
  }
}
