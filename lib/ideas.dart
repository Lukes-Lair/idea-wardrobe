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
      spacing: 30,
      children: [
        ...widget.ideas.map((e) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: const Color.fromARGB(164, 158, 158, 158),
              ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 11.0, left: 9, right: 9, top: 4),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(e.title.replaceAll(RegExp("\n"), ''), style: TextStyle(
                        fontSize: 18
                      ),),
                    ],
                  ),

                  SizedBox(height: 3,),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(e.description.replaceAll(RegExp("\n"), ''))),
                    ],
                  ),

                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(child: Text('Category: ${e.category.replaceFirst(RegExp("Value_"), '')}')),
                      Flexible(child: Text('Feasibility: ${e.feasibility}/5'))
                    ],
                  )
                  
                ],
              ),
            ),
          );
        })

      ],
    );
  }
}