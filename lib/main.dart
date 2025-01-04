import 'package:flutter/material.dart';
import 'package:lab2/services/firebase_messaging_service.dart';
import 'screens/homeScreen.dart';
import 'screens/jokesListScreen.dart';
import 'screens/randomJokeScreen.dart';
import 'screens/favorite_jokes_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeTimeZones();
  FirebaseMessagingService.scheduleDailyNotification();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

void setupFirebaseMessaging() {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging.requestPermission();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received a foreground message: ${message.notification?.title}');
  });

  messaging.subscribeToTopic('jokes');
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
        '/favorites': (context) => const FavoriteJokesScreen(),
      },
    );
  }
}
