import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ideas_app/New_Idea/new_category.dart';
import 'package:ideas_app/body.dart';
import 'package:path_provider/path_provider.dart';

class NIBody extends StatefulWidget {
  const NIBody({super.key, required this.formKey});
  final formKey;

  @override
  State<NIBody> createState() => NIBodyState();
}

class NIBodyState extends State<NIBody> {

  Future<String> get _localPath async {
     final directory = await getApplicationDocumentsDirectory();

     return directory.path;
  }

  Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/categories.txt');
}

void writeCategories(String contents) async {
  final file = await _localFile;

    await file.writeAsString("$contents\n", mode: FileMode.append);
  
}

Future<List<String>> readCategories() async {
  try {
    final file = await _localFile;

    final contents = await file.readAsString();

    return contents.split("\n").where((v) => v.trim().isNotEmpty).toList();
    
  } catch (e) {
    return [];
  }
}

List<String> categories = [];

void loadVals() async {
  final data = await readCategories();
  
  setState((){
    categories = data;
  });
}

@override
  void initState() {
    super.initState();
    loadVals();
  }

  void addCategory(String name) {
    setState(() {
      categories.add(name);
    });
    writeCategories(name);
  }

  TextEditingController control = TextEditingController();
  String text = "";
  List<DropdownMenuEntry<String?>> catEntries = [];
  var title = "";
  var description = "";
  var category = "";
  var feasibility = "";

  Idea buildIdea() {
    return Idea(title: title, description: description, category: category, feasibility: feasibility);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: widget.formKey,
        child:  SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 7.0,
                children: [
                  TextFormField(
                    minLines: 1,
                    maxLines: null,
                    validator: (value) {
                      final v = value!.toLowerCase().trim();
                      if (v.isEmpty) {
                        return "Please input a title.";
                      }
                      return null;
                    },
                    onSaved: (newValue) => title = newValue!,
                    decoration: const InputDecoration(
                      label: Text("Title"),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      border: InputBorder.none,
                      hintText: "Add Title",
                      hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                      ),
                      
                    autofocus: true,
                    style: const TextStyle(fontSize: 20, color: Colors.white70),
                  ),
            
                  TextFormField(
                    minLines: 1,
                    maxLines: null,
                    validator: (value) {
                      final v = value!.toLowerCase().trim();
                      if (v.isEmpty) {
                        return "Please input a description.";
                      }
                      return null;
                    },
                    onSaved: (newValue) => description = newValue!,
                    decoration: const InputDecoration(
                      label: Text("Description"),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      hintText: "Add Description",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      
                    ),
                    style: const TextStyle(color: Colors.white70, fontSize: 17),
                    
                  ),

                  const SizedBox(height: 6,),
                
                  DropdownMenuFormField(
                    enableFilter: true,
                    filterCallback: (all,current) {

                      catEntries = all;
                      
                      if (all.where((e) { 
                        if(e.label.toLowerCase() == current.toLowerCase()) { 
                          return true; 
                        } 
                        return false; 
                      }).isEmpty) {
                          text = current; 
                        } else {
                           text = ""; 
                        } if (current.trim().isEmpty) {
                          return all; 
                        } 
            
            
                        return all.where((entry){ if (entry.value == "add") {
                          return true; 
                        } 
                        return entry.label.toLowerCase().contains(
                          current.trim().toLowerCase()
                        ); 
                        }).toList(); },
                    enableSearch: true,
                    requestFocusOnTap: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select an option";
                      }
                      final t = control.text.trim();
                      if (categories.where((v) {
                        if ('Value_$t' == value) return true;
                        return false;
                      }).isEmpty) {
                        return "Please select an option from the dropdown";
                      }
                      return null;
                    },
                    onSaved: (newValue) => category = newValue!,
                    label: const Text("Category", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    expandedInsets: EdgeInsets.zero,
                    initialSelection: null,
                    controller: control,
                    onSelected: (value) {
                      if (value == "add") {
                        showDialog(context: context,builder: (context) => AddCategory(func: addCategory, value:text, control: control, all:categories), barrierDismissible: false);
                      }
                    },
                    textStyle: const TextStyle(color: Colors.white70),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: "add", label: "Add Category", style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.grey))),
                      ...categories.map((value) => DropdownMenuEntry(value: "Value_$value", label: value)),
                      ]),
            
                  const SizedBox(height: 10,),

                  DropdownMenuFormField(
                    label: const Text("Feasibility", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select an option";
                      }
                      return null;
                    },
                    onSaved: (newValue) => feasibility = newValue!,
                    textStyle: const TextStyle( color: Colors.white70),
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "1", label: "1: Not Feasible"),
                      DropdownMenuEntry(value: "2", label: "2: Probable Not Feasible"),
                      DropdownMenuEntry(value: "3", label: "3: Possibly Feasible"),
                      DropdownMenuEntry(value: "4", label: "4: Probably Feasible"),
                      DropdownMenuEntry(value: "5", label: "5: Very Feasible"),
                    ]
                  )
              ],
            ),
          ),
        ),
      )
    );
  }
}