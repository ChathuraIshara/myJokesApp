import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/joke_state.dart';
import '../components/fetch_jokes_button.dart';
import '../components/joke_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jokeState = Provider.of<JokeState>(context);

    if (!jokeState.isLoading && jokeState.jokes.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    }

    return Scaffold(
      backgroundColor: Color(0xFFFFDAB9), 
      body: Column(
        children: [
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFff7e5f), Color(0xFFfeb47b)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade800.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Smiles Guaranteed!',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LobsterTwo-Bold',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Tap below to fetch your daily dose of fun and laughter!',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Lato-Italic',
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FetchJokesButton(jokeState: jokeState),
          ),
          const SizedBox(height: 20),

       
          Expanded(
            child: jokeState.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : jokeState.jokes.isEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.grey.shade600,
                              size: 80,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Oops! No jokes fetched yet.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Lato-Italic',
                                color: Colors.grey.shade600,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Tap the button above to brighten your day!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Lato',
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Divider(
                              color: Colors.grey.shade400,
                              thickness: 1,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.emoji_people,
                                      color: Colors.grey.shade600,
                                      size: 50,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Get Inspired",
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.lightbulb,
                                      color: Colors.grey.shade600,
                                      size: 50,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Daily Tips",
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.mood,
                                      color: Colors.grey.shade600,
                                      size: 50,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Stay Positive",
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          jokeState.fetchJokes(context);
                        },
                        child: Scrollbar(
                          thumbVisibility: true,
                          controller: _scrollController,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: jokeState.jokes.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Material(
                                  elevation: 6,
                                  shadowColor:
                                      Colors.grey.shade600.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1,
                                      ),
                                    ),
                                    child: JokeCard(joke: jokeState.jokes[index]),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
