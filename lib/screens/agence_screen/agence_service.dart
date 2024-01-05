import 'dart:convert';
import 'package:locagest/screens/agence_screen/Resources/agenceRequest.dart';
import 'package:http/http.dart' as http;
import 'agence.dart';

class AgenceService {
  static const String baseUrl = 'https://locagest.onrender.com';

  static Future<List<Agence>> fetchAgences() async {
    final Uri url = Uri.parse('$baseUrl/agence');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<Agence> agences =
            responseData.map((json) => Agence.fromJson(json)).toList();
        return agences;
      } else {
        throw Exception('Failed to load agences: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error: $error');
    }
  }

  static Future<void> ajouter(AgenceRequest agence) async {
    final response = await http.post(
      Uri.parse('$baseUrl/agence/new'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(agence.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add agence');
    }
  }

  static Future<void> modifier(String id, Agence agence) async {
    final response = await http.put(
      Uri.parse('$baseUrl/agence/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(agence.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update agence');
    }
  }

  static Future<void> supprimer(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/agence/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete agence');
    }
  }
}
