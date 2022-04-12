import 'dart:convert';
import 'dart:io';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user.dart';

class ListOfUsers extends StatefulWidget {
  const ListOfUsers({Key? key}) : super(key: key);

  @override
  _ListOfUsersState createState() => _ListOfUsersState();
}

class _ListOfUsersState extends State<ListOfUsers> {
  late Future<List<User>> userLst;
  @override
  void initState() {
    super.initState();
    userLst = getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCase(),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            tooltip: 'Go to the next page',
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: const Text('СПИСОК ПОЛЬЗОВАТЕЛЕЙ'),
      ),
      body: FutureBuilder<List<User>>(
        future: userLst,
        builder: (context, record) {
          if (record.hasData) {
            return ListView.builder(
                itemCount: record.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Text(
                        '${record.data![index].id}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22,),
                      ),
                      title: Text('${record.data![index].name}'),
                      subtitle: Text('${record.data![index].email}', style: TextStyle(color: Colors.blueAccent),),
                      onTap: () async {
                        UserID chosenUser = UserID(
                            record.data![index].id,
                            '${record.data![index].name}',
                            '${record.data![index].username}',
                            '${record.data![index].email}',
                            '${record.data![index].address!.street}',
                            '${record.data![index].address!.suite}',
                            '${record.data![index].address!.city}',
                            '${record.data![index].address!.zipcode}',
                            '${record.data![index].address!.geo!.lat}',
                            '${record.data![index].address!.geo!.lng}',
                            '${record.data![index].phone}',
                            '${record.data![index].website}',
                            '${record.data![index].company!.name}',
                            '${record.data![index].company!.catchPhrase}',
                            '${record.data![index].company!.bs}');
                        Navigator.pushNamed(context, '/ user',
                            arguments: chosenUser);
                      },
                    ),
                  );
                });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<User>> getUserList() async {
    List<User> prodList = [];
    const url = 'https://jsonplaceholder.typicode.com/users';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      for (var prod in jsonList) {
        prodList.add(User.fromJson(prod));
      }
      return prodList;
    } else {
      throw Exception('ОШИБКА: ${response.reasonPhrase}');
    }
  }
}

class DrawerCase extends StatelessWidget {
  const DrawerCase({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
            child: SizedBox(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    child: const Image(
                      image: AssetImage('assets/Google-flutter-logo.png'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "ЧТО-ТО ХОРОШЕЕ",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.account_box,
              color: Colors.blueAccent,
            ),
            title: const Text('СПИСОК ПОЛЬЗОВАТЕЛЕЙ'),
            onTap: () {
              Navigator.pushNamed(context, '/ list');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.accessibility_rounded,
              color: Colors.black12,
            ),
            title: const Text('СПАСТИ МИР'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.medical_services,
              color: Colors.black12,
            ),
            title: const Text('ПОЗВАТЬ САНИТАРОВ'),
            onTap: () {},
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.blueAccent,
            ),
            title: const Text('ВЫХОД'),
            onTap: () {exit(0);}
          ),
        ],
      ),
    );
  }
}

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      company: json['company'] == null
          ? null
          : Company.fromJson(json['company'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'address': instance.address,
      'phone': instance.phone,
      'website': instance.website,
      'company': instance.company,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      street: json['street'] as String?,
      suite: json['suite'] as String?,
      city: json['city'] as String?,
      zipcode: json['zipcode'] as String?,
      geo: json['geo'] == null
          ? null
          : Geo.fromJson(json['geo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'suite': instance.suite,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'geo': instance.geo,
    };

Geo _$GeoFromJson(Map<String, dynamic> json) => Geo(
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
    );

Map<String, dynamic> _$GeoToJson(Geo instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      name: json['name'] as String?,
      catchPhrase: json['catchPhrase'] as String?,
      bs: json['bs'] as String?,
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'name': instance.name,
      'catchPhrase': instance.catchPhrase,
      'bs': instance.bs,
    };

@JsonSerializable()
class User {
  int? id;
  String? name;
  String? username;
  String? email;
  Address? address;
  String? phone;
  String? website;
  Company? company;

  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.address,
      this.phone,
      this.website,
      this.company});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Address {
  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  Address({this.street, this.suite, this.city, this.zipcode, this.geo});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Geo {
  String? lat;
  String? lng;

  Geo({this.lat, this.lng});

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoToJson(this);
}

@JsonSerializable()
class Company {
  String? name;
  String? catchPhrase;
  String? bs;

  Company({this.name, this.catchPhrase, this.bs});

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
