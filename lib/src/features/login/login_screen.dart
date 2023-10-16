
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';


import 'login_form_widget.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: tDefaultSize, left: tDefaultSize, right: tDefaultSize),
            child: Padding(
              // padding: const EdgeInsets.all(8.0),
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // section 1
                  Center(child: Image(image: AssetImage(tLoginScreenImage), height: size.height*0.3,)),
                  Text('Welcome back!', style: TextStyle(fontFamily: 'PoppinsBold', fontSize: 22, ),),
                  Text('Login to experience hassle-free appointments', style: TextStyle(fontFamily: 'PoppinsMedium', fontSize: 16, ),),
            
                  // section 2
                  LoginForm(),
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('OR', style: TextStyle(fontFamily: 'PoppinsMedium', fontSize: 18),),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(tSecondaryColor), // Change the text color here
  ),
                          icon: Image(image: AssetImage(tGoogleLogo), width: 20.0,),
                          onPressed: (){}, label: Text('Sign-In with google'.toUpperCase(), style: TextStyle(fontFamily: 'PoppinsMedium', fontSize: 13),),
                      ),
                      ),
                    
                    ],
                  )
              ]
              ),
            ),
          ),
        ),
      ),
    );
  }

  
}