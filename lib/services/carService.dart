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
    final response =
        await http.delete(Uri.parse('$baseURL/car/$immatriculation'));

    if (response.statusCode == 204) {
      // La suppression a réussi (204 signifie "No Content")
    } else {
      throw Exception('Échec de la suppression du véhicule');
    }
  }

  Future<void> addCar(Car car) async {
    final response = await http.post(
      Uri.parse('$baseURL/car'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(car.toJson()),
    );

    if (response.statusCode == 201) {
      // L'ajout a réussi (201 signifie "Created")
    } else {
      throw Exception('Échec de l\'ajout de la voiture');
    }
  }
  
  Future<void> updateCar(String immatriculation, Car updatedCar) async {
  final response = await http.put(
    Uri.parse('$baseURL/car/$immatriculation'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(updatedCar.toJson()),
  );

  if (response.statusCode == 200) {
    // La modification a réussi (200 signifie "OK")
  } else {
    throw Exception('Échec de la modification du véhicule');
  }
}

}
