import 'dart:convert';
import '../data/dto/joke_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static const String _cacheKey = 'cached_jokes';

  
  static Future<void> saveJokes(String category, List<JokeDto> jokes) async {
    final prefs = await SharedPreferences.getInstance();
    final jokesJson = jsonEncode(
        jokes.map((e) => e.toJson()).toList()); // Convert jokes to json
    await prefs.setString('$_cacheKey-$category', jokesJson);
  }

 
  static Future<List<JokeDto>> getJokes(String category) async {
    final prefs = await SharedPreferences.getInstance();
    final jokesJson = prefs.getString('$_cacheKey-$category');
    if (jokesJson != null) {
      final List<dynamic> decodedJson = jsonDecode(jokesJson);
      return decodedJson
          .map((e) => JokeDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }

  // Clear the cache
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
