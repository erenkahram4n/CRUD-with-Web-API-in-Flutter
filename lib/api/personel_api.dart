import 'dart:convert';
import 'package:beetech_crud/models/personel.dart';
import 'package:http/http.dart' as http;

class PersonelAPI {
  var url = Uri(
      scheme: 'http',
      host: '192.168.1.41',
      port: 50288,
      path: '/api/personels');
  Future<List<Personel>> findAll() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      return body.map((personel) => Personel.fromJson(personel)).toList();
    } else {
      throw Exception("Personel listesi oluşturulurken bir hata oldu!");
    }
  }

  Future<Personel> find(int id) async {
    var response = await http.get(Uri.parse("$url/$id"));
    if (response.statusCode == 200) {
      return Personel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception("Personel listesi oluşturulurken bir hata oldu!");
    }
  }

  Future<Personel> createPersonel(
      String name, String surname, num salary) async {
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'surname': surname,
        'salary': salary,
      }),
    );
    if (response.statusCode == 201) {
      return Personel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Personel Oluşturulurken Hata Oluştu');
    }
  }

  Future<Personel> updatePersonel(
      int id, String name, String surname, num salary) async {
    var response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'name': name,
        'surname': surname,
        'salary': salary,
      }),
    );
    if (response.statusCode == 200) {
      return Personel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Personel düzenlenirken hata oluştu!');
    }
  }

  Future<Personel> deletePersonel(int id) async {
    var response = await http.delete(
      Uri.parse("$url/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Personel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Personel silinirken hata oluştu!');
    }
  }
}
