import 'package:contact_app54/contact_cubit/contact_cubit.dart';
import 'package:contact_app54/view/screens/edite_contact.dart';
import 'package:contact_app54/view/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class CardItem extends StatelessWidget {
  Map contactModel;
   CardItem({super.key ,required this.contactModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (dismissed){
          ContactCubit.get(context).deleteContact(id: contactModel['id']);
          Fluttertoast.showToast(
              msg: "Deleted",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        },
        child: InkWell(
          onTap: (){
            Fluttertoast.showToast(
                msg: "Long touch for contact editing, Swipe left or right to delete,"
                   "and double touch for calling Contact.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          },
          onLongPress: (){
            showDialog(context: context, builder: (context)=> EditeContact(contactId:contactModel ,) ,
            );
          },
          onDoubleTap: ()async{
              Uri launcherPhone =Uri(
                scheme: 'tel' ,
                path: contactModel['phoneNumber']
              );
              await launchUrl(launcherPhone);
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient:const LinearGradient(
                end: AlignmentDirectional.centerStart,
                begin: AlignmentDirectional.bottomEnd,
                colors: [Colors.pink, Colors.purple]
              )
            ),
            child:
            // ListTile(
            //   leading: ,
            //   title: ,
            //   subtitle: ,
            //   trailing: ,
            // )
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultText(text: contactModel['name']
                      ,fontSize: 15,
                      color: Colors.white,
                    ),

                    DefaultText(text: contactModel['phoneNumber']
                    ,fontSize: 15,
                      color: Colors.white,
                    ),

                  ],
                ),
                Visibility(
                  visible: contactModel['type']=='favorite',
                  replacement: IconButton(onPressed: ()
                    {ContactCubit.get(context).addOrRemoveFavorite(
                        type: 'favorite',
                        id: contactModel['id']);
                    },icon: const Icon(Icons.favorite,),),
                  child: IconButton(onPressed: ()
                  {ContactCubit.get(context).addOrRemoveFavorite(
                        type: 'all',
                        id: contactModel['id']);
                  },icon:const Icon(Icons.favorite,  color: Colors.red,)),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
