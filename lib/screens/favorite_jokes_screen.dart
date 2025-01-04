import 'package:flutter/material.dart';

class FavoriteJokesScreen extends StatelessWidget {
  const FavoriteJokesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteJokes = ModalRoute.of(context)!.settings.arguments as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
      ),
      body: favoriteJokes.isEmpty
          ? const Center(
        child: Text('No favorite jokes yet.'),
      )
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteJokes[index]),
          );
        },
      ),
    );
  }
}
