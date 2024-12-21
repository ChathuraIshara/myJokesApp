import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final dynamic joke;

  const JokeCard({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFff7e5f), 
              Color(0xFFfeb47b), 
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFffb7a1), 
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Text(
                    joke.type == 'single' ? 'Single Joke' : 'Setup & Punchline',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    )
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  joke.type == 'single' ? Icons.sentiment_satisfied_alt : Icons.sentiment_dissatisfied,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                joke.type == 'single' ? joke.joke! : joke.setup!,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.6,
                ),
                textAlign: TextAlign.left,
              ),

              if (joke.type != 'single')
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    '- ${joke.delivery}',
                    style: const TextStyle(
                      fontSize: 18, 
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              const SizedBox(height: 20),

              if (joke.type == 'setup')
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                    
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      foregroundColor: Color(0xFFff7e5f), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    ),
                    child: const Text(
                      'Discover More!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}