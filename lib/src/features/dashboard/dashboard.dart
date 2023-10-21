import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_nodejs/config/config.dart';
import 'package:todo_nodejs/src/features/login/login_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  // these two lines will make sure that only if token is there, then the user can login
  final token;
  const DashboardScreen({@required this.token, Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  
  late String userId;
  TextEditingController _todoTitle = TextEditingController();
  TextEditingController _todoDesc = TextEditingController();
  List? items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    // getting the user id of user from db by variable _id from tokenData
    userId = jwtDecodedToken['_id'];
  }

  // this function will send the http request to the backend server and save a todo for the user
  void addTodo() async{
    // check if user has added data
    if(_todoTitle.text.isNotEmpty && _todoDesc.text.isNotEmpty){

      // creating an object of todo creation api body
      var regBody = {
        //json format
        "userId": userId,
        "title":_todoTitle.text,
        "desc":_todoDesc.text
      };

      // http [post] request sent to api
      var response = await http.post(Uri.parse(addTodoUrl),
      headers: {"Content-type":"application/json"},
      body: jsonEncode(regBody)
      );

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);

      if(jsonResponse['status']){
        _todoTitle.clear();
        _todoDesc.clear();
        Navigator.pop(context);
      }else{
        print("Something went wrong");
      };
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              // Clear the token from SharedPreferences
              final preferences = await SharedPreferences.getInstance();
              preferences.remove('token');

              // Navigate back to the login screen
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text("Logout"),
          ),
          Expanded(
             child: Container(
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
               ),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: items == null ? null : ListView.builder(
                     itemCount: items!.length,
                     itemBuilder: (context,int index){
                       return Slidable(
                         key: const ValueKey(0),
                         endActionPane: ActionPane(
                           motion: const ScrollMotion(),
                           dismissible: DismissiblePane(onDismissed: () {}),
                           children: [
                             SlidableAction(
                               backgroundColor: Color(0xFFFE4A49),
                               foregroundColor: Colors.white,
                               icon: Icons.delete,
                               label: 'Delete',
                               onPressed: (BuildContext context) {
                                 print('${items![index]['_id']}');
                                //  deleteItem('${items![index]['_id']}');
                               },
                             ),
                           ],
                         ),
                         child: Card(
                           borderOnForeground: false,
                           child: ListTile(
                             leading: Icon(Icons.task),
                             title: Text('${items![index]['title']}'),
                             subtitle: Text('${items![index]['desc']}'),
                             trailing: Icon(Icons.arrow_back),
                           ),
                         ),
                       );
                     }
                 ),
               ),
             ),
           )
         ],
       ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>_displayTextInputDialog(context) ,
        child: Icon(Icons.add),
        tooltip: 'Add-ToDo',
      ),
    );
  }


  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add To-Do'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _todoTitle,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _todoDesc,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                ),
                ElevatedButton(onPressed: (){
                  addTodo();
                  }, child: Text("Add"))
              ],
            )
          );
        });

  }

}