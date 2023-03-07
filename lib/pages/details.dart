// ignore_for_file: prefer_const_constructors, sort_child_properties_last, null_check_always_fails, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:beetech_crud/api/personel_api.dart';
import 'package:beetech_crud/models/personel.dart';

class PersonelDetailsPage extends StatefulWidget {
  int id;
  PersonelDetailsPage({super.key, required this.id});

  @override
  State<PersonelDetailsPage> createState() => _PersonelDetailsPageState();
}

class _PersonelDetailsPageState extends State<PersonelDetailsPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personel Bilgileri Görüntüle ve Düzenle"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: PersonelAPI().find(widget.id),
          builder: (context, AsyncSnapshot<Personel> snapshot) {
            dynamic Idd = snapshot.data!.id;
            late Future<Personel> _futurePersonel;
            late Future<Personel> _deletingPersonel;
            @override
            void initState() {
              // TODO: implement initState
              super.initState();
              _futurePersonel = PersonelAPI().find(Idd);
            }

            if (snapshot.hasData) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "ID",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            "Name",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            "Surname",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            "Salary",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data!.id.toString(),
                              style: TextStyle(fontSize: 20)),
                          Text(snapshot.data!.name,
                              style: TextStyle(fontSize: 20)),
                          Text(snapshot.data!.surname,
                              style: TextStyle(fontSize: 20)),
                          Text(snapshot.data!.salary.toString(),
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(right: 70, left: 70),
                        child: Column(
                          children: [
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: _idController,
                              decoration: InputDecoration(
                                labelText: "ID",
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: "İsim",
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: _surnameController,
                              decoration: InputDecoration(
                                labelText: "Soyisim",
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: _salaryController,
                              decoration: InputDecoration(
                                labelText: "Maaş",
                                labelStyle: TextStyle(
                                  fontSize: 17,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
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
                                if (_idController.text != null ||
                                    _nameController.text != null ||
                                    _surnameController.text != null ||
                                    _salaryController.text != null) {
                                  _futurePersonel = PersonelAPI()
                                      .updatePersonel(
                                          int.parse(_idController.text),
                                          _nameController.text,
                                          _surnameController.text,
                                          int.parse(_salaryController.text));
                                } else {
                                  AlertDialog(
                                    title: Text("Boş Alan Bırakılamaz!"),
                                    content:
                                        Text("Lütfen Tüm Alanları Doldurunuz!"),
                                  );
                                }
                              });
                            },
                            child: Text(
                              "Düzenlemeyi Kaydet",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green)),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                              child: Text(
                                "Geri Dön",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              child: Text(
                                "Kişiyi Sil",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                                setState(() {
                                  _futurePersonel =
                                      PersonelAPI().deletePersonel(Idd);
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
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
      ),
    );
  }
}
