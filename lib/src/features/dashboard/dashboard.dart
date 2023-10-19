import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_nodejs/src/features/login/login_screen.dart';

class DashboardScreen extends StatefulWidget {

  // these two lines will make sure that only if token is there, then the user can login
  final token;
  const DashboardScreen({@required this.token, Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  late String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken['email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(email),
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
)
        ],
      ),
    );
  }
}