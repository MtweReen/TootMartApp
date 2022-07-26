import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';

import 'componnent/body.dart';

class SubCategoryScreen extends StatefulWidget {
   final String image;
  final String name;
  final int id;
  const SubCategoryScreen({Key? key, required this.image, required this.name, required this.id}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: widget.name,
          context: context,
          press: () => Navigator.pop(context)),
          body:  SubCategoryBody(
            name: widget.name,
            image: widget.image,
            id: widget.id,
          ),
    );
  }
}
