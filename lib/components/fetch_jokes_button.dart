import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/joke_state.dart';

class FetchJokesButton extends StatelessWidget {
  final JokeState jokeState;

  const FetchJokesButton({super.key, required this.jokeState});

  @override
  Widget build(BuildContext context) {
    return Consumer<JokeState>(
      builder: (context, jokeState, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: jokeState.isLoading ? null : () => _fetchJokes(context),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0), 
              ),
              backgroundColor: Colors.transparent, 
              elevation: 8, 
            ),
            child: Container(
              height: 60.0, 
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFff7e5f), 
                    Color(0xFFfeb47b), 
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400.withOpacity(0.6),
                    blurRadius: 6,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: jokeState.isLoading
                    ? const SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        "Hit to Laugh!",
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 20, 
                          fontWeight: FontWeight.bold, 
                          fontFamily: 'Roboto',
                          letterSpacing: 1.5, 
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _fetchJokes(BuildContext context) {
    jokeState.fetchJokes(context);
  }
}
