import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key, required this.func, required this.value, required this.control, required this.all});
  final void Function(String) func;
  final String? value;
  final TextEditingController control;
  final List<String> all;

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {

  final _formKey = GlobalKey<FormState>();
   String newName = "";

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: const Color.fromARGB(255, 44, 44, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("New Category",style: TextStyle(color: Colors.white, fontSize: 24)),
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    initialValue: widget.value,
                    decoration: const InputDecoration(hintText: "Category Name"),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Category name cannot be blank.";
                      }
                      if (value.toLowerCase().trim() == "add category") {
                        return "Invalid category name.";
                      }
                      if (widget.all.contains(value.trim())) {
                        return "That category already exists.";
                      }
                      return null;
                    },
                    onSaved: (V) => newName = V!,
                    ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    TextButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        widget.func(newName);
                        Navigator.pop(context);
                        widget.control.text = "";
                      }
                    }, child: const Text("Add")),
            
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                      widget.control.text = "";
                    }, child: const Text("Cancel"))]
                )
               
                ],
            ),
          ),
        )
        );
  }
}