import 'package:flutter/material.dart';
import 'package:ideas_app/New_Idea/new_idea.dart';
import 'package:ideas_app/body.dart';
import 'package:ideas_app/main_app_bar.dart';

final GlobalKey<BodyState> bodyKey = GlobalKey<BodyState>();

void main() {
  const Color mainColor = Color.fromARGB(255, 20, 22, 27);
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: mainColor
        ),
        appBarTheme: const AppBarThemeData(
          backgroundColor: mainColor,
          foregroundColor: Colors.white
        ),
        scaffoldBackgroundColor: mainColor,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white)
        )

      ),

      home: const Home(),
      routes: {'newIdea':(context) => Add(bodykey: bodyKey)},
        )
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void switchPage() {
    setState(() {
      Navigator.pushNamed(context, "newIdea");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: MainAppBar(func:switchPage),
          body: Body(key: bodyKey,)

          );
  }
}