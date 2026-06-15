import 'package:flutter/material.dart';
import 'package:ideas_app/New_Idea/new_idea_app_bar.dart';
import 'package:ideas_app/New_Idea/new_idea_body.dart';
import 'package:ideas_app/body.dart';

class Add extends StatefulWidget {
  const Add({super.key, required this.bodykey});
  final GlobalKey<BodyState> bodykey;

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final formKey = GlobalKey<FormState>();
  final niBodyKey = GlobalKey<NIBodyState>();

  @override
  Widget build(BuildContext context) {
    void continueClick() {
    if(formKey.currentState!.validate()) {
      formKey.currentState!.save();
      widget.bodykey.currentState!.addIdea(niBodyKey.currentState!.buildIdea());
      Navigator.pop(context);
    }
  }

    return Scaffold(
      appBar: NIAppBar(continueClick: continueClick,),
      body: NIBody(key:niBodyKey, formKey: formKey),
    );
  }
}