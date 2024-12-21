import 'package:dio/dio.dart';
import 'package:fetch_jokes/data/dto/joke_dto.dart';


class JokeService {
  final Dio _dio = Dio();

  Future<List<JokeDto>> fetchJokes({required String category}) async {
    try {
     
      final response = await _dio.get(
  'https://v2.jokeapi.dev/joke/$category?amount=5', 
);

     
      if (response.data['jokes'] != null) {
        return (response.data['jokes'] as List)
            .map((joke) => JokeDto.fromJson(joke))
            .toList();
      }

      return [];
    } catch (e) {
      print("Error fetching jokes: $e");
      return [];
    }
  }
}
