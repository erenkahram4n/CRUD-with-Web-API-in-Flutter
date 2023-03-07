// ignore_for_file: prefer_const_constructors

import 'package:beetech_crud/api/personel_api.dart';
import 'package:beetech_crud/pages/create.dart';
import 'package:beetech_crud/pages/details.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personel Listesi"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Personel Ekle"),
                value: 1,
              ),
            ],
            onSelected: (int menu) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreatePersonelPage()));
            },
          )
        ],
      ),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return MyList();
  }
}

MyList() {
  return Padding(
    padding: EdgeInsets.all(10),
    child: FutureBuilder(
      future: PersonelAPI().findAll(),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(snapshot.data![index].id.toString()),
                  ),
                  title: Text(
                      "Kişi : ${snapshot.data![index].name} ${snapshot.data![index].surname}"),
                  subtitle: Text(
                      "Maaş : ${snapshot.data![index].salary} TL".toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonelDetailsPage(
                          id: snapshot.data![index].id,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 60, left: 60),
                child: LinearProgressIndicator(
                  backgroundColor: Color.fromARGB(0, 0, 0, 0),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Yükleniyor, Lütfen bekleyiniz.."),
            ],
          ));
        }
      },
    ),
  );
}
