import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locagest/models/historiqueentretien.dart';

class EntretienService {
  static const String baseURL = 'http://localhost:9090';

  Future<List<HistoriqueEntretien>> getAllEntretiens() async {
    final response = await http.get(Uri.parse('$baseURL/historique_entretien'));

    if (response.statusCode == 200) {
      Iterable<dynamic> list = json.decode(response.body);
      return List<HistoriqueEntretien>.from(
          list.map((model) => HistoriqueEntretien.fromJson(model)));
    } else {
      throw Exception('Échec de chargement des entretiens');
    }
  }
}
