import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locagest/models/Signalement.dart';

class BannedWordService {
  final String baseUrl = "http://localhost:9090/messages/signalements/";

  Future<List<Signalement>> getSignalements() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<Signalement> signalements =
            responseData.map((json) => Signalement.fromJson(json)).toList();
        return signalements;
      } else {
        throw Exception('Failed to load signalements: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error: $error');
    }
  }
}
