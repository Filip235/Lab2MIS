import 'package:flutter/material.dart';
import '../services/apiServices.dart';
import '../widgets/jokeCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              Navigator.pushNamed(context, '/random-joke');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(

        future: ApiService.fetchJokeTypes(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError)
          {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No joke found.'));
          }

          final jokeTypes = snapshot.data!;
          return ListView.builder(
            itemCount: jokeTypes.length,
            itemBuilder: (context, index) {
              return JokeCard(
                title: jokeTypes[index],
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/jokes-list',
                    arguments: jokeTypes[index],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
