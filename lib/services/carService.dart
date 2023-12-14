// CarService.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locagest/models/car.dart';

class CarService {
  static const String baseURL = 'http://localhost:9090';

  Future<List<Car>> getAllCars() async {
    final response = await http.get(Uri.parse('$baseURL/car'));

    if (response.statusCode == 200) {
      Iterable<dynamic> list = json.decode(response.body);
      return List<Car>.from(list.map((model) => Car.fromJson(model)));
    } else {
      throw Exception('Échec de chargement des voitures');
    }
  }

  Future<void> deleteCar(String immatriculation) async {
    final response = await http.delete(Uri.parse('$baseURL/car/$immatriculation'));

    if (response.statusCode == 204) {
      // La suppression a réussi (204 signifie "No Content")
    } else {
      throw Exception('Échec de la suppression du véhicule');
    }
  }
}
