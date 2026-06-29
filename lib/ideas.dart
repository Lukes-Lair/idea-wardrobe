import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    const textColor = Color.fromARGB(255, 224, 224, 224);
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
                color: const Color.fromARGB(255, 71, 76, 88),
                border:BoxBorder.all(
                  color: const Color.fromARGB(255, 137, 142, 160),
                  width: 2
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
                          style: GoogleFonts.tirra(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          )
                        ),
                      ],
                    ),

                    const Divider(
                      indent: 1,
                      endIndent: 210, //need this to be about the end of the title text. Also make it consistent on all screen sizes
                      height: 9,
                      color: Color.fromARGB(255, 90, 92, 99),
                    ),
                    const SizedBox(height: 4,),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 7),
                        Flexible(
                          child: Text(
                            e.description,
                            style: GoogleFonts.tirra(
                              fontSize: 15,
                              wordSpacing: 0.5,
                              color: textColor,
                              ),
                          )
                        ),
                        const SizedBox(width: 13),
                      ],
                    ),
            
                    const SizedBox(height: 10,),
            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Text(
                            'Category: ${e.category}',
                            style: GoogleFonts.lora(
                              letterSpacing: 0.2,
                              color: textColor,
                              ),
                          )
                        ),
            
                        Flexible(
                          child: Text(
                            'Feasibility: ${e.feasibility}',
                            style: GoogleFonts.lora(
                              letterSpacing: 0.2, 
                              color: textColor
                            ),
                          )
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