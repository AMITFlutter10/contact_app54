import 'package:contact_app54/contact_cubit/contact_cubit.dart';
import 'package:contact_app54/contact_cubit/contact_state.dart';
import 'package:contact_app54/view/screens/builder_item.dart';
import 'package:contact_app54/view/screens/list_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../local/local_database.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Map> contact=[];
  @override
  void initState() {
   contact= ContactCubit.get(context).contactsList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactCubit,ContactState>(
        builder:(context, state)=> ItemList(contacts:contact,));

      // ListView.builder(itemBuilder: (context, index)=>
      //   CardItem(contactModel: contactsList[index],));
  }
}
