import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:locagest/models/BannedWord.dart';

class BannedWordService {
  final String baseUrl = "https://locagest.onrender.com/bannedWords/";

  Future<BannedWord?> createBannedWord(String word) async {
    final response = await http.post(
      Uri.parse('$baseUrl'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"word": word}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final dynamic responseData = json.decode(response.body);
      final BannedWord createdBannedWord = BannedWord.fromJson(responseData);
      return createdBannedWord;
    } else {
      print('Failed to create banned word: ${response.statusCode}');
      return null;
    }
  }

  Future<List<BannedWord>> getBannedWords() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<BannedWord> bannedWords =
            responseData.map((json) => BannedWord.fromJson(json)).toList();
        return bannedWords;
      } else {
        throw Exception('Failed to load banned words: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error: $error');
    }
  }

  Future<http.Response> deleteBannedWord(String id) async {
    final response = await http.delete(Uri.parse(baseUrl + id));
    return response;
  }
}
