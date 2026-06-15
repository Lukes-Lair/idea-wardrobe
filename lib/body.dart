import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ideas_app/ideas.dart';
import 'package:path_provider/path_provider.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => BodyState();
}

class Idea {
  Idea({required this.title, required this.description, required this.category, required this.feasibility});

  final String title;
  final String description;
  final String category;
  final String feasibility;

  static List<Idea> fromJson(dynamic json) {
    List<Idea> list = [];
    for (var i = 0; i < json.length; i++) {
      final entry = json[i];
      list.add(Idea(title: entry['title'], description: entry['description'], category: entry['category'], feasibility: entry['feasibility']));
    }
    return list;
  }
}

Future<String> get _currentDir async {
  final dir = await getApplicationDocumentsDirectory();
  return dir.path;
}

Future<File> get _file async {
  final dir = await _currentDir;
  return File("$dir/ideas.txt");
}

Future<List<Idea>> readIdeas() async {
  final file = await _file;

  if (!await file.exists()) {
    return [];
  }

  final read = await file.readAsString();

  if (read.isEmpty) {
    return [];
  }

  return Idea.fromJson(await jsonDecode(read));


}

Future<void> writeIdeas(Idea idea) async {
  List<Idea> list = await readIdeas();
  list.add(idea);
  final file = await _file;
  final data = list.map((v) => {
    'title':v.title,
    'description':v.description,
    'category':v.category,
    'feasibility':v.feasibility
  }).toList();

  await file.writeAsString(jsonEncode(data));
}

class BodyState extends State<Body> {

  List<Idea> ideas = [];

  void addIdea(Idea idea) {
    setState(() {
      ideas.add(idea);
    });
    writeIdeas(idea);
  }

  void delIdeas() async {
    await (await _file).writeAsString("");
    setState(() {
      ideas = [];
    });
  }

  void loadIdeas() async{
    final read = await readIdeas();

    setState(() {
      ideas = read;
    });
  }

  @override
void initState() {
  super.initState();
  loadIdeas();
}

  @override
  Widget build(BuildContext context) { 
    return Center(
      child: Column(
        spacing: 20,
        children: [
          Ideas(list: ideas),
          ElevatedButton(onPressed: delIdeas, child: const Text("Delete all Ideas"))
        ],
      ),
    );
  }
}
