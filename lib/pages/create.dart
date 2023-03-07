// ignore_for_file: prefer_const_constructors, sort_child_properties_last, null_check_always_fails, use_key_in_widget_constructors
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:beetech_crud/api/personel_api.dart';
import 'package:beetech_crud/models/personel.dart';

class CreatePersonelPage extends StatefulWidget {
  const CreatePersonelPage({super.key});
  @override
  State<CreatePersonelPage> createState() => _CreatePersonelPageState();
}

class _CreatePersonelPageState extends State<CreatePersonelPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  Future<Personel>? _futurePersonel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personel Ekle"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (_futurePersonel == null)
            ? Padding(
                padding: const EdgeInsets.only(right: 70, left: 70),
                child: buildColumn(),
              )
            : buildFutureBuilder(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: ("İsim"),
            labelStyle: TextStyle(
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: _surnameController,
          decoration: InputDecoration(
            labelText: ("Soyisim"),
            labelStyle: TextStyle(
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: _salaryController,
          decoration: InputDecoration(
            labelText: ("Maaş"),
            labelStyle: TextStyle(
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
                setState(() {
                  _futurePersonel = PersonelAPI().createPersonel(
                      _nameController.text,
                      _surnameController.text,
                      int.parse(_salaryController.text));
                });
              },
              child: Text(
                "Oluştur",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
            ),
            SizedBox(
              width: 15,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Text(
                "Geri Dön",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
            ),
          ],
        ),
      ],
    );
  }

  FutureBuilder<Personel> buildFutureBuilder() {
    return FutureBuilder<Personel>(
      future: _futurePersonel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
