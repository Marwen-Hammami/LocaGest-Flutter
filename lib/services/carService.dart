import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locagest/models/car.dart';

class CarService {
  static const String baseURL = 'https://locagest.onrender.com';

  Future<List<Car>> getAllCars() async {
    final response = await http.get(Uri.parse('$baseURL/car'));

    if (response.statusCode == 200) {
      Iterable<dynamic> list = json.decode(response.body);
      return List<Car>.from(list.map((model) => Car.fromJson(model)));
    } else {
      throw Exception('Échec de chargement des voitures');
    }
  }
}
