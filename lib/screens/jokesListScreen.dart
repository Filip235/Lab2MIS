import 'package:flutter/material.dart';
import '../services/apiServices.dart';
import '../models/jokeModel.dart';

class JokesListScreen extends StatelessWidget {
  final String jokeType;

  const JokesListScreen({Key? key, required this.jokeType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jokes: $jokeType')),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.fetchJokesByType(jokeType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No jokes found.'));
          }

          final jokes = snapshot.data!;
          return ListView.builder(
            itemCount: jokes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(jokes[index].setup),
                subtitle: Text(jokes[index].punchline),
              );
            },
          );
        },
      ),
    );
  }
}
