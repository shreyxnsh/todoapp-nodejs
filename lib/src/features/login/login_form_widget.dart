import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_nodejs/main.dart';
import 'package:todo_nodejs/src/features/dashboard/dashboard.dart';
import 'package:todo_nodejs/src/features/login/login_screen.dart';
import '../../../constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:todo_nodejs/config/config.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // controllers to take user input into a string and check w the database
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isNotValidate = false;

  // creating shared preferences for login
  late SharedPreferences preferences;

  bool showSpinner = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async{
    preferences = await SharedPreferences.getInstance();
  }

  void loginUser() async{
    // check if user has added data
    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){

      // creating an object of registration body
      var regBody = {
        //json format
        "email":_emailController.text,
        "password":_passwordController.text
      };

      // http [post] request sent to api
      var response = await http.post(Uri.parse(loginUrl),
      headers: {"Content-type":"application/json"},
      body: jsonEncode(regBody)
      );

      //getting the response by the server
      var jsonResponse = jsonDecode(response.body);

      if(jsonResponse['status']){
        
        var myToken = jsonResponse['token'];
        preferences.setString('token', myToken);
        
        // passing token data to dashboard screen
        Get.to(DashboardScreen(token: myToken,));

      }else{
        print("Something went wrong");
      };
    }

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.symmetric(vertical: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              // controller takes the user input to check with the database
              controller: _emailController,
              onFieldSubmitted: (value) {
                // i want to add focus on password field after user enters email
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline_outlined,
                    color: tSecondaryColor,
                  ),
                  labelText: 'Email',
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: tSecondaryColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.0, color: tSecondaryColor))),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              // controller takes the user input to check with the database
              controller: _passwordController,

              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.fingerprint,
                    color: tSecondaryColor,
                  ),
                  labelText: 'Password',
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: tSecondaryColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2.0, color: tSecondaryColor)),
                  suffixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.remove_red_eye_sharp),
                  )),
            ),
            SizedBox(
              height: 10.0,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {}, child: Text('Forgot password ?'))),
            
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 20, left: 20, right: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        tSecondaryColor), // Change the button color here
                  ),
                  onPressed: () async {
                    loginUser();
                  },
                  child: Text(
                    'Login'.toUpperCase(),
                    style: TextStyle(fontFamily: 'PoppinsMedium', fontSize: 14),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
