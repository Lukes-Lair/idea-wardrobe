import 'package:flutter/material.dart';
import 'package:ideas_app/body.dart';

class Ideas extends StatefulWidget {
  const Ideas({super.key, required list}): ideas = list;
  final List<Idea> ideas;

  @override
  State<Ideas> createState() => _IdeasState();
}

class _IdeasState extends State<Ideas> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 0,
      children: [
        ...widget.ideas.map((i) {
          final e = format(i);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.5, vertical: 5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: const Color.fromARGB(255, 60, 64, 75),
                border:BoxBorder.all(
                  color: const Color.fromARGB(255, 86, 92, 107),
                  width: 1.5
                )
                ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 11.0, left: 9, right: 9, top: 4),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 6),
                        Text(
                          e.title, 
                          style: const TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ],
                    ),

                    const Divider(
                      indent: 1,
                      endIndent: 1,
                      height: 9,
                    ),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 13),
                        Flexible(
                          child: Text(e.description)
                        ),
                        const SizedBox(width: 13),
                      ],
                    ),
            
                    const SizedBox(height: 10,),
            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Text('Category: ${e.category}')
                        ),
            
                        Flexible(
                          child: Text('Feasibility: ${e.feasibility}/5')
                        )
                      ],
                    )
                    
                  ],
                ),
              ),
            ),
          );
        })

      ],
    );
  }
}


Idea format(Idea i) {
  String description = i.description;
  String category = i.category;
  if (i.description.length > 100) {
    description = '${i.description.substring(0,100)}...';
  }
  if (i.description.split('\n').length >= 2) {
    final split = i.description.split('\n');
    final newList = [];
    newList.add(split[0]);
    newList.add('${split[1]}...');
    description = newList.join('\n');
  }
  if (i.category.length > 30) {
    category = '${i.category.substring(0, 25)}...';
  }
  return Idea(title: i.title, description: description, category: category.replaceFirst(RegExp("Value_"), ''), feasibility: i.feasibility);
}