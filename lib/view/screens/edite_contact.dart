import 'package:contact_app54/const.dart';
import 'package:contact_app54/contact_cubit/contact_cubit.dart';
import 'package:contact_app54/view/widgets/default_form_filed.dart';
import 'package:contact_app54/view/widgets/default_phone_form.dart';
import 'package:contact_app54/view/widgets/default_text.dart';
import 'package:flutter/material.dart';

import '../../local/local_database.dart';

class EditeContact extends StatelessWidget {
  Map contactId;
   EditeContact({super.key,required this.contactId});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key:formKey ,
          child: Column(
            children: [
              DefaultFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                hintText: "Name",
                validator: (value) {
                  if(value!.isEmpty){
                    return "must not be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              DefaultPhoneField(
                controller: phoneController,
                validator: (value) {
                  if(value!.isEmpty){
                    return "must not be empty";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){
                    ContactCubit.get(context).updateDataBase(id: contactId['id'],
                        name: nameController.text,
                        phoneNumber:phoneController.text );
                  }, child: DefaultText(text: "Save",)),
                  TextButton(onPressed: (){
                    Navigator.pop(context);

                  }, child: DefaultText(text: "Cancel",))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
