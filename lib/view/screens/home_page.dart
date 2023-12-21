import 'dart:ui';

import 'package:contact_app54/const.dart';
import 'package:contact_app54/contact_cubit/contact_cubit.dart';
import 'package:contact_app54/contact_cubit/contact_state.dart';
import 'package:contact_app54/view/screens/contact_page.dart';
import 'package:contact_app54/local/local_database.dart';
import 'package:contact_app54/view/screens/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/default_form_filed.dart';
import '../widgets/default_phone_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ContactCubit cubit;
  @override
  void initState() {
    cubit = ContactCubit.get(context);
    cubit.createDataBase();
    super.initState();
  }

  List<String> titleAppBar = ["Contacts", "Favorite"];
  List<Widget> screens = [ContactsScreen(), FavoriteScreen()];
  // int currentIndex = 0;

  bool isBottomSheet = false;
  IconData icons = Icons.add;
  void changeBottomSheet({required IconData icon, required bool isShow}) {
    setState(() {
      isBottomSheet = isShow;
      icons = icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactCubit, ContactState>(
      listener: (context, state) {
        if (state is InsertDataSuccessContactState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is GetDataLoadingContactState) {
          CircularProgressIndicator();
        }
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(titleAppBar[cubit.currentIndex]),
          ),
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () async {
              if (isBottomSheet) {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    cubit.insertDataBase(
                        name: nameController.text,
                        phoneNumber: phoneController.text);
                  });
                }
              } else
                changeBottomSheet(icon: Icons.add_box_outlined, isShow: true);
              scaffoldKey.currentState!
                  .showBottomSheet((context) {
                    return Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            DefaultFormField(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              hintText: "Name",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "must not be empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DefaultPhoneField(
                              controller: phoneController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "must not be empty";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                  .closed
                  .then((value) {
                    changeBottomSheet(icon: Icons.add, isShow: false);
                  });
            },
            child: Icon(icons),
          ),
          body: screens[cubit.currentIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeNavi(index);
              // setState(() {
              //   currentIndex = index;
              // });
            },
            // backgroundColor: Colors.deepPurple,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.contacts), label: titleAppBar[0]),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: titleAppBar[1]),
            ],
          ),
        );
      },
    );
  }
}
