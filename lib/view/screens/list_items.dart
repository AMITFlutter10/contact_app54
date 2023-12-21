import 'package:contact_app54/view/screens/builder_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  List<Map>contacts=[];
   ItemList({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index)=> const SizedBox(height: 10,),
        itemCount: contacts.length,
        itemBuilder: (context, index)=>
            CardItem(contactModel: contacts[index]),
    );
  }
}
