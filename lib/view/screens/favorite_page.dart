import 'package:contact_app54/contact_cubit/contact_cubit.dart';
import 'package:contact_app54/contact_cubit/contact_state.dart';
import 'package:contact_app54/view/screens/builder_item.dart';
import 'package:contact_app54/view/screens/list_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../local/local_database.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactCubit, ContactState>(
      builder: (context, state) {
        return ItemList(contacts: ContactCubit
            .get(context)
            .favoriteList,);
      },
    );

    // ListView.builder(itemBuilder: (context, index)=>
    //   CardItem(contactModel:favoriteList[index],));
  }
}