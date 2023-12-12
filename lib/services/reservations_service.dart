import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locagest/models/reservation.dart';

class ReservationService {
  static const String baseURL = 'http://localhost:9090';

  Future<List<Reservation>> getAllReservations(String url) async {
    final response = await http.get(Uri.parse('$url/res'));

    if (response.statusCode == 200) {
      Iterable<dynamic> list = json.decode(response.body);
      return List<Reservation>.from(list.map((model) => Reservation.fromJson(model)));
    } else {
      throw Exception('Échec de chargement des réservations');
    }
  }
}

