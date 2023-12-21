import 'package:bloc/bloc.dart';
import 'package:contact_app54/contact_cubit/contact_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class ContactCubit extends Cubit<ContactState>{
  ContactCubit(): super(InitialContactState());
 static  ContactCubit get(context)=> BlocProvider.of(context);

  int currentIndex = 0;

  changeNavi(int index){
    currentIndex =index;
    emit(ChangNavContactState());
  }









 // 1- loading
//  2- success
//  3- error

  late Database database;

  createDataBase()async {
    // Get a location using getDatabasesPath
    var dataPath = await getDatabasesPath();
    print(dataPath);
    String path = join(dataPath, "contact.db");
    print(path);
    // open
    database = await openDatabase(path, version: 1,
        onCreate: (db, version) {
          db.execute(
              'CREATE TABLE Contacts (id INTEGER PRIMARY KEY, name TEXT, phoneNumber TEXT, type TEXT )')
              .then((value) {
            print("Table crated ");
          }).catchError((error) {
            print(error);
          });
        },
        onOpen: (db) {

          getDataBase(db);
          print("DataBase opened");
        }
    );
  }

  insertDataBase({required String name ,required String phoneNumber})async{
    await database.transaction((txn) {
      return txn.rawInsert('INSERT INTO Contacts (name, phoneNumber,type) VALUES("$name","$phoneNumber","all")').
      then((value) {
        emit(InsertDataSuccessContactState());
        print("$value record inserted");
        getDataBase(database);
      }).catchError((error){
       emit(InsertDataErrorContactState());
        print(error);
      });
    });
  }

  updateDataBase({required int id , required String name , required String phoneNumber })async{
    await database.rawUpdate('UPDATE Contacts SET name = ?, phoneNumber = ? WHERE id = ?',
        [name, phoneNumber, id]).then((value) {
      print("$value update");
      getDataBase(database);
      emit(UpdateSuccessContactState());
    }).catchError((error){
      emit(UpdateErrorContactState());
      print(error);
    });
  }

// update type
  addOrRemoveFavorite({required String type , required int id})async{
    await database.rawUpdate('UPDATE Contacts SET type = ? WHERE id = ?',
        [type, id]).then((value) {
      print("$value update type");
      emit(UpdateFavoriteSuccessContactState());
      getDataBase(database);
    }).catchError((error){
      emit(UpdateFavoriteErrorContactState());
      print("type updated");
    });
  }

// delete
  deleteContact({required int id})async{
    await database.rawDelete('DELETE FROM Contacts WHERE id = ?', [id]).then((value) {
      print("$value is deleted");
      emit(DeleteDataSuccessContactState());
      getDataBase(database);
    }).catchError((error){
      emit(DeleteDataErrorContactState());
      print(error);
    });
  }
  List<Map>contactsList=[];
  List<Map>favoriteList=[];

  getDataBase(Database database){
    emit(GetDataLoadingContactState());
    contactsList.clear();
    favoriteList.clear();
    database.rawQuery('SELECT * FROM Contacts').then((value) {
      for(Map<String,Object?> element in value){
        contactsList.add(element);
        if(element['type'] == 'favorite'){
          favoriteList.add(element);
        }
      }
      emit(GetDataSuccessContactState());
    }).catchError((error){
      emit(GetDataErrorContactState());
      print(error);
    });
  }









}