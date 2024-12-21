import 'package:fetch_jokes/components/no_internet_popup.dart';
import 'package:flutter/material.dart';
import 'package:fetch_jokes/data/dto/joke_dto.dart';
import 'package:fetch_jokes/services/joke_service.dart';
import 'package:fetch_jokes/services/cache_manager.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class JokeState extends ChangeNotifier {
  final JokeService _jokeService = JokeService();
  List<JokeDto> jokes = [];
  bool isLoading = false;
  String selectedCategory =
      'any'; // Default category set to 'Programming'
  double sizeRatio = 1;

  // Method to update the selected joke category
  void updateSelectedCategory(String? newCategory) {
    if (newCategory != null) {
      selectedCategory = newCategory;
      notifyListeners();
    }
  }

  // Fetch jokes from the service based on the selected category or use cache
  Future<void> fetchJokes(BuildContext context) async {
    isLoading = true;
    jokes = await CacheManager.getJokes(selectedCategory);
    notifyListeners();

    // Check if there's an internet connection (assuming you have a method to check it)
    // If there's no internet, use cached jokes
    if (await _isConnected()) {
      // Fetch jokes from API
      jokes = await _jokeService.fetchJokes(category: selectedCategory);
      if (jokes.isNotEmpty) {
        // Cache the jokes after fetching
        await CacheManager.saveJokes(selectedCategory, jokes);
      }
    } else {
      NoInternetPopup.show(context);
    }

    if (jokes.isNotEmpty) {
      sizeRatio = 0.5;
    }

    isLoading = false;
    notifyListeners();
  }

  // Placeholder method to check internet connection
  Future<bool> _isConnected() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
