
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo_nodejs/src/features/login/login_screen.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';


import 'register_form_widget.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});



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
                  Text('Hey There!', style: TextStyle(fontFamily: 'PoppinsBold', fontSize: 22, ),),
                  Text('Register to get into the future!', style: TextStyle(fontFamily: 'PoppinsMedium', fontSize: 16, ),),
            
                  // section 2
                  RegisterForm(),
            
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
                      TextButton(
                        onPressed: (){
                        //   Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>  LoginScreen()),
                        // );

                        Navigator.push(
                          context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return LoginScreen();
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var begin = Offset(-1.0, 0.0);
                  var end = Offset.zero;
                  var tween = Tween(begin: begin, end: end);
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                    },
                    transitionDuration: Duration(milliseconds: 200),
              ),
                
                        );
              
                        },  
                      child: const Text.rich(
                        TextSpan(
                          text: "Already have an account?",style: TextStyle(fontFamily: 'PoppinsMedium', color: tSecondaryColor),
                          children: [
                            TextSpan(text: ' Login',
                            style: TextStyle(fontFamily: 'PoppinsMedium', color: Colors.blue))
                          ]
                        )
                        
                        )
                        )
                    
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