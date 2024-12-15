import 'package:flutter/material.dart';
import 'screens/homeScreen.dart';
import 'screens/jokesListScreen.dart';
import 'screens/randomJokeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/jokes-list': (context) => JokesListScreen(
          jokeType: ModalRoute.of(context)!.settings.arguments as String,
        ),
        '/random-joke': (context) => const RandomJokeScreen(),
      },
    );
  }
}
