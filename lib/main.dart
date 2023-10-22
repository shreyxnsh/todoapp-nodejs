import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_nodejs/src/features/dashboard/dashboard.dart';
import 'package:todo_nodejs/src/features/login/login_screen.dart';
import '../../../constants/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // passing the token to the app so that if session is expired then we can send
  // back to login page
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final token = preferences.getString('token');

  runApp(MyApp(token: token,));
}

class MyApp extends StatelessWidget {

  final String? token;

  const MyApp({
    @required this.token,
    Key? key,
  }) : super(key: key);

@override
  Widget build(BuildContext context) {
    // for logging out the user
    if (token == null || JwtDecoder.isExpired(token!)) {
      // Token is null or expired, navigate to the login screen
      return GetMaterialApp(
        theme: ThemeData(
        primaryColor: tPrimaryColor,

      ),
        home: LoginScreen(),
        // ...other properties
      );
    } else {
      // Token is valid, show the dashboard
      return GetMaterialApp(
        home: DashboardScreen(token: token),
        // ...other properties
      );
    }
  }
}
